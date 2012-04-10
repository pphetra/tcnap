var rmAll = function() {
    vis.selectAll("line").data([]).exit().remove();
    vis.selectAll("circle.node").data([]).exit().remove();  
};

var update_visualize = function() {
    rmAll();

    var location_id = J('.select-tambol select option:selected').val();
    d3.json("/data/" + location_id, function(json) {

        J('.txt-tambol').text(J('.select-tambol option:selected').text());
        J('.txt-amphor').text(J('.select-amphor option:selected').text());
        J('.txt-province').text(J('.select-province option:selected').text());
        J('.txt-sum').text(json.sum);

        J('#person-list tbody').children('tr').remove();
        for (i in json.person) {
            var tr, td, person;
            if (json.person.hasOwnProperty(i) && json.person[i]) {
                person = json.person[i];

                tr = J("<tr>");
                tr
                    .append("<td>" + person.id + "</td>")
                    .append("<td>" + person.name + "</td>")
                    .append("<td>" + person.description + "</td>");

                J('#person-list tbody').append(tr);
            }
        }

        var force = d3.layout.force()
            .charge(-100)
            .linkDistance(function(l) { if (l.type == 'relative') { return 30; } return 50;})
            .nodes(json.nodes)
            .links(json.links)
            .size([w, h])
            .start();
        
        var link = vis.selectAll("line")
            .data(json.links)
            .enter().append('svg:line')
            .attr("class", function(d) { return "link_" + d.type; })
            .style("stroke_width", function(d) { return 2; })
            .attr('x1', function(d) { return d.source.x })
            .attr('y1', function(d) { return d.source.y })
            .attr('x2', function(d) { return d.target.x })
            .attr('y2', function(d) { return d.target.y });

        var node = vis.selectAll('circle.node')
            .attr("pointer-events", "all")

            .data(json.nodes)
            .enter().append('svg:circle')
            .attr('class', 'node')
            .attr('cs', function(d) { return d.x; })
            .attr('cy', function(d) { return d.y; })
            .attr('r', function(d) {
                groups[d.type] = fill(d.type);
                switch (d.type) {
                    case 'person':
                        return 8;
                    default:
                        return 15
                }
            })
            .style("fill", function(d) { return fill(d.type); })
            .attr("pointer-events", "all")
            .call(force.drag);

        node.append("svg:title")
            .text(function(d) { return d.name });

        force.on("tick", function() {
            link.attr("x1", function(d) { return d.source.x; })
                .attr("y1", function(d) { return d.source.y; })
                .attr("x2", function(d) { return d.target.x; })
                .attr("y2", function(d) { return d.target.y; });

            node.attr("cx", function(d) { return d.x; })
                .attr("cy", function(d) { return d.y; });
        });

        addLegend();
    });
};

function nodeDrag() {
    d3.event.stopPropagation();
    d3.event.preventDefault();
}

function redraw() {
  vis.attr("transform",
      "translate(" + d3.event.translate + ")"
      + " scale(" + d3.event.scale + ")");
}

var initLocationSelectList = function () {
    // Initial custom select.
    J('.customStyleSelectBox').customSelect();

    var
        province = J('.select-province select'),
        amphor = J('.select-amphor select'),
        tambol = J('.select-tambol select')
    ;

    // Hide amphor, tambol
    var hideAmphorOptions = function () {
        J('option[value]', amphor).removeAttr('selected');
        J('option[value=""]', amphor).attr('selected', 'selected');
        J('span span', '.select-amphor').text(J('option[value=""]', amphor).text());
        J('option[value!=""]', amphor).hide();
    };
    hideAmphorOptions();

    var hideTambolOptions = function () {
        J('option[value]', tambol).removeAttr('selected');
        J('option[value=""]', tambol).attr('selected', 'selected');
        J('span span', '.select-tambol').text(J('option[value=""]', tambol).text());
        J('option[value!=""]', tambol).hide();
    };
    hideTambolOptions();

    province.change(function (e) {
        var locId = J('option:selected', province).val();

        hideAmphorOptions();
        hideTambolOptions();
        if (locId) {
            J('option[value="' + locId + '"]', amphor).show();
        }
    }).change();

    amphor.change(function (e) {
        var locId = J('option:selected', amphor).val();

        hideTambolOptions();
        if (locId) {
            J('option[value="' + locId + '"]', tambol).show();
        }
    }).change();
};

var initSearchButton = function () {
    J('button#search').click(function(e) {
        e.preventDefault();
        if (J('.select-tambol option:selected').val().toString() !== "") {
            update_visualize();
        }
        else {
            alert("กรุณาเลือกตำบล");
        }
    });
};

var
    J = jQuery,
    w = 700,
    h = 600,
    fill,
    vis,
    groups = {},
    groupColor = [
        "#1f77b4",
        "#ff7f0e",
        "#2ca02c",
        "#d62728",
        "#9467bd",
        "#8c564b",
        "#e377c2",
        "#7f7f7f",
        "#bcbd22",
        "#17becf"
    ]
;

var initChart = function () {
    var customColor = function() {
      return d3.scale.ordinal().range(groupColor);
    };
    fill = customColor();

    vis = d3
            .select("#chart")
            .append('svg:svg')
            .attr('width', w)
            .attr('height', h)
            .attr("pointer-events", "zoom")
            .append('svg:g')
            .append('svg:g');


    vis.append('svg:rect')
        .attr('width', w)
        .attr('height', h)
        .attr('fill', 'white').call(d3.behavior.zoom().on("zoom", redraw));
};

var addLegend = function () {
    var legend = J('ul#legend');
    legend.children('li').remove();
    var item;

    for (i in groups) {
        if (groups.hasOwnProperty(i) && i !== "person" && groups[i]) {
            item = J("<li>")
                .css({ backgroundColor: groups[i] })
                .text(i);

            legend.append(item);
        }
    }
};

J(document).ready(function(){
    initChart();
    initLocationSelectList();
    initSearchButton();
});


