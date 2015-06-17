local Proxy             = require "layeredata"
Proxy.hyper_multi_graph = require "formalisms.hyper_multi_graph"
local layer             = Proxy.new {
  name = "hyper graph", 
}
local _                 = Proxy.placeholder


layer.hyper_graph_type = {
  __depends__ = {
    Proxy.hyper_multi_graph,
  },

  __refines__ = {
    _.hyper_multi_graph_type,
  },
  
  __meta__ = {
    edge_type = {
      __meta__ = {
        checks = {
          function ()
            -- TODO check same edges in table
          end,
        },
      },
    },
  },
}

return layer					
