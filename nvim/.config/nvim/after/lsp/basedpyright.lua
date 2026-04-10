return {
	settings = {
		basedpyright = {
			analysis = {
				diagnosticSeverityOverrides = {
					reportUnannotatedClassAttribute = false,
					reportImplicitRelativeImport = false,
					reportUnknownVariableType = false,
					reportUnknownMemberType = false,
					reportUnknownParameterType = false,
					reportUnknownLambdaType = false,
					reportAny = false,
				},
			},
		},
	},
}
