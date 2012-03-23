var rmAll = function() {
    vis.selectAll("line").data([]).exit().remove();
    vis.selectAll("circle.node").data([]).exit().remove();  
};

var update_visualize = function() {
    rmAll();

    var location_id = d3.select('#location_input')[0][0].value;
    d3.json("/data/" + location_id, function(json) {

        var force = d3.layout.force()
            .charge(-120)
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
            .data(json.nodes)
            .enter().append('svg:circle')
            .attr('class', 'node')
            .attr('cs', function(d) { return d.x; })
            .attr('cy', function(d) { return d.y; })
            .attr('r', function(d) {
                switch (d.type) {
                    case 'person':
                        return 5;
                    default:
                        return 15
                }
            })
            .style("fill", function(d) { return fill(d.type); })
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
    });
}
