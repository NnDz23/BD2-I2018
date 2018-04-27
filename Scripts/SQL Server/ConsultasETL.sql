/****** DIM_TIEMPO_NOTICIAS Y HECHOS_IMPACTO_NOTICIAS ******/
SELECT A.[CODIGO_NOTICIA]
      ,A.[CODIGO_CATEGORIA]
      ,CONVERT(DATE,[FECHA_PUBLICACION]) FECHA_PUBLICACION
	  ,DATEPART(DAY, [FECHA_PUBLICACION]) DIA
	  ,DATEPART(MONTH, [FECHA_PUBLICACION]) MES
	  ,DATEPART(YEAR, [FECHA_PUBLICACION]) ANIO
	  ,ROW_NUMBER() OVER(ORDER BY FECHA_PUBLICACION ASC) CODIGO_TIEMPO
	  ,COUNT(B.CODIGO_NOTICIA) COMENTARIOS_X_NOTICIA
FROM [master].[DB_FLIPBOARD].[TBL_NOTICIAS] A
  LEFT JOIN [master].[DB_FLIPBOARD].[TBL_CATEGORIA] C
  ON A.CODIGO_CATEGORIA=C.CODIGO_CATEGORIA
  LEFT JOIN [master].[DB_FLIPBOARD].[TBL_COMENTARIOS] B
  ON A.CODIGO_NOTICIA = B.CODIGO_NOTICIA
  GROUP BY A.[CODIGO_NOTICIA]
      ,A.[CODIGO_CATEGORIA]
	  ,FECHA_PUBLICACION
	  ,DATEPART(DAY, [FECHA_PUBLICACION])
	  ,DATEPART(MONTH, [FECHA_PUBLICACION])
	  ,DATEPART(YEAR, [FECHA_PUBLICACION])

/****** DIM-CATEGORIAS  ******/
SELECT [CODIGO_CATEGORIA]
      ,[CATEGORIA]
  FROM [master].[DB_FLIPBOARD].[TBL_CATEGORIA]

/****** DIM-NOTICIAS  ******/
SELECT [CODIGO_NOTICIA]
      ,[AUTOR_NOTICIA]
      ,[TITULO_NOTICIA]
      ,[FECHA_PUBLICACION]
  FROM [master].[DB_FLIPBOARD].[TBL_NOTICIAS]



/****** DIM_TIEMPO_USUARIOS Y HECHOS_DATOS_USUARIOS  ******/
SELECT A.[CODIGO_USUARIO]
      ,[CODIGO_TIPO_USUARIO]
      ,[FECHA_REGISTRO]
	  ,CONVERT(DATE,[FECHA_REGISTRO]) FECHA_REGISTRO
	  ,DATEPART(DAY, [FECHA_REGISTRO]) DIA
	  ,DATEPART(MONTH, [FECHA_REGISTRO]) MES
	  ,DATEPART(YEAR, [FECHA_REGISTRO]) ANIO
	  ,ROW_NUMBER() OVER(ORDER BY FECHA_REGISTRO ASC) CODIGO_TIEMPO
	  ,COUNT(B.CODIGO_USUARIO) INGRESOS_X_USUARIO
	  ,C.INTERESES_X_USUARIO
	  ,D.CONFIGURACIONES_X_USUARIO
  FROM [master].[DB_FLIPBOARD].[TBL_USUARIOS] A
  LEFT JOIN [master].[DB_FLIPBOARD].[TBL_HISTORIAL_ACCESOS] B
  ON A.CODIGO_USUARIO = B.CODIGO_USUARIO
  LEFT JOIN (SELECT W.[CODIGO_USUARIO]
			,COUNT(X.CODIGO_USUARIO) INTERESES_X_USUARIO
		FROM [master].[DB_FLIPBOARD].[TBL_USUARIOS] W
		LEFT JOIN [master].[DB_FLIPBOARD].[TBL_INTERESES_X_USUARIO] X
		ON W.CODIGO_USUARIO = X.CODIGO_USUARIO
		GROUP BY W.CODIGO_USUARIO, X.CODIGO_USUARIO) C
  ON C.CODIGO_USUARIO = A.CODIGO_USUARIO
  LEFT JOIN (SELECT W.[CODIGO_USUARIO]
			,COUNT(X.CODIGO_USUARIO) CONFIGURACIONES_X_USUARIO
		FROM [master].[DB_FLIPBOARD].[TBL_USUARIOS] W
		LEFT JOIN [master].[DB_FLIPBOARD].[TBL_CONFIG_ACTIVA_X_USUARIO] X
		ON W.CODIGO_USUARIO = X.CODIGO_USUARIO
		GROUP BY W.CODIGO_USUARIO, X.CODIGO_USUARIO)D
  ON A.CODIGO_USUARIO=D.CODIGO_USUARIO
  GROUP BY A.[CODIGO_USUARIO]
      ,[CODIGO_TIPO_USUARIO]
      ,[FECHA_REGISTRO]
	  ,CONVERT(DATE,[FECHA_REGISTRO])
	  ,DATEPART(DAY, [FECHA_REGISTRO])
	  ,DATEPART(MONTH, [FECHA_REGISTRO])
	  ,DATEPART(YEAR, [FECHA_REGISTRO])
	  ,C.INTERESES_X_USUARIO
	  ,D.CONFIGURACIONES_X_USUARIO

/****** DIM_USUARIOS  ******/
SELECT [CODIGO_USUARIO]
      ,[NOMBRE_USUARIO]
      ,[CORREO]
      ,[FECHA_REGISTRO]
  FROM [master].[DB_FLIPBOARD].[TBL_USUARIOS]

/****** DIM_TIPO_USUARIO  ******/
SELECT [CODIGO_TIPO_USUARIO]
      ,[TIPO_USUARIO]
  FROM [master].[DB_FLIPBOARD].[TBL_TIPOS_USUARIO]

