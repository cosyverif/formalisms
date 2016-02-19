-- Automata
-- ========

-- An automaton is a graph where vertices are called "states", edges are
-- called "transitions", and edges are labeled with symbols.
-- These symbols are taken from an alphabet, represented by an enumeration.
--
-- See [here](http://www.cs.odu.edu/~toida/nerzic/390teched/regular/fa/nfa-definitions.html)

return function (Layer, automaton, ref)

  local meta     = Layer.key.meta
  local refines  = Layer.key.refines

  local graph            = Layer.require "cosy/formalism/graph"
  local labeled_edges    = Layer.require "cosy/formalism/graph.labeled.edges"
  local labeled_vertices = Layer.require "cosy/formalism/graph.labeled.vertices"
  local directed         = Layer.require "cosy/formalism/graph.directed"
  local binary_edges     = Layer.require "cosy/formalism/graph.binary_edges"
  local enumeration      = Layer.require "cosy/formalism/data.enumeration"

  automaton [refines] = {
    graph,
    directed,
    binary_edges,
    labeled_vertices,
    labeled_edges,
  }

  automaton.alphabet = {
    [refines] = {
      enumeration,
    }
  }

  automaton [meta].state_type = {
    [refines] = {
      ref [meta].vertex_type,
    },
    [meta] = {
      record = {
        identifier = false,
        initial    = { value_type = "boolean" },
        final      = { value_type = "boolean" },
      }
    }
  }

  automaton [meta].transition_type = {
    [refines] = {
      ref [meta].edge_type,
    },
    [meta] = {
      record = {
       letter = {
         value_type      = ref.alphabet [Layer.key.meta].symbol_type,
         value_container = ref.alphabet,
       },
     },
   },
  }

  automaton.states = {
    [refines] = {
      ref [meta].vertices,
    },
    [meta] = {
      collection = {
        value_type = ref [meta].state_type,
      }
    }
  }

  automaton.transitions = {
    [refines] = {
      ref [meta].edges,
    },
    [meta] = {
      collection = {
        value_type = ref [meta].transition_type,
      }
    }
  }

  automaton.vertices [refines] [#automaton.vertices [refines] + 1] = ref.states
  automaton.edges    [refines] [#automaton.edges    [refines] + 1] = ref.transitions

  return automaton

end
