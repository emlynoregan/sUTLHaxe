class Sutlcore 
{
	public static function get(): Array<Dynamic> 
	{
		return haxe.Json.parse(Sutlcore.getStr());
	};
	
	public static function getStr(): String 
	{
		return '
		[
		  {
		    "transform-t": {
		      "map-t": "^@.t", 
		      "accum": [], 
		      "list": "^@.list", 
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
		      "&": "reduce"
		    }, 
		    "name": "map_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "requires": [
		      "reverse_core_emlynoregan_com"
		    ], 
		    "transform-t": {
		      "true": {
		        "\'": [
		          "&&", 
		          {
		            "!": "^*.reverse_core_emlynoregan_com", 
		            "list": [
		              "&tail", 
		              "^@.list"
		            ]
		          }, 
		          [
		            "&head", 
		            "^@.list"
		          ]
		        ]
		      }, 
		      "false": {
		        "\'": []
		      }, 
		      "cond": "^@.list", 
		      "&": "if"
		    }, 
		    "name": "reverse_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "transform-t": {
		      "accum": [], 
		      "list": "^@.list", 
		      "t": {
		        "\'": {
		          "true": {
		            "\'": [
		              "&&", 
		              "^@.accum", 
		              "^@.item"
		            ]
		          }, 
		          "false": {
		            "\'": "^@.accum"
		          }, 
		          "cond": {
		            "\'": [
		              "&!=", 
		              "^@.item", 
		              null
		            ]
		          }, 
		          "&": "if"
		        }
		      }, 
		      "&": "reduce"
		    }, 
		    "name": "removenulls_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "requires": [
		      "count_core_emlynoregan_com"
		    ], 
		    "transform-t": {
		      "true": {
		        "\'": {
		          "accum": 0, 
		          "list": "^@.obj", 
		          "t": {
		            "\'": {
		              "a": {
		                "!": "^*.count_core_emlynoregan_com", 
		                "obj": "^@.item"
		              }, 
		              "b": "^@.accum", 
		              "&": "+"
		            }
		          }, 
		          "&": "reduce"
		        }
		      }, 
		      "false": 1, 
		      "cond": {
		        "\'": {
		          "a": "list", 
		          "b": {
		            "value": "^@.obj", 
		            "&": "type"
		          }, 
		          "&": "="
		        }
		      }, 
		      "&": "if"
		    }, 
		    "name": "count_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "transform-t": {
		      "b": {
		        "list": "^@.list", 
		        "accum": [
		          [], 
		          "^@.lists"
		        ], 
		        "t": {
		          ":": [
		            [
		              "&&", 
		              "^@.accum.0", 
		              [
		                [
		                  "&&", 
		                  {
		                    "true": {
		                      "b": "^@.accum.1", 
		                      "&": "head"
		                    }, 
		                    "false": [], 
		                    "cond": {
		                      ":": {
		                        "list": "^@.accum.1", 
		                        "&": "len"
		                      }
		                    }, 
		                    "&": "if"
		                  }, 
		                  [
		                    "^@.item"
		                  ]
		                ]
		              ]
		            ], 
		            {
		              "b": "^@.accum.1", 
		              "&": "tail"
		            }
		          ]
		        }, 
		        "&": "reduce"
		      }, 
		      "&": "head"
		    }, 
		    "name": "foldone_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "requires": [
		      "foldone_core"
		    ], 
		    "transform-t": {
		      "accum": [], 
		      "list": "^@.list", 
		      "t": {
		        "\'": {
		          "list": "^@.item", 
		          "lists": "^@.accum", 
		          "&": "foldone_core"
		        }
		      }, 
		      "&": "reduce"
		    }, 
		    "name": "zip_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "requires": [
		      "zip"
		    ], 
		    "transform-t": {
		      "value": {
		        "list": [
		          [
		            "&&", 
		            {
		              "map": "^@.map1", 
		              "&": "keys"
		            }, 
		            {
		              "map": "^@.map2", 
		              "&": "keys"
		            }
		          ], 
		          [
		            "&&", 
		            {
		              "map": "^@.map1", 
		              "&": "values"
		            }, 
		            {
		              "map": "^@.map2", 
		              "&": "values"
		            }
		          ]
		        ], 
		        "&": "zip"
		      }, 
		      "&": "makemap"
		    }, 
		    "name": "addmaps_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "transform-t": [
		      "^@", 
		      "map", 
		      [
		        "^@", 
		        "key"
		      ]
		    ], 
		    "name": "mapget_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "requires": [
		      "map_core"
		    ], 
		    "transform-t": {
		      "value": {
		        "list": "^@.list", 
		        "t": {
		          "\'": [
		            "^@.item", 
		            true
		          ]
		        }, 
		        "&": "map_core"
		      }, 
		      "&": "makemap"
		    }, 
		    "name": "keys2map_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "transform-t": {
		      "accum": [], 
		      "list": "^@.list", 
		      "t": {
		        ":": [
		          "&&", 
		          "^@.accum", 
		          {
		            "true": [
		              {
		                ":": "^@.item"
		              }
		            ], 
		            "false": [], 
		            "cond": {
		              ":": {
		                "!": "^@.filter-t"
		              }
		            }, 
		            "&": "if"
		          }
		        ]
		      }, 
		      "&": "reduce"
		    }, 
		    "name": "filter_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "requires": [
		      "hasitems_core_emlynoregan_com"
		    ], 
		    "transform-t": {
		      "true": {
		        "\'": {
		          "true": {
		            "\'": {
		              "true": true, 
		              "false": {
		                "\'": {
		                  "!": "^*.hasitems_core_emlynoregan_com", 
		                  "list": {
		                    "\'\'": {
		                      "b": "^@.list", 
		                      "&": "tail"
		                    }
		                  }
		                }
		              }, 
		              "cond": {
		                "\'": {
		                  "!": "^*.hasitems_core_emlynoregan_com", 
		                  "list": {
		                    "\'\'": {
		                      "b": "^@.list", 
		                      "&": "head"
		                    }
		                  }
		                }
		              }, 
		              "&": "if"
		            }
		          }, 
		          "false": false, 
		          "cond": {
		            "\'": {
		              "a": {
		                "list": "^@.list", 
		                "&": "len"
		              }, 
		              "b": 0, 
		              "&": ">"
		            }
		          }, 
		          "&": "if"
		        }
		      }, 
		      "false": {
		        "a": "^@.list", 
		        "b": null, 
		        "&": "!="
		      }, 
		      "cond": {
		        "\'": {
		          "a": "list", 
		          "b": {
		            "value": "^@.list", 
		            "&": "type"
		          }, 
		          "&": "="
		        }
		      }, 
		      "&": "if"
		    }, 
		    "name": "hasitems_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "requires": [
		      "hasitems_core", 
		      "filter_core"
		    ], 
		    "transform-t": {
		      "list": {
		        "filter-t": {
		          "\'": {
		            "a": "^@.item", 
		            "b": "^@.outeritem", 
		            "&": "="
		          }
		        }, 
		        "list": "^@.list", 
		        "outeritem": "^@.item", 
		        "&": "filter_core"
		      }, 
		      "&": "hasitems_core"
		    }, 
		    "name": "isinlist_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "requires": [
		      "isinlist_core", 
		      "filter_core"
		    ], 
		    "transform-t": {
		      "filter-t": {
		        ":": [
		          "&!", 
		          {
		            "item": "^@.item", 
		            "list": "^@.arr2", 
		            "&": "isinlist_core"
		          }
		        ]
		      }, 
		      "list": "^@.arr1", 
		      "&": "filter_core"
		    }, 
		    "name": "subtractarrs_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "requires": [
		      "subtractarrs_core", 
		      "map_core", 
		      "mapget_core", 
		      "zip"
		    ], 
		    "transform-t": {
		      "value": {
		        "list": [
		          {
		            "arr2": "^@.keys", 
		            "arr1": {
		              "map": "^@.map", 
		              "&": "keys"
		            }, 
		            "&": "subtractarrs_core"
		          }, 
		          {
		            "list": {
		              "arr2": "^@.keys", 
		              "arr1": {
		                "map": "^@.map", 
		                "&": "keys"
		              }, 
		              "&": "subtractarrs_core"
		            }, 
		            "t": {
		              ":": {
		                "key": "^@.item", 
		                "&": "mapget_core"
		              }
		            }, 
		            "&": "map_core"
		          }
		        ], 
		        "&": "zip"
		      }, 
		      "&": "makemap"
		    }, 
		    "name": "removekeys_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "transform-t": {
		      "accum": "^@.item", 
		      "list": "^@.pipeline-t", 
		      "t": {
		        ":": {
		          "!": "^@.item", 
		          "item": "^@.accum", 
		          "accum": null
		        }
		      }, 
		      "&": "reduce"
		    }, 
		    "name": "pipeline_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "transform-t": {
		      "value": [
		        [
		          "^@.item", 
		          {
		            "!": [
		              "&&", 
		              {
		                ":": "^%"
		              }, 
		              {
		                "value": [
		                  [
		                    ":", 
		                    "^@.map"
		                  ]
		                ], 
		                "&": "makemap"
		              }, 
		              "^@.item"
		            ]
		          }
		        ]
		      ], 
		      "&": "makemap"
		    }, 
		    "name": "splitmapone_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "requires": [
		      "zip"
		    ], 
		    "transform-t": {
		      "list": [
		        {
		          "&": "keys"
		        }, 
		        {
		          "&": "values"
		        }
		      ], 
		      "&": "zip"
		    }, 
		    "name": "unmakemap_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "requires": [
		      "map_core", 
		      "splitmapone_core"
		    ], 
		    "transform-t": {
		      "list": {
		        "map": "^@.map", 
		        "&": "keys"
		      }, 
		      "t": "^*.splitmapone_core", 
		      "&": "map_core"
		    }, 
		    "name": "splitmap_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "requires": [
		      "filter_core", 
		      "splitmap_core"
		    ], 
		    "transform-t": {
		      "filter-t": {
		        ":": [
		          "&!=", 
		          [
		            "&head", 
		            {
		              "map": "^@.item", 
		              "&": "values"
		            }
		          ], 
		          null
		        ]
		      }, 
		      "list": {
		        "map": "^@.map", 
		        "&": "splitmap_core"
		      }, 
		      "&": "filter_core"
		    }, 
		    "name": "removenovaluemaps_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "requires": [
		      "removenovaluemaps_core", 
		      "addmaps_core"
		    ], 
		    "transform-t": {
		      "list": {
		        "map": "^@.map", 
		        "&": "removenovaluemaps_core"
		      }, 
		      "accum": {}, 
		      "t": {
		        ":": {
		          "map2": "^@.item", 
		          "map1": "^@.accum", 
		          "&": "addmaps_core"
		        }
		      }, 
		      "&": "reduce"
		    }, 
		    "name": "removenullattribs_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "requires": [
		      "zip"
		    ], 
		    "transform-t": {
		      "map": {
		        "value": {
		          "list": [
		            "^@.list", 
		            "^@.list"
		          ], 
		          "&": "zip"
		        }, 
		        "&": "makemap"
		      }, 
		      "&": "keys"
		    }, 
		    "name": "removedupstrarr_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "requires": [
		      "filter_core"
		    ], 
		    "transform-t": {
		      "filter-t": {
		        ":": [
		          "&=", 
		          [
		            "&!", 
		            [
		              "&!", 
		              "^@.left"
		            ]
		          ], 
		          [
		            "&<", 
		            {
		              "!": [
		                "&&", 
		                {
		                  ":": "^@"
		                }, 
		                [
		                  "item"
		                ], 
		                "^@.keypath"
		              ]
		            }, 
		            {
		              "!": [
		                "&&", 
		                {
		                  ":": "^@"
		                }, 
		                [
		                  "head"
		                ], 
		                "^@.keypath"
		              ]
		            }
		          ]
		        ]
		      }, 
		      "head": {
		        "b": "^@.list", 
		        "&": "head"
		      }, 
		      "list": {
		        "b": "^@.list", 
		        "&": "tail"
		      }, 
		      "&": "filter_core"
		    }, 
		    "name": "qsfilter_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "requires": [
		      "qsfilter_core", 
		      "quicksort_core_emlynoregan_com"
		    ], 
		    "transform-t": {
		      "true": {
		        ":": [
		          "&&", 
		          {
		            "list": {
		              "left": true, 
		              "list": "^@.list", 
		              "&": "qsfilter_core"
		            }, 
		            "&": "quicksort_core_emlynoregan_com"
		          }, 
		          [
		            {
		              "b": "^@.list", 
		              "&": "head"
		            }
		          ], 
		          {
		            "list": {
		              "left": false, 
		              "list": "^@.list", 
		              "&": "qsfilter_core"
		            }, 
		            "&": "quicksort_core_emlynoregan_com"
		          }
		        ]
		      }, 
		      "false": [], 
		      "cond": {
		        ":": "^@.list"
		      }, 
		      "&": "if"
		    }, 
		    "name": "quicksort_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "requires": [
		      "map_core"
		    ], 
		    "transform-t": {
		      "value": {
		        "t": {
		          ":": [
		            {
		              "!": [
		                "&&", 
		                {
		                  ":": "^%"
		                }, 
		                [
		                  "^@.item"
		                ], 
		                "^@.keypath"
		              ]
		            }, 
		            "^@.item"
		          ]
		        }, 
		        "&": "map_core"
		      }, 
		      "&": "makemap"
		    }, 
		    "name": "idlisttomap_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "transform-t": [
		      "^%", 
		      {
		        "!": {
		          "\'": {
		            "true": {
		              "\'": {
		                "accum": {
		                  "index": 0, 
		                  "result": ""
		                }, 
		                "list": "^@.list", 
		                "t": {
		                  "\'": {
		                    "true": {
		                      "\'": {
		                        "index": 1, 
		                        "result": "^@.item"
		                      }
		                    }, 
		                    "false": {
		                      "\'": {
		                        "true": {
		                          "\'": {
		                            "index": [
		                              "&+", 
		                              "^@.accum.index", 
		                              1
		                            ], 
		                            "result": [
		                              "&+", 
		                              "^@.accum.result", 
		                              "^@.lastseparator", 
		                              "^@.item"
		                            ]
		                          }
		                        }, 
		                        "false": {
		                          "\'": {
		                            "index": [
		                              "&+", 
		                              "^@.accum.index", 
		                              1
		                            ], 
		                            "result": [
		                              "&+", 
		                              "^@.accum.result", 
		                              "^@.separator", 
		                              "^@.item"
		                            ]
		                          }
		                        }, 
		                        "cond": {
		                          "\'": [
		                            "&=", 
		                            "^@.listlen", 
		                            [
		                              "&+", 
		                              "^@.accum.index", 
		                              1
		                            ]
		                          ]
		                        }, 
		                        "&": "if"
		                      }
		                    }, 
		                    "cond": {
		                      "\'": [
		                        "&=", 
		                        "^@.accum.index", 
		                        0
		                      ]
		                    }, 
		                    "&": "if"
		                  }
		                }, 
		                "&": "reduce"
		              }
		            }, 
		            "false": null, 
		            "cond": {
		              "\'": "^@.list"
		            }, 
		            "&": "if"
		          }
		        }, 
		        "lastseparator": {
		          "true": {
		            "\'": "^@.lastseparator"
		          }, 
		          "false": {
		            "\'": {
		              "true": {
		                "\'": "^@.separator"
		              }, 
		              "false": " and ", 
		              "cond": {
		                "\'": "^@.separator"
		              }, 
		              "&": "if"
		            }
		          }, 
		          "cond": {
		            "\'": "^@.lastseparator"
		          }, 
		          "&": "if"
		        }, 
		        "listlen": {
		          "list": "^@.list", 
		          "&": "len"
		        }, 
		        "separator": {
		          "true": {
		            "\'": "^@.separator"
		          }, 
		          "false": ", ", 
		          "cond": {
		            "\'": "^@.separator"
		          }, 
		          "&": "if"
		        }
		      }, 
		      "result"
		    ], 
		    "name": "join_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "transform-t": {
		      "!": {
		        ":": {
		          "!": {
		            ":": [
		              "^%", 
		              {
		                "accum": {
		                  "index": 0, 
		                  "result": []
		                }, 
		                "list": "^@.list", 
		                "t": {
		                  ":": {
		                    "true": {
		                      ":": {
		                        "index": [
		                          "&+", 
		                          "^@.accum.index", 
		                          1
		                        ], 
		                        "result": [
		                          "&&", 
		                          "^@.accum.result", 
		                          "^@.item"
		                        ]
		                      }
		                    }, 
		                    "false": {
		                      ":": {
		                        "index": [
		                          "&+", 
		                          "^@.accum.index", 
		                          1
		                        ], 
		                        "result": "^@.accum.result"
		                      }
		                    }, 
		                    "cond": {
		                      ":": [
		                        "&&&", 
		                        [
		                          "&>=", 
		                          "^@.accum.index", 
		                          "^@.start"
		                        ], 
		                        [
		                          "&<", 
		                          "^@.accum.index", 
		                          "^@.stop"
		                        ]
		                      ]
		                    }, 
		                    "&": "if"
		                  }
		                }, 
		                "&": "reduce"
		              }, 
		              "result"
		            ]
		          }, 
		          "start": {
		            "!": "^@.fixarg", 
		            "defaultarg": 0, 
		            "arg": "^@.start"
		          }, 
		          "stop": {
		            "!": "^@.fixarg", 
		            "defaultarg": {
		              "list": "^@.list", 
		              "&": "len"
		            }, 
		            "arg": "^@.stop"
		          }
		        }
		      }, 
		      "fixarg": {
		        ":": {
		          "true": {
		            ":": {
		              "true": {
		                ":": [
		                  "&+", 
		                  {
		                    "list": "^@.list", 
		                    "&": "len"
		                  }, 
		                  "^@.arg"
		                ]
		              }, 
		              "false": {
		                ":": "^@.arg"
		              }, 
		              "cond": {
		                ":": [
		                  "&<", 
		                  "^@.arg", 
		                  0
		                ]
		              }, 
		              "&": "if"
		            }
		          }, 
		          "false": "^@.defaultarg", 
		          "cond": {
		            ":": "^@.arg"
		          }, 
		          "&": "if"
		        }
		      }
		    }, 
		    "name": "slice_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "transform-t": {
		      "accum": null, 
		      "list": "^@.list", 
		      "t": {
		        "\'": {
		          "true": {
		            "\'": "^@.accum"
		          }, 
		          "false": {
		            "\'": "^@.item"
		          }, 
		          "cond": {
		            "\'": [
		              "&!=", 
		              "^@.accum", 
		              null
		            ]
		          }, 
		          "&": "if"
		        }
		      }, 
		      "&": "reduce"
		    }, 
		    "name": "coalesce_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "requires": [
		      "isinlist_core"
		    ], 
		    "transform-t": [
		      "^%", 
		      {
		        "accum": {
		          "found": false, 
		          "result": null
		        }, 
		        "list": "^@.cases", 
		        "t": {
		          "\'": {
		            "true": {
		              "\'": "^@.accum"
		            }, 
		            "false": {
		              "\'": {
		                "true": {
		                  "\'": {
		                    "true": {
		                      "\'": {
		                        "true": {
		                          "\'": {
		                            "found": true, 
		                            "result": "^@.item.1"
		                          }
		                        }, 
		                        "false": {
		                          "\'": "^@.accum"
		                        }, 
		                        "cond": {
		                          "\'": {
		                            "!": "^*.isinlist_core", 
		                            "item": "^@.value", 
		                            "list": "^@.item.0"
		                          }
		                        }, 
		                        "&": "if"
		                      }
		                    }, 
		                    "false": {
		                      "\'": {
		                        "true": {
		                          "\'": {
		                            "found": true, 
		                            "result": "^@.item.1"
		                          }
		                        }, 
		                        "false": {
		                          "\'": "^@.accum"
		                        }, 
		                        "cond": {
		                          "\'": [
		                            "&=", 
		                            "^@.item.0", 
		                            "^@.value"
		                          ]
		                        }, 
		                        "&": "if"
		                      }
		                    }, 
		                    "cond": {
		                      "\'": [
		                        "&=", 
		                        {
		                          "value": "^@.item.0", 
		                          "&": "type"
		                        }, 
		                        "list"
		                      ]
		                    }, 
		                    "&": "if"
		                  }
		                }, 
		                "false": {
		                  "\'": {
		                    "found": true, 
		                    "result": "^@.item"
		                  }
		                }, 
		                "cond": {
		                  "\'": [
		                    "&&&", 
		                    [
		                      "&=", 
		                      {
		                        "value": "^@.item", 
		                        "&": "type"
		                      }, 
		                      "list"
		                    ], 
		                    [
		                      "&=", 
		                      {
		                        "list": "^@.item", 
		                        "&": "len"
		                      }, 
		                      2
		                    ]
		                  ]
		                }, 
		                "&": "if"
		              }
		            }, 
		            "cond": {
		              "\'": "^@.accum.found"
		            }, 
		            "&": "if"
		          }
		        }, 
		        "&": "reduce"
		      }, 
		      "result"
		    ], 
		    "name": "switch_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "transform-t": [
		      "^%", 
		      {
		        "accum": {
		          "found": false, 
		          "result": null
		        }, 
		        "list": "^@.cases", 
		        "t": {
		          "\'": {
		            "true": {
		              "\'": "^@.accum"
		            }, 
		            "false": {
		              "\'": {
		                "true": {
		                  "\'": {
		                    "true": {
		                      "\'": {
		                        "found": true, 
		                        "result": {
		                          "!": "^@.item.1"
		                        }
		                      }
		                    }, 
		                    "false": {
		                      "\'": "^@.accum"
		                    }, 
		                    "cond": {
		                      "\'": {
		                        "!": {
		                          "!": "^@.item.0"
		                        }
		                      }
		                    }, 
		                    "&": "if"
		                  }
		                }, 
		                "false": {
		                  "\'": {
		                    "found": true, 
		                    "result": {
		                      "!": "^@.item"
		                    }
		                  }
		                }, 
		                "cond": {
		                  "\'": [
		                    "&&&", 
		                    [
		                      "&=", 
		                      {
		                        "value": "^@.item", 
		                        "&": "type"
		                      }, 
		                      "list"
		                    ], 
		                    [
		                      "&=", 
		                      {
		                        "list": "^@.item", 
		                        "&": "len"
		                      }, 
		                      2
		                    ]
		                  ]
		                }, 
		                "&": "if"
		              }
		            }, 
		            "cond": {
		              "\'": "^@.accum.found"
		            }, 
		            "&": "if"
		          }
		        }, 
		        "&": "reduce"
		      }, 
		      "result"
		    ], 
		    "name": "when_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "transform-t": [
		      "&=", 
		      {
		        "value": "^@.item", 
		        "&": "type"
		      }, 
		      "map"
		    ], 
		    "name": "isdict_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "transform-t": [
		      "&=", 
		      {
		        "value": "^@.item", 
		        "&": "type"
		      }, 
		      "list"
		    ], 
		    "name": "islist_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "requires": [
		      "isdict_core", 
		      "islist_core"
		    ], 
		    "transform-t": [
		      "&!", 
		      [
		        "&||", 
		        {
		          "&": "isdict_core"
		        }, 
		        {
		          "&": "islist_core"
		        }
		      ]
		    ], 
		    "name": "issimple_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "requires": [
		      "hasitems_core", 
		      "isdict_core", 
		      "islist_core", 
		      "switch_core", 
		      "map_core", 
		      "isinlist_core", 
		      "newdiff_core"
		    ], 
		    "transform-t": {
		      "!": {
		        ":": {
		          "!": {
		            ":": {
		              "true": {
		                ":": "^@.value"
		              }, 
		              "cond": {
		                ":": {
		                  "!": "^@.keepvalue"
		                }
		              }, 
		              "&": "if"
		            }
		          }, 
		          "value": {
		            "cases": [
		              [
		                "map", 
		                {
		                  "true": {
		                    ":": {
		                      "value": {
		                        "list": {
		                          "map": "^@.new", 
		                          "&": "keys"
		                        }, 
		                        "t": {
		                          ":": {
		                            "true": {
		                              ":": {
		                                "true": null, 
		                                "false": {
		                                  ":": {
		                                    "!": {
		                                      ":": {
		                                        "true": {
		                                          ":": [
		                                            "^@.item", 
		                                            "^@.value"
		                                          ]
		                                        }, 
		                                        "cond": {
		                                          ":": {
		                                            "!": "^@.keepvalue"
		                                          }
		                                        }, 
		                                        "&": "if"
		                                      }
		                                    }, 
		                                    "value": {
		                                      "new": [
		                                        "^%", 
		                                        "^@.new", 
		                                        "^@.item"
		                                      ], 
		                                      "old": [
		                                        "^%", 
		                                        "^@.old", 
		                                        "^@.item"
		                                      ], 
		                                      "&": "newdiff_core"
		                                    }
		                                  }
		                                }, 
		                                "cond": {
		                                  ":": [
		                                    "&=", 
		                                    [
		                                      "^%", 
		                                      "^@.new", 
		                                      "^@.item"
		                                    ], 
		                                    [
		                                      "^%", 
		                                      "^@.old", 
		                                      "^@.item"
		                                    ]
		                                  ]
		                                }, 
		                                "&": "if"
		                              }
		                            }, 
		                            "false": {
		                              ":": [
		                                "^@.item", 
		                                [
		                                  "^%", 
		                                  "^@.new", 
		                                  "^@.item"
		                                ]
		                              ]
		                            }, 
		                            "cond": {
		                              ":": {
		                                "list": {
		                                  "map": "^@.old", 
		                                  "&": "keys"
		                                }, 
		                                "&": "isinlist_core"
		                              }
		                            }, 
		                            "&": "if"
		                          }
		                        }, 
		                        "&": "map_core"
		                      }, 
		                      "&": "makemap"
		                    }
		                  }, 
		                  "false": {
		                    ":": "^@.new"
		                  }, 
		                  "cond": {
		                    ":": {
		                      "item": "^@.old", 
		                      "&": "isdict_core"
		                    }
		                  }, 
		                  "&": "if"
		                }
		              ], 
		              [
		                "list", 
		                {
		                  "!": {
		                    ":": {
		                      "true": {
		                        ":": "^@.list"
		                      }, 
		                      "false": [], 
		                      "cond": {
		                        ":": {
		                          "&": "hasitems_core"
		                        }
		                      }, 
		                      "&": "if"
		                    }
		                  }, 
		                  "list": {
		                    "true": {
		                      ":": [
		                        "^%", 
		                        {
		                          "accum": {
		                            "index": 0, 
		                            "result": []
		                          }, 
		                          "list": "^@.new", 
		                          "t": {
		                            ":": {
		                              "index": [
		                                "&+", 
		                                "^@.accum.index", 
		                                1
		                              ], 
		                              "result": [
		                                "&&", 
		                                "^@.accum.result", 
		                                [
		                                  {
		                                    "!": {
		                                      ":": {
		                                        "true": {
		                                          ":": "^@.value"
		                                        }, 
		                                        "cond": {
		                                          ":": {
		                                            "!": "^@.keepvalue"
		                                          }
		                                        }, 
		                                        "&": "if"
		                                      }
		                                    }, 
		                                    "value": {
		                                      "new": "^@.item", 
		                                      "old": [
		                                        "^%", 
		                                        "^@.old", 
		                                        "^@.accum.index"
		                                      ], 
		                                      "&": "newdiff_core"
		                                    }
		                                  }
		                                ]
		                              ]
		                            }
		                          }, 
		                          "&": "reduce"
		                        }, 
		                        "result"
		                      ]
		                    }, 
		                    "false": {
		                      ":": "^@.new"
		                    }, 
		                    "cond": {
		                      ":": {
		                        "item": "^@.old", 
		                        "&": "islist_core"
		                      }
		                    }, 
		                    "&": "if"
		                  }
		                }
		              ], 
		              {
		                "false": {
		                  ":": "^@.new"
		                }, 
		                "cond": {
		                  ":": [
		                    "&=", 
		                    "^@.new", 
		                    "^@.old"
		                  ]
		                }, 
		                "&": "if"
		              }
		            ], 
		            "value": {
		              "value": "^@.new", 
		              "&": "type"
		            }, 
		            "&": "switch_core"
		          }
		        }
		      }, 
		      "keepvalue": {
		        ":": [
		          "&||", 
		          "^@.value", 
		          [
		            "&!", 
		            {
		              "item": {
		                "&": "type"
		              }, 
		              "list": [
		                "null", 
		                "map", 
		                "list"
		              ], 
		              "&": "isinlist_core"
		            }
		          ]
		        ]
		      }
		    }, 
		    "name": "newdiff_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "transform-t": {
		      "accum": [], 
		      "t": {
		        ":": {
		          "true": {
		            ":": "^@.item"
		          }, 
		          "false": {
		            ":": "^@.accum"
		          }, 
		          "cond": {
		            ":": [
		              "&>", 
		              {
		                "list": "^@.item", 
		                "&": "len"
		              }, 
		              {
		                "list": "^@.accum", 
		                "&": "len"
		              }
		            ]
		          }, 
		          "&": "if"
		        }
		      }, 
		      "&": "reduce"
		    }, 
		    "name": "longest_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "requires": [
		      "applynewdiff_core", 
		      "when_core", 
		      "removedupstrarr_core", 
		      "map_core", 
		      "longest_core"
		    ], 
		    "transform-t": {
		      "!": {
		        ":": {
		          "cases": [
		            [
		              {
		                ":": [
		                  "&=", 
		                  null, 
		                  "^@.diff"
		                ]
		              }, 
		              {
		                ":": "^@.old"
		              }
		            ], 
		            [
		              {
		                ":": [
		                  "&!=", 
		                  "^@.oldtype", 
		                  "^@.difftype"
		                ]
		              }, 
		              {
		                ":": "^@.diff"
		              }
		            ], 
		            [
		              {
		                ":": [
		                  "&=", 
		                  "^@.difftype", 
		                  "map"
		                ]
		              }, 
		              {
		                ":": {
		                  "!": {
		                    ":": {
		                      "value": {
		                        "list": "^@.keys", 
		                        "t": {
		                          ":": [
		                            "^@.item", 
		                            {
		                              "diff": [
		                                "^@", 
		                                "diff", 
		                                "^@.item"
		                              ], 
		                              "old": [
		                                "^@", 
		                                "old", 
		                                "^@.item"
		                              ], 
		                              "&": "applynewdiff_core"
		                            }
		                          ]
		                        }, 
		                        "&": "map_core"
		                      }, 
		                      "&": "makemap"
		                    }
		                  }, 
		                  "keys": {
		                    "list": [
		                      "&&", 
		                      {
		                        "map": "^@.old", 
		                        "&": "keys"
		                      }, 
		                      {
		                        "map": "^@.diff", 
		                        "&": "keys"
		                      }
		                    ], 
		                    "&": "removedupstrarr_core"
		                  }
		                }
		              }
		            ], 
		            [
		              {
		                ":": [
		                  "&=", 
		                  "^@.difftype", 
		                  "list"
		                ]
		              }, 
		              {
		                ":": {
		                  "!": {
		                    ":": [
		                      "^%", 
		                      {
		                        "list": "^@.longestlist", 
		                        "accum": {
		                          "index": 0, 
		                          "result": []
		                        }, 
		                        "t": {
		                          ":": {
		                            "index": [
		                              "&+", 
		                              "^@.accum.index", 
		                              1
		                            ], 
		                            "result": [
		                              "&&", 
		                              "^@.accum.result", 
		                              {
		                                "diff": [
		                                  "^@", 
		                                  "diff", 
		                                  "^@.accum.index"
		                                ], 
		                                "old": [
		                                  "^@", 
		                                  "old", 
		                                  "^@.accum.index"
		                                ], 
		                                "&": "applynewdiff_core"
		                              }
		                            ]
		                          }
		                        }, 
		                        "&": "reduce"
		                      }, 
		                      "result"
		                    ]
		                  }, 
		                  "longestlist": {
		                    "list": [
		                      "^@.old", 
		                      "^@.diff"
		                    ], 
		                    "&": "longest_core"
		                  }
		                }
		              }
		            ], 
		            {
		              ":": "^@.diff"
		            }
		          ], 
		          "&": "when_core"
		        }
		      }, 
		      "oldtype": {
		        "value": "^@.old", 
		        "&": "type"
		      }, 
		      "difftype": {
		        "value": "^@.diff", 
		        "&": "type"
		      }
		    }, 
		    "name": "applynewdiff_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "transform-t": {
		      "accum": null, 
		      "t": {
		        ":": {
		          "true": {
		            ":": {
		              "value": [
		                [
		                  "!!", 
		                  {
		                    "value": [
		                      [
		                        ":", 
		                        "^@.item"
		                      ]
		                    ], 
		                    "&": "makemap"
		                  }
		                ], 
		                [
		                  "s", 
		                  "^@.accum"
		                ]
		              ], 
		              "&": "makemap"
		            }
		          }, 
		          "false": {
		            ":": "^@.item"
		          }, 
		          "cond": {
		            ":": "^@.accum"
		          }, 
		          "&": "if"
		        }
		      }, 
		      "&": "reduce"
		    }, 
		    "name": "combine_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "requires": [
		      "combine_core", 
		      "keys2map_core"
		    ], 
		    "transform-t": {
		      "requires": {
		        "map": {
		          "list": {
		            "!": {
		              "accum": {
		                ":": [
		                  "&&"
		                ]
		              }, 
		              "list": "&@.list.*.requires", 
		              "t": {
		                ":": [
		                  "&&", 
		                  "^@.accum", 
		                  "^@.item"
		                ]
		              }, 
		              "&": "reduce"
		            }
		          }, 
		          "&": "keys2map_core"
		        }, 
		        "&": "keys"
		      }, 
		      "transform-t": {
		        "list": "&@.list.*.transform-t", 
		        "&": "combine_core"
		      }
		    }, 
		    "name": "declcombine_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "transform-t": {
		      "accum": 0, 
		      "t": {
		        ":": {
		          "!": {
		            ":": {
		              "true": {
		                ":": "^@.accum"
		              }, 
		              "false": {
		                ":": "^@.item"
		              }, 
		              "cond": {
		                ":": [
		                  "&>=", 
		                  "^@.accum", 
		                  "^@.item"
		                ]
		              }, 
		              "&": "if"
		            }
		          }
		        }
		      }, 
		      "&": "reduce"
		    }, 
		    "name": "max_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "transform-t": {
		      "accum": 0, 
		      "t": {
		        ":": {
		          "!": {
		            ":": {
		              "true": {
		                ":": "^@.accum"
		              }, 
		              "false": {
		                ":": "^@.itemlen"
		              }, 
		              "cond": {
		                ":": [
		                  "&>=", 
		                  "^@.accum", 
		                  "^@.itemlen"
		                ]
		              }, 
		              "&": "if"
		            }
		          }, 
		          "itemlen": {
		            "list": "^@.item", 
		            "&": "len"
		          }
		        }
		      }, 
		      "&": "reduce"
		    }, 
		    "name": "lenmax_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "requires": [
		      "switch_core", 
		      "coalesce_core", 
		      "traverse_core_emlynoregan_com"
		    ], 
		    "transform-t": {
		      "!": {
		        ":": {
		          "cases": [
		            [
		              "map", 
		              {
		                "value": {
		                  "accum": [], 
		                  "list": {
		                    "map": "^@.source", 
		                    "&": "keys"
		                  }, 
		                  "t": {
		                    ":": {
		                      "!": {
		                        ":": [
		                          "&&", 
		                          "^@.accum", 
		                          [
		                            [
		                              "^@.item", 
		                              {
		                                "source": "^@.transformedvalue", 
		                                "&": "traverse_core_emlynoregan_com"
		                              }
		                            ]
		                          ]
		                        ]
		                      }, 
		                      "transformedvalue": {
		                        "!": "^@.traverse-t", 
		                        "value": [
		                          "^@", 
		                          "source", 
		                          "^@.item"
		                        ], 
		                        "key": "^@.item"
		                      }
		                    }
		                  }, 
		                  "&": "reduce"
		                }, 
		                "&": "makemap"
		              }
		            ], 
		            [
		              "list", 
		              [
		                "^%", 
		                {
		                  "accum": {
		                    "index": 0, 
		                    "result": []
		                  }, 
		                  "list": "^@.source", 
		                  "t": {
		                    ":": {
		                      "index": [
		                        "&+", 
		                        "^@.index", 
		                        1
		                      ], 
		                      "result": {
		                        "!": {
		                          ":": [
		                            "&&", 
		                            "^@.accum.result", 
		                            [
		                              {
		                                "source": "^@.transformedvalue", 
		                                "&": "traverse_core_emlynoregan_com"
		                              }
		                            ]
		                          ]
		                        }, 
		                        "transformedvalue": {
		                          "!": "^@.traverse-t", 
		                          "value": "^@.item", 
		                          "key": "^@.index"
		                        }
		                      }
		                    }
		                  }, 
		                  "&": "reduce"
		                }, 
		                "result"
		              ]
		            ], 
		            {
		              "!": "^@.traverse-t", 
		              "value": "^@.source"
		            }
		          ], 
		          "value": {
		            "value": "^@.source", 
		            "&": "type"
		          }, 
		          "&": "switch_core"
		        }
		      }, 
		      "traverse-t": {
		        "list": [
		          "^@.traverse-t", 
		          "^@.t"
		        ], 
		        "&": "coalesce_core"
		      }
		    }, 
		    "name": "traverse_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "requires": [
		      "switch_core", 
		      "coalesce_core", 
		      "filttrav_core_emlynoregan_com"
		    ], 
		    "transform-t": {
		      "!": {
		        ":": {
		          "cases": [
		            [
		              "map", 
		              {
		                "value": {
		                  "accum": [], 
		                  "list": {
		                    "map": "^@.source", 
		                    "&": "keys"
		                  }, 
		                  "t": {
		                    ":": {
		                      "!": {
		                        ":": {
		                          "true": {
		                            ":": [
		                              "&&", 
		                              "^@.accum", 
		                              [
		                                [
		                                  "^@.item", 
		                                  {
		                                    "source": [
		                                      "^@", 
		                                      "source", 
		                                      "^@.item"
		                                    ], 
		                                    "&": "filttrav_core_emlynoregan_com"
		                                  }
		                                ]
		                              ]
		                            ]
		                          }, 
		                          "false": {
		                            ":": "^@.accum"
		                          }, 
		                          "cond": {
		                            ":": "^@.keepvalue"
		                          }, 
		                          "&": "if"
		                        }
		                      }, 
		                      "keepvalue": {
		                        "!": "^@.filter-t", 
		                        "value": [
		                          "^@", 
		                          "source", 
		                          "^@.item"
		                        ], 
		                        "key": "^@.item"
		                      }
		                    }
		                  }, 
		                  "&": "reduce"
		                }, 
		                "&": "makemap"
		              }
		            ], 
		            [
		              "list", 
		              [
		                "^%", 
		                {
		                  "accum": {
		                    "index": 0, 
		                    "result": []
		                  }, 
		                  "list": "^@.source", 
		                  "t": {
		                    ":": {
		                      "index": [
		                        "&+", 
		                        "^@.index", 
		                        1
		                      ], 
		                      "result": {
		                        "!": {
		                          ":": {
		                            "true": {
		                              ":": [
		                                "&&", 
		                                "^@.accum.result", 
		                                {
		                                  "source": "^@.item", 
		                                  "&": "filttrav_core_emlynoregan_com"
		                                }
		                              ]
		                            }, 
		                            "false": {
		                              ":": "^@.accum.result"
		                            }, 
		                            "cond": {
		                              ":": "^@.keepvalue"
		                            }, 
		                            "&": "if"
		                          }
		                        }, 
		                        "keepvalue": {
		                          "!": "^@.filter-t", 
		                          "value": "^@.item", 
		                          "key": "^@.index"
		                        }
		                      }
		                    }
		                  }, 
		                  "&": "reduce"
		                }, 
		                "result"
		              ]
		            ], 
		            "^@.source"
		          ], 
		          "value": {
		            "value": "^@.source", 
		            "&": "type"
		          }, 
		          "&": "switch_core"
		        }
		      }, 
		      "filter-t": {
		        "list": [
		          "^@.filter-t", 
		          "^@.t"
		        ], 
		        "&": "coalesce_core"
		      }
		    }, 
		    "name": "filttrav_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }, 
		  {
		    "requires": [
		      "switch_core", 
		      "removenullattribs_core", 
		      "addmaps_core", 
		      "meta_core", 
		      "removekeys_core", 
		      "unmakemap_core"
		    ], 
		    "transform-t": {
		      "true": {
		        ":": {
		          "cases": [
		            [
		              "map", 
		              {
		                "map2": {
		                  "map": {
		                    "value": [
		                      [
		                        "!", 
		                        {
		                          "t": "^@.t.-!", 
		                          "&": "meta_core"
		                        }
		                      ], 
		                      [
		                        "!!", 
		                        {
		                          "t": "^@.t.-!!", 
		                          "&": "meta_core"
		                        }
		                      ], 
		                      [
		                        ":", 
		                        {
		                          "t": "^@.t.-:", 
		                          "&": "meta_core"
		                        }
		                      ], 
		                      [
		                        "\'", 
		                        {
		                          "t": "^@.t.-\'", 
		                          "&": "meta_core"
		                        }
		                      ], 
		                      [
		                        "&&", 
		                        {
		                          "t": "^@.t.-&&", 
		                          "&": "meta_core"
		                        }
		                      ], 
		                      [
		                        "&", 
		                        {
		                          "t": "^@.t.-&", 
		                          "&": "meta_core"
		                        }
		                      ]
		                    ], 
		                    "&": "makemap"
		                  }, 
		                  "&": "removenullattribs_core"
		                }, 
		                "map1": {
		                  "keys": [
		                    "-!", 
		                    "-!!", 
		                    "-&", 
		                    "-&&", 
		                    "-:", 
		                    "-\'"
		                  ], 
		                  "map": {
		                    "value": {
		                      "list": {
		                        "map": "^@.t", 
		                        "&": "unmakemap_core"
		                      }, 
		                      "t": {
		                        ":": [
		                          [
		                            "^%", 
		                            "^@.item", 
		                            0
		                          ], 
		                          {
		                            "t": [
		                              "^%", 
		                              "^@.item", 
		                              1
		                            ], 
		                            "&": "meta_core"
		                          }
		                        ]
		                      }, 
		                      "&": "map_core"
		                    }, 
		                    "&": "makemap"
		                  }, 
		                  "&": "removekeys_core"
		                }, 
		                "&": "addmaps_core"
		              }
		            ], 
		            [
		              "list", 
		              {
		                "true": {
		                  ":": [
		                    "&&", 
		                    {
		                      ":": [
		                        "&&"
		                      ]
		                    }, 
		                    {
		                      "b": {
		                        "list": "^@.t", 
		                        "t": {
		                          ":": {
		                            "t": "^@.item", 
		                            "&": "meta_core"
		                          }
		                        }, 
		                        "&": "map_core"
		                      }, 
		                      "&": "tail"
		                    }
		                  ]
		                }, 
		                "false": {
		                  ":": {
		                    "list": "^@.t", 
		                    "t": {
		                      ":": {
		                        "t": "^@.item", 
		                        "&": "meta_core"
		                      }
		                    }, 
		                    "&": "map_core"
		                  }
		                }, 
		                "cond": {
		                  ":": [
		                    "&=", 
		                    [
		                      "^%", 
		                      "^@.t", 
		                      0
		                    ], 
		                    "-&&"
		                  ]
		                }, 
		                "&": "if"
		              }
		            ], 
		            "^@.t"
		          ], 
		          "value": {
		            "value": "^@.t", 
		            "&": "type"
		          }, 
		          "&": "switch_core"
		        }
		      }, 
		      "cond": {
		        ":": [
		          "&!=", 
		          "^@.t", 
		          null
		        ]
		      }, 
		      "&": "if"
		    }, 
		    "name": "meta_core_emlynoregan_com", 
		    "language": "sUTL0"
		  }
		]
		';
	}
}