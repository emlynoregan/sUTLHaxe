class Sutllib1 
{
	public static function get(): Array<Dynamic> 
	{
		return haxe.Json.parse(Sutllib1.getStr());
	};
	
	public static function getStr(): String 
	{
		return '
		{
		  "modeltotreeview": {
		    "&": "addmaps",
		    "map1": {
		      "id": "^@.node.id",
		      "text": "^@.node.name",
		      "state": {
		        "&": "switch",
		        "value": "^@.node.type",
		        "cases": [
		          [
		            [
		              "root",
		              "dist"
		            ],
		            {
		              "&": "if",
		              "cond": {
		                ":": {
		                  "&": "isinlist",
		                  "item": "children",
		                  "list": {
		                    "&": "keys",
		                    "map": "^@.node"
		                  }
		                }
		              },
		              "true": "open",
		              "false": "closed"
		            }
		          ],
		          "open"
		        ]
		      },
		      "attributes": {
		        "node": "^@.node"
		      }
		    },
		    "map2": {
		      "&": "if",
		      "cond": {
		        ":": "^@.node.children"
		      },
		      "true": {
		        ":": {
		          "&": "removenullattribs",
		          "map": {
		            "children": {
		              "&": "map_core",
		              "list": "^@.node.children",
		              "t": {
		                ":": {
		                  "&": "modeltotreeview",
		                  "node": "^@.item"
		                }
		              }
		            }
		          }
		        }
		      },
		      "false": {}
		    }
		  },
		  "hasitems_core_emlynoregan_com": {
		    "&": "if",
		    "cond": {
		      "\'": {
		        "&": "=",
		        "a": "list",
		        "b": {
		          "&": "type",
		          "value": "^@.list"
		        }
		      }
		    },
		    "true": {
		      "\'": {
		        "&": "if",
		        "cond": {
		          "\'": {
		            "&": ">",
		            "a": {
		              "&": "len",
		              "list": "^@.list"
		            },
		            "b": 0
		          }
		        },
		        "true": {
		          "\'": {
		            "&": "if",
		            "cond": {
		              "\'": {
		                "!": "^*.hasitems_core_emlynoregan_com",
		                "list": {
		                  "\'\'": {
		                    "&": "head",
		                    "b": "^@.list"
		                  }
		                }
		              }
		            },
		            "true": true,
		            "false": {
		              "\'": {
		                "!": "^*.hasitems_core_emlynoregan_com",
		                "list": {
		                  "\'\'": {
		                    "&": "tail",
		                    "b": "^@.list"
		                  }
		                }
		              }
		            }
		          }
		        },
		        "false": false
		      }
		    },
		    "false": {
		      "&": "!=",
		      "a": "^@.list",
		      "b": null
		    }
		  },
		  "filter_core_emlynoregan_com": {
		    "&": "reduce",
		    "list": "^@.list",
		    "accum": [],
		    "t": {
		      "\'": [
		        "&&",
		        "^@.accum",
		        {
		          "&": "if",
		          "cond": {
		            "\'": {
		              "\'\'": "^@.filter-t"
		            }
		          },
		          "true": [
		            "^@.item"
		          ],
		          "false": []
		        }
		      ]
		    }
		  },
		  "isinlist": {
		    "!": "^*.hasitems_core_emlynoregan_com",
		    "list": {
		      "!": "^*.filter_core_emlynoregan_com",
		      "list": "^@.list",
		      "filter-t": {
		        "\'": {
		          "&": "=",
		          "a": "^@.item",
		          "b": {
		            "\'\'": "^@.item"
		          }
		        }
		      }
		    }
		  },
		  "switch": [
		    "^%",
		    {
		      "&": "reduce",
		      "list": "^@.cases",
		      "accum": {
		        "found": false,
		        "result": null
		      },
		      "t": {
		        "\'": {
		          "&": "if",
		          "cond": {
		            "\'": "^@.accum.found"
		          },
		          "true": {
		            "\'": "^@.accum"
		          },
		          "false": {
		            "\'": {
		              "&": "if",
		              "cond": {
		                "\'": [
		                  "&&&",
		                  [
		                    "&=",
		                    {
		                      "&": "type",
		                      "value": "^@.item"
		                    },
		                    "list"
		                  ],
		                  [
		                    "&=",
		                    {
		                      "&": "len",
		                      "list": "^@.item"
		                    },
		                    2
		                  ]
		                ]
		              },
		              "true": {
		                "\'": {
		                  "&": "if",
		                  "cond": {
		                    "\'": [
		                      "&=",
		                      {
		                        "&": "type",
		                        "value": "^@.item.0"
		                      },
		                      "list"
		                    ]
		                  },
		                  "true": {
		                    "\'": {
		                      "&": "if",
		                      "cond": {
		                        "\'": {
		                          "!": "^*.isinlist",
		                          "list": "^@.item.0",
		                          "item": "^@.value"
		                        }
		                      },
		                      "true": {
		                        "\'": {
		                          "found": true,
		                          "result": "^@.item.1"
		                        }
		                      },
		                      "false": {
		                        "\'": "^@.accum"
		                      }
		                    }
		                  },
		                  "false": {
		                    "\'": {
		                      "&": "if",
		                      "cond": {
		                        "\'": [
		                          "&=",
		                          "^@.item.0",
		                          "^@.value"
		                        ]
		                      },
		                      "true": {
		                        "\'": {
		                          "found": true,
		                          "result": "^@.item.1"
		                        }
		                      },
		                      "false": {
		                        "\'": "^@.accum"
		                      }
		                    }
		                  }
		                }
		              },
		              "false": {
		                "\'": {
		                  "found": true,
		                  "result": "^@.item"
		                }
		              }
		            }
		          }
		        }
		      }
		    },
		    "result"
		  ],
		  "head_core_emlynoregan_com": [
		    "&head",
		    "^@.list"
		  ],
		  "tail_core_emlynoregan_com": [
		    "&tail",
		    "^@.list"
		  ],
		  "foldone_core_emlynoregan_com": {
		    "!": "^*.head_core_emlynoregan_com",
		    "list": {
		      "&": "reduce",
		      "accum": [
		        [],
		        "^@.lists"
		      ],
		      "list": "^@.list",
		      "t": {
		        "\'": [
		          [
		            "&&",
		            "^@.accum.0",
		            [
		              [
		                "&&",
		                {
		                  "&": "if",
		                  "cond": {
		                    "\'": {
		                      "&": "len",
		                      "list": "^@.accum.1"
		                    }
		                  },
		                  "true": {
		                    "!": "^*.head_core_emlynoregan_com",
		                    "list": "^@.accum.1"
		                  },
		                  "false": []
		                },
		                [
		                  "^@.item"
		                ]
		              ]
		            ]
		          ],
		          {
		            "!": "^*.tail_core_emlynoregan_com",
		            "list": "^@.accum.1"
		          }
		        ]
		      }
		    }
		  },
		  "zip_core_emlynoregan_com": {
		    "&": "reduce",
		    "list": "^@.list",
		    "accum": [],
		    "t": {
		      "\'": {
		        "!": "^*.foldone_core_emlynoregan_com",
		        "lists": "^@.accum",
		        "list": "^@.item"
		      }
		    }
		  },
		  "addmaps": {
		    "&": "makemap",
		    "value": {
		      "!": "^*.zip_core_emlynoregan_com",
		      "list": [
		        [
		          "&&",
		          {
		            "&": "keys",
		            "map": "^@.map1"
		          },
		          {
		            "&": "keys",
		            "map": "^@.map2"
		          }
		        ],
		        [
		          "&&",
		          {
		            "&": "values",
		            "map": "^@.map1"
		          },
		          {
		            "&": "values",
		            "map": "^@.map2"
		          }
		        ]
		      ]
		    }
		  },
		  "map_core_emlynoregan_com": {
		    "&": "reduce",
		    "list": "^@.list",
		    "map-t": "^@.t",
		    "t": {
		      "\'": [
		        "&&",
		        "^@.accum",
		        [
		          {
		            "!": "^@.map-t"
		          }
		        ]
		      ]
		    },
		    "accum": []
		  },
		  "mapget_core_emlynoregan_com": [
		    "^@",
		    "map",
		    [
		      "^@",
		      "key"
		    ]
		  ],
		  "splitmap_core_emlynoregan_com": {
		    "!": "^*.map_core_emlynoregan_com",
		    "list": {
		      "&": "keys",
		      "map": "^@.map"
		    },
		    "t": {
		      "\'": {
		        "&": "makemap",
		        "value": [
		          [
		            "^@.item",
		            {
		              "!": "^*.mapget_core_emlynoregan_com",
		              "map": {
		                "\'\'": "^@.map"
		              },
		              "key": "^@.item"
		            }
		          ]
		        ]
		      }
		    }
		  },
		  "removenovaluemaps_core_emlynoregan_com": {
		    "!": "^*.filter_core_emlynoregan_com",
		    "list": {
		      "!": "^*.splitmap_core_emlynoregan_com",
		      "map": "^@.map"
		    },
		    "filter-t": {
		      "\'": {
		        "&": "!=",
		        "a": {
		          "!": "^*.head_core_emlynoregan_com",
		          "list": {
		            "&": "values",
		            "map": "^@.item"
		          }
		        },
		        "b": null
		      }
		    }
		  },
		  "addmaps_core_emlynoregan_com": {
		    "&": "makemap",
		    "value": {
		      "!": "^*.zip_core_emlynoregan_com",
		      "list": [
		        [
		          "&&",
		          {
		            "&": "keys",
		            "map": "^@.map1"
		          },
		          {
		            "&": "keys",
		            "map": "^@.map2"
		          }
		        ],
		        [
		          "&&",
		          {
		            "&": "values",
		            "map": "^@.map1"
		          },
		          {
		            "&": "values",
		            "map": "^@.map2"
		          }
		        ]
		      ]
		    }
		  },
		  "removenullattribs": {
		    "&": "reduce",
		    "accum": {},
		    "list": {
		      "!": "^*.removenovaluemaps_core_emlynoregan_com",
		      "map": "^@.map"
		    },
		    "t": {
		      "\'": {
		        "!": "^*.addmaps_core_emlynoregan_com",
		        "map1": "^@.accum",
		        "map2": "^@.item"
		      }
		    }
		  },
		  "map_core": {
		    "&": "reduce",
		    "list": "^@.list",
		    "map-t": "^@.t",
		    "t": {
		      "\'": [
		        "&&",
		        "^@.accum",
		        [
		          {
		            "!": "^@.map-t"
		          }
		        ]
		      ]
		    },
		    "accum": []
		  }
		}
		';
	}
}