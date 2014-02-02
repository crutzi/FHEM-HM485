package HM485::Devicefile;

our %definition = (
	'HMW_IO12_SW7_0302'	=> {
		'version'		=> 7,
		'eeprom-size'	=> 1024,
		'models'	=> {
			'HMW_IO_12_Sw7_DR'	=> {
				'name'			=> 'RS485 I/O module 12-channel in and switch actuator 7-channel (DIN rails)',
				'type'			=> 18,
				'minFW_version'	=> 0x0302
			},
		},
		'params' => {
			'master'	=> {
				'logging_time'	=> {
					'logical'		=> {
						'type'		=> 'float',
						'min'		=> 0.0,
						'max'		=> 25.5,
						'default'	=> 2.0,
						'unit'		=> 's',
					},
					'physical'	=> {
						'type'			=> 'int',
						'size'			=> 1.0,
						'interface'		=> 'eeprom',
						'address_id'	=> 0x0001
					},
					'conversion'	=> {
						'type'		=> 'float_integer_scale',
						'factor'	=> 10,										# conversion factor
						'offset'	=> 0.0
					}
				},
				'central_address'	=> {
					'hidden'		=> 1,
					'enforce'		=> 0x00000001,
					'logical'		=> {
						'type'		=> 'int',
					},
					'physical'	=> {
						'type'			=> 'int',
						'size'			=> 4,
						'interface'		=> 'eeprom',
						'address_id'	=> 0x0002
					}
				},
				'direct_link_deactivate'	=> {
					'hidden'		=> 1,
					'enforce'		=> 1,
					'logical'		=> {
						'type'		=> 'boolean',
						'default'	=> 0,
					},
					'physical'	=> {
						'type'			=> 'int',
						'size'			=> 0.1,
						'interface'		=> 'eeprom',
						'address_id'	=> 0x0006
					}
				},
			},
		},
		'frames'	=> {
			'level_set'	=> {
				'type'		=> 0x78,
				'dir'		=> 'to_device',
				'ch_field'	=> 10,
				'params'	=> {
					'state'		=> {
						'type'	=> 'int',
						'id'	=> 11.0,
						'size'	=> 1
					},
				},
			},
			'level_get'	=> {
				'type'		=> 0x73,
				'dir'		=> 'to_device', 
				'ch_field'	=> 10,
			},
			'info_level'	=> {
				'type'		=> 0x69,
				'dir'		=> 'from_device',
				'event'		=> 1,
				'ch_field'	=> 10,
				'params'	=> {
					'state'		=> {
						'type'	=> 'int',
						'id'	=> 11.0,
						'size'	=> 1
					},
					'state_flags'	=> {
						'type'	=> 'int',
						'id'	=> 12.4,
						'size'	=> 0.3
					},
				},
			},
			'key_event_short'	=> {
				'type'		=> 0x4B,
				'dir'		=> 'from_device',
				'event'		=> 1,
				'ch_field'	=> 10,
				'params'	=> {
					'key'	=> {
						'type'			=> 'int',
						'id'			=> 12.0,
						'size'			=> 0.1,
						'const_value'	=> 0
					},
					'counter'	=> {
						'type'	=> 'int',
						'id'	=> 12.2,
						'size'	=> 0.6
					}
				}
			},
			'key_event_long'	=> {
				'type'		=> 0x4B,
				'dir'		=> 'from_device',
				'event'		=> 1,
				'ch_field'	=> 10,
				'params'	=> {
					'key'	=> {
						'type'			=> 'int',
						'id'			=> 12.0,
						'size'			=> 0.1,
						'const_value'	=> 1
					},
					'counter'	=> {
						'type'	=> 'int',
						'id'	=> 12.2,
						'size'	=> 0.6
					}
				}
			},
			'key_sim_short'	=> {
				'type'			=> 0x4B,
				'dir'			=> 'from_device',
				'ch_field'		=> 10,
				'rec_ch_field'	=> 11,
				'params'	=> {
					'key'	=> {
						'type'			=> 'int',
						'id'			=> 12.0,
						'size'			=> 0.1,
						'const_value'	=> 0
					},
					'sim_counter'	=> {
						'type'	=> 'int',
						'id'	=> 12.2,
						'size'	=> 0.6
					},
				},
			},
			'key_sim_long'	=> {
				'type'			=> 0x4B,
				'dir'			=> 'from_device',
				'ch_field'		=> 10,
				'rec_ch_field'	=> 11,
				'params'	=> {
					'key'	=> {
						'type'			=> 'int',
						'id'			=> 12.0,
						'size'			=> 0.1,
						'const_value'	=> 1
					},
					'sim_counter'	=> {
						'type'	=> 'int',
						'id'	=> 12.2,
						'size'	=> 0.6
					}
				}
			},
			'set_lock'	=> {
				'type'		=> 0x6C, 
				'dir'		=> 'to_device',
				'ch_field'	=> 11,
				'params'	=> {
					'inhibit'	=> {
						'type'	=> 'int',
						'id'	=> 12.0,
						'size'	=> 1.0
					}
				}
			},
		},
		'channels'	=> {
			'maintenance' => {
				'id'		=> 0,
				'ui-flags'	=> 'internal',
				'class'		=> 'maintenance',
				'count'	=> 1,
				'params'	=> {
					'master'	=> {},											# ??? we need them?
					'values'	=> {											# we need the master channel values???
						'unreach'	=> {
							'operations'	=> 'read,event',
							'ui-flags'		=> 'service',
							'logical'		=> {
								'type'		=> 'boolean',
							},
							'physical'		=> {
								'type'		=> 'int',
								'interface'	=> 'internal',
							},
						},
						'sticky_unreach'	=> {
							'operations'	=> 'read,write,event',
							'ui-flags'		=> 'service',
							'logical'		=> {
								'type'		=> 'boolean',
							},
							'physical'		=> {
								'type'		=> 'int',
								'interface'	=> 'internal',
							}
						},
						'config_pending'	=> {
							'operations'	=> 'read,event',
							'ui-flags'		=> 'service',
							'logical'		=> {
								'type'		=> 'boolean',
							},
							'physical'		=> {
								'type'		=> 'int',
								'interface'	=> 'internal',
							}
						},
					},
				},
			},
			'key'	=> {
				'id'	=> 1,
				'count'	=> 12,
				'physical_id_offset'	=> -1,
				'link_roles'	=> {
					'source'	=> 'switch',
				},
				'params'	=> {
					'master'	=> {
						'address_start'	=> 0x07,
						'address_step'	=> 2,
						'input_type'	=> {
							'logical'	=> {
								'type'	=> 'option',
								'options' 	=> 'switch, pushbutton',
								'default'	=> 'pushbutton',
							},
							'physical'	=> {
								'type'			=> 'int',
								'size'			=> 0.1,
								'interface'		=> 'eeprom',
								'address_id'	=> 0.0
							}
						},
						'input_locked'	=> {
							'logical'	=> {
								'type'	=> 'boolean',
								'default'	=> 0,
							},
							'physical'	=> {
								'type'			=> 'int',
								'size'			=> 0.1,
								'interface'		=> 'eeprom',
								'address_id'	=> 0.1
							},
							'conversion'	=> {								# conversion config
								'type'		=> 'boolean_integer',
								'invert'	=> 1
							}
						},
						'long_press_time'	=> {
							'logical'	=> {
								'type'		=> 'float',
								'min'		=> 0.4,
								'max'		=> 5,
								'default'	=> 1.0,
								'unit'		=> 's',
							},
							'physical'	=> {
								'type'			=> 'int',
								'size'			=> 1.0,
								'interface'		=> 'eeprom',
								'address_id'	=> 1.0
							},
							'conversion'	=> {
								'type'		=> 'float_integer_scale',			# conversion config
								'factor'	=> 10,								# before saving values to eeprom we multiply the parameter with factor
								'value_map'	=> {
									'type'	=> 'integer_integer_map',			# parameter mapping configuration
									'01'	=> {
										'device_value'		=> 0xFF,
										'parameter_value'	=> 10,
										'from_device'		=> 1,
										'to_device'			=> 0,
									}
								}
							}
						}
					},
					'link'	=> {
						'peer_param'	=> 'actuator',
						'channel_param'	=> 'channel',
						'count'			=> 27,
						'address_start'	=> 0x359,
						'address_step'	=> 6,
						'channel'	=> {
							'operations'	=> 'none', 
							'hidden'		=> 1,
							'logical'		=> {
								'type'		=> 'int',
								'min'		=> 0,
								'max'		=> 255,
								'default'	=> 255,
							},
							'physical'	=> {
								'type'			=> 'int',
								'size'			=> 1,
								'interface'		=> 'eeprom',
								'address_id'	=> 0
							}
						},
						'actuator'	=> {
							'operations'	=> 'none', 
							'hidden'		=> 1,
							'logical'		=> {
								'type'		=> 'address',
							},
							'physical'		=> {
								'type'		=> 'array',
								'01'		=> {
									'type'		=>	'int',
									'size'		=>	4,
									'interface'	=>	'eeprom',
									'address_id'	=> 1
								},
								'02'	=> {
									'type'		=>	'int',
									'size'		=>	1,
									'interface'	=>	'eeprom',
									'address_id'	=> 5
								}
							}
						}
					},
					'values'	=> {
						'press_short'	=> {
							'operations'	=> 'event,read,write', 
							'control'		=> 'button.short',
							'logical'		=> {
								'type'		=> 'action',
							},
							'physical'		=> {
								'type'		=> 'int',
								'interface'	=> 'command',
								'value_id'	=> 'counter',
								'event'		=> {
									'frame'	=> 'key_event_short',
								},
								'set'		=> {
									'request'	=> 'key_sim_short',
								},
							},
							'conversion'	=> {
								'type'			=> 'action_key_counter',
								'sim_counter'	=> 'sim_counter',
								'counter_size'	=> 6
							}
						},
						'press_long'	=> {
							'operations'	=> 'event,read,write', 
							'control'		=> 'button.long',
							'logical'		=> {
								'type'		=> 'action',
							},
							'physical'		=> {
								'type'		=> 'int',
								'interface'	=> 'command',
								'value_id'	=> 'counter',
								'event'		=> {
									'frame'	=> 'key_event_long',
								},
								'set'		=> {
									'request'	=> 'key_sim_long',
								}
							},
							'conversion'	=> {
								'type'			=> 'action_key_counter',
								'sim_counter'	=> 'sim_counter',
								'counter_size'	=> 6
							}
						}
					}
				}
			},
			'switch' => {
				'id'	=> 13,
				'count'	=> 7,
				'physical_id_offset'	=> -1,
				'link_roles'	=> {
					'target'	=> 'switch',
				},
				'params'	=> {
					'master'	=> {
						'address_start'	=> 0x1F,
						'address_step'	=> 2,
						'logging'	=> {
							'logical'	=> {
								'type'	=> 'option',
								'options' 	=> 'on,off',
								'default'	=> 'on',
							},
							'physical'	=> {
								'type'			=> 'int',
								'size'			=> 0.1,
								'interface'		=> 'eeprom',
								'address_id'	=> 0
							}
						}
					},
					'link'	=> {
						'peer_param'	=> 'sensor',
						'channel_param'	=> 'channel',
						'count'			=> 29,
						'address_start'	=> 0x2D,
						'address_step'	=> 28,
						'params'	=> {
							'ui_hint'	=> {
								'logical'		=> {
									'type'						=> 'string',
									'default'					=> '',
									'use_default_on_failure' 	=> 1,
								},
								'physical'		=> {
									'type'				=> 'string',
									'interface'			=> 'store',
									'save_on_change'	=> 1,
								}
							},
							'sensor'	=> {
								'operations'	=> 'none',
								'hidden'		=> 1,
								'logical'		=> {
									'type'		=> 'address',
								},
								'physical'		=> {
									'type'		=> 'array',
									'01'		=> {
										'type'			=>	'int',
										'size'			=>	4,
										'interface'		=>	'eeprom',
										'address_id'	=>	0
									},
									'02'	=> {
										'type'			=>	'int',
										'size'			=>	1,
										'interface'		=>	'eeprom',
										'address_id'	=>	4
									}
								}
							},
							'channel'	=> {
								'operations'	=> 'none',
								'hidden'		=> 1,
								'logical'		=> {
									'type'		=> 'int',
									'min'		=> 0,
									'max'		=> 255,
								},
								'physical'		=> {
									'type'			=> 'int',
									'size'			=> 1,
									'interface'		=>	'eeprom',
									'address_id'	=>	5
								}
							},
							'short_on_time_mode'	=> {
								'logical'		=> {
									'type'		=> 'option',
									'options' 	=> 'minimal, absolute',
									'default'	=> 'absolute',
								},
								'physical'		=> {
									'type'			=> 'int',
									'size'			=> 0.1,
									'interface'		=>	'eeprom',
									'address_id'	=>	6.7
								}
							},
							'short_off_time_mode'	=> {
								'logical'		=> {
									'type'		=> 'option',
									'options' 	=> 'minimal, absolute',
									'default'	=> 'absolute',
								},
								'physical'		=> {
									'type'			=> 'int',
									'size'			=> 0.1,
									'interface'		=>	'eeprom',
									'address_id'	=>	6.6
								}
							},
							'short_toggle_use'	=> {
								'logical'		=> {
									'type'		=> 'option',
									'options' 	=> 'dont_use, direct, inverted',
									'default'	=> 'dont_use',
								},
								'physical'		=> {
									'type'			=> 'int',
									'size'			=> 0.2,
									'interface'		=>	'eeprom',
									'address_id'	=>	6.4
								},
								'conversion'	=> {
									'type'		=> 'option_integer',
									'value_map'	=> {
										'01'	=> {
											'device_value'		=> 0x03,
											'parameter_value'	=> 0,
											'from_device'		=> 1,
											'to_device'			=> 1,
										},
										'02'	=> {
											'device_value'		=> 0x02,
											'parameter_value'	=> 1,
											'from_device'		=> 1,
											'to_device'			=> 1,
										},
										'03'	=> {
											'device_value'		=> 0x00,
											'parameter_value'	=> 2,
											'from_device'		=> 1,
											'to_device'			=> 1,
										}
									}
								}
							},
							'short_action_type'	=> {
								'logical'		=> {
									'type'		=> 'option',
									'options' 	=> 'inactive, active',
									'default'	=> 'active',
								},
								'physical'	=> {
									'type'			=> 'int',
									'size'			=> 0.1,
									'interface'		=>	'eeprom',
									'address_id'	=>	6.0
								},
							},
							'short_ondelay_time'	=> {
								'logical'		=> {
									'type'		=> 'float',
									'min' 		=> 0.0,
									'max'		=> 982980.0,
									'default'	=> 0.0,
									'unit'		=> 's',
								},
								'physical'	=> {
									'type'			=> 'int',
									'size'			=> 2,
									'interface'		=>	'eeprom',
									'endian'		=>	'little',
									'address_id'	=>	8
								},
								'conversion'	=> {
									'type'			=> 'float_configtime',
									'factors'		=> '0.1,1,60,1000',
									'value_size'	=> 1.6,
									'value_map'		=> {
										'type'	=> 'integer_integer_map',
										'01'	=> {
											'device_value'		=> 0xC000,
											'parameter_value'	=> 0xFFFF,
											'mask'				=> 0xC000,
										},
									}
								}
							},
							'short_on_time'	=> {
								'logical'		=> {
									'type'		=> 'float',
									'min' 		=> 0.0,
									'max'		=> 982980.0,
									'default'	=> 16383000,
									'unit'		=> 's',
									'special_value'	=> {
										'not_used'	=> 16383000,
									}
								},
								'physical'	=> {
									'type'			=> 'int',
									'size'			=> 2,
									'interface'		=>	'eeprom',
									'endian'		=>	'little',
									'address_id'	=>	10
								},
								'conversion'	=> {
									'type'			=> 'float_configtime',
									'factors'		=> '0.1,1,60,1000',
									'value_size'	=> 1.6,
									'value_map'		=> {
										'type'	=> 'integer_integer_map',
										'01'	=> {
											'device_value'		=> 0xC000,
											'parameter_value'	=> 0xFFFF,
											'mask'				=> 0xC000,
										},
									}
								}
							},
							'short_offdelay_time'	=> {
								'logical'		=> {
									'type'		=> 'float',
									'min' 		=> 0.0,
									'max'		=> 982980.0,
									'default'	=> 0,
									'unit'		=> 's',
								},
								'physical'	=> {
									'type'			=> 'int',
									'size'			=> 2,
									'interface'		=>	'eeprom',
									'endian'		=>	'little',
									'address_id'	=>	12
								},
								'conversion'	=> {
									'type'			=> 'float_configtime',
									'factors'		=> '0.1,1,60,1000',
									'value_size'	=> 1.6,
									'value_map'		=> {
										'type'	=> 'integer_integer_map',
										'01'	=> {
											'device_value'		=> 0xC000,
											'parameter_value'	=> 0xFFFF,
											'mask'				=> 0xC000,
										},
									}
								}
							},
							'short_off_time'	=> {
								'logical'		=> {
									'type'		=> 'float',
									'min' 		=> 0.0,
									'max'		=> 982980.0,
									'default'	=> 16383000,
									'unit'		=> 's',
									'special_value'	=> {
										'not_used'	=> 16383000,
									}
								},
								'physical'	=> {
									'type'			=> 'int',
									'size'			=> 2,
									'interface'		=>	'eeprom',
									'endian'		=>	'little',
									'address_id'	=>	14
								},
								'conversion'	=> {
									'type'			=> 'float_configtime',
									'factors'		=> '0.1,1,60,1000',
									'value_size'	=> 1.6,
									'value_map'		=> {
										'type'	=> 'integer_integer_map',
										'01'	=> {
											'device_value'		=> 0xC000,
											'parameter_value'	=> 0xFFFF,
											'mask'				=> 0xC000,
										},
									}
								}
							},
							'short_jt_ondelay'	=> {
								'logical'		=> {
									'type'		=> 'option',
									'options'	=> 'ondelay, on, offdelay, off, no_jump_ignore_command',
									'default'	=> 'on',
								},
								'physical'	=> {
									'type'			=> 'int',
									'size'			=> 0.3,
									'interface'		=>	'eeprom',
									'endian'		=>	'little',
									'read_size'		=>	2,
									'address_id'	=>	16.0
								}
							},
							'short_jt_on'	=> {
								'logical'		=> {
									'type'		=> 'option',
									'options'	=> 'ondelay, on, offdelay, off, no_jump_ignore_command',
									'default'	=> 'offdelay',
								},
								'physical'	=> {
									'type'			=> 'int',
									'size'			=> 0.3,
									'interface'		=>	'eeprom',
									'endian'		=>	'little',
									'read_size'		=>	2,
									'address_id'	=>	16.3
								}
							},
							'short_jt_offdelay'	=> {
								'logical'		=> {
									'type'		=> 'option',
									'options'	=> 'ondelay, on, offdelay, off, no_jump_ignore_command',
									'default'	=> 'off',
								},
								'physical'	=> {
									'type'			=> 'int',
									'size'			=> 0.3,
									'interface'		=>	'eeprom',
									'endian'		=>	'little',
									'read_size'		=>	2,
									'address_id'	=>	16.6
								}
							},
							'short_jt_off'	=> {
								'logical'		=> {
									'type'		=> 'option',
									'options'	=> 'ondelay, on, offdelay, off, no_jump_ignore_command',
									'default'	=> 'ondelay',
								},
								'physical'	=> {
									'type'			=> 'int',
									'size'			=> 0.3,
									'interface'		=>	'eeprom',
									'endian'		=>	'little',
									'read_size'		=>	2,
									'address_id'	=>	16.9
								}
							},
							'long_on_time_mode'	=> {
								'logical'		=> {
									'type'		=> 'option',
									'options'	=> 'minimal, absolute',
									'default'	=> 'absolute',
								},
								'physical'			=> {
									'type'			=> 'int',
									'size'			=> 0.1,
									'interface'		=>	'eeprom',
									'address_id'	=>	7.7
								}
							},
							'long_off_time_mode'	=> {
								'logical'		=> {
									'type'		=> 'option',
									'options'	=> 'minimal, absolute',
									'default'	=> 'absolute',
								},
								'physical'	=> {
									'type'			=> 'int',
									'size'			=> 0.1,
									'interface'		=>	'eeprom',
									'address_id'	=>	7.6
								}
							},
							'long_toggle_use'	=> {
								'logical'		=> {
									'type'		=> 'option',
									'options' 	=> 'dont_use, direct, inverted',
									'default'	=> 'dont_use',
								},
								'physical'	=> {
									'type'			=> 'int',
									'size'			=> 0.2,
									'interface'		=>	'eeprom',
									'address_id'	=>	7.4
								},
								'conversion'	=> {
									'type'	=> 'option_integer',
									'value_map'	=> {
										'01'	=> {
											'device_value'		=> 0x03,
											'parameter_value'	=> 0,
											'from_device'		=> 1,
											'to_device'			=> 1,
										},
										'02'	=> {
											'device_value'		=> 0x02,
											'parameter_value'	=> 1,
											'from_device'		=> 1,
											'to_device'			=> 1,
										},
										'03'	=> {
											'device_value'		=> 0x00,
											'parameter_value'	=> 2,
											'from_device'		=> 1,
											'to_device'			=> 1,
										}
									}
								}
							},
							'long_multiexecute'	=> {
								'logical'		=> {
									'type'		=> 'boolean',
									'default'	=> 1,
								},
								'physical'	=> {
									'type'			=> 'int',
									'size'			=> 0.1,
									'interface'		=>	'eeprom',
									'address_id'	=>	7.2
								}
							},
							'long_action_type'	=> {
								'logical'		=> {
									'type'		=> 'option',
									'options' 	=> 'inactive, active',
									'default'	=> 'active',
								},
								'physical'	=> {
									'type'			=> 'int',
									'size'			=> 0.1,
									'interface'		=>	'eeprom',
									'address_id'	=>	7.0
								}
							},
							'long_ondelay_time'	=> {
								'logical'		=> {
									'type'		=> 'float',
									'min' 		=> 0.0,
									'max'		=> 982980.0,
									'default'	=> 0.0,
									'unit'		=> 's',
								},
								'physical'	=> {
									'type'			=> 'int',
									'size'			=> 2,
									'interface'		=>	'eeprom',
									'endian'		=>	'little',
									'address_id'	=>	18
								},
								'conversion'	=> {
									'type'			=> 'float_configtime',
									'factors'		=> '0.1,1,60,1000',
									'value_size'	=> 1.6,
									'value_map'		=> {
										'type'	=> 'integer_integer_map',
										'01'	=> {
											'device_value'		=> 0xC000,
											'parameter_value'	=> 0xFFFF,
											'mask'				=> 0xC000,
										},
									}
								}
							},
							'long_on_time'	=> {
								'logical'		=> {
									'type'		=> 'float',
									'min' 		=> 0.0,
									'max'		=> 982980.0,
									'default'	=> 16383000,
									'unit'		=> 's',
									'special_value'	=> {
										'not_used'	=> 16383000,
									}
								},
								'physical'	=> {
									'type'			=> 'int',
									'size'			=> 2,
									'interface'		=>	'eeprom',
									'endian'		=>	'little',
									'address_id'	=>	20
								},
								'conversion'	=> {
									'type'			=> 'float_configtime',
									'factors'		=> '0.1,1,60,1000',
									'value_size'	=> 1.6,
									'value_map'		=> {
										'type'	=> 'integer_integer_map',
										'01'	=> {
											'device_value'		=> 0xC000,
											'parameter_value'	=> 0xFFFF,
											'mask'				=> 0xC000,
										},
									}
								}
							},
							'long_offdelay_time'	=> {
								'logical'		=> {
									'type'		=> 'float',
									'min' 		=> 0.0,
									'max'		=> 982980.0,
									'default'	=> 0.0,
									'unit'		=> 's',
								},
								'physical'	=> {
									'type'			=> 'int',
									'size'			=> 2,
									'interface'		=>	'eeprom',
									'endian'		=>	'little',
									'address_id'	=>	22
								},
								'conversion'	=> {
									'type'			=> 'float_configtime',
									'factors'		=> '0.1,1,60,1000',
									'value_size'	=> 1.6,
									'value_map'		=> {
										'type'	=> 'integer_integer_map',
										'01'	=> {
											'device_value'		=> 0xC000,
											'parameter_value'	=> 0xFFFF,
											'mask'				=> 0xC000,
										},
									}
								}
							},
							'long_off_time'	=> {
								'logical'		=> {
									'type'		=> 'float',
									'min' 		=> 0.0,
									'max'		=> 982980.0,
									'default'	=> 16383000,
									'unit'		=> 's',
									'special_value'	=> {
										'not_used'	=> 16383000,
									}
								},
								'physical'	=> {
									'type'			=> 'int',
									'size'			=> 2,
									'interface'		=>	'eeprom',
									'endian'		=>	'little',
									'address_id'	=>	24
								},
								'conversion'	=> {
									'type'			=> 'float_configtime',
									'factors'		=> '0.1,1,60,1000',
									'value_size'	=> 1.6,
									'value_map'		=> {
										'type'	=> 'integer_integer_map',
										'01'	=> {
											'device_value'		=> 0xC000,
											'parameter_value'	=> 0xFFFF,
											'mask'				=> 0xC000,
										},
									}
								}
							},
							'long_jt_ondelay'	=> {
								'logical'		=> {
									'type'		=> 'option',
									'options'	=> 'ondelay, on, offdelay, off, no_jump_ignore_command',
									'default'	=> 'on',
								},
								'physical'	=> {
									'type'			=> 'int',
									'size'			=> 0.3,
									'interface'		=> 'eeprom',
									'endian'		=> 'little',
									'read_size'		=>	2,
									'address_id'	=>	26.0
								}
							},
							'long_jt_on'	=> {
								'logical'		=> {
									'type'		=> 'option',
									'options'	=> 'ondelay, on, offdelay, off, no_jump_ignore_command',
									'default'	=> 'offdelay',
								},
								'physical'	=> {
									'type'			=> 'int',
									'size'			=> 0.3,
									'interface'		=> 'eeprom',
									'endian'		=> 'little',
									'read_size'		=>	2,
									'address_id'	=>	26.3
								}
							},
							'long_jt_offdelay'	=> {
								'logical'		=> {
									'type'		=> 'option',
									'options'	=> 'ondelay, on, offdelay, off, no_jump_ignore_command',
									'default'	=> 'off',
								},
								'physical'	=> {
									'type'			=> 'int',
									'size'			=> 0.3,
									'interface'		=> 'eeprom',
									'endian'		=> 'little',
									'read_size'		=>	2,
									'address_id'	=>	26.6
								}
							},
							'long_jt_off'	=> {
								'logical'		=> {
									'type'		=> 'option',
									'options'	=> 'ondelay, on, offdelay, off, no_jump_ignore_command',
									'default'	=> 'ondelay',
								},
								'physical'	=> {
									'type'			=> 'int',
									'size'			=> 0.3,
									'interface'		=> 'eeprom',
									'endian'		=> 'little',
									'read_size'		=>	2,
									'address_id'	=>	26.9
								}
							}
						}
					},
					'values' => {
						'state'	=> {
							'operations'=> 'read,write,event',
							'control'	=> 'switch.state',
							'logical'	=> {
								'type'	=> 'boolean',
								'default'	=> 0,
							},
							'physical'	=> {
								'type'		=> 'int',
								'interface'	=> 'command',
								'value_id'	=> 'state',
								'set'	=> {
									'request'	=> 'level_set',
								},
								'get'	=> {
									'request'	=> 'level_get',
									'response'	=> 'info_level',
								},
								'event'	=> {
									'frame'	=> 'info_level',
								},
							},
							'conversion'	=> {								# conversion config
								'type'		=> 'boolean_integer',
								'threshold'	=> 1,								# values > treshold evaluated to true
								'false'		=> 0,								# 0 is false
								'true'		=> 200								# 200 is true
							}
						},
						'working' => {
							'operations'=> 'read,event',
							'ui_flags'	=> 'internal',
							'logical'	=> {
								'type'	=> 'boolean',
								'default'	=> 0,
							},
							'physical'	=> {
								'type'		=> 'int',
								'interface'	=> 'command',
								'value_id'	=> 'state_flags',
								'get'	=> {
									'request'	=> 'level_get',
									'response'	=> 'info_level',
								},
								'event'	=> {
									'frame'	=> 'info_level, ack_status',
								},
							},
							'conversion'	=> {
								'type'		=> 'boolean_integer',
							}
						},
						'inhibit' => {
							'operations'=> 'read,write,event',
							'control'	=> 'none',
							'loopback'	=> 1,
							'logical'	=> {
								'type'	=> 'boolean',
								'default'	=> 0,
							},
							'physical'	=> {
								'type'		=> 'int',
								'interface'	=> 'command',
								'value_id'	=> 'inhibit',
								'set'	=> {
									'request'	=> 'set_lock',
								}
							}
						}
					}
				}
			}
		}
	}
);

1;