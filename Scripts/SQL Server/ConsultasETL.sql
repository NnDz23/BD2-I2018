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

/****** DIM-USUARIOS  ******/
SELECT [CODIGO_USUARIO]
      ,[CODIGO_TIPO_USUARIO]
      ,[NOMBRE_USUARIO]
      ,[URL_FOTO_PERFIL]
      ,[FECHA_REGISTRO]
  FROM [master].[DB_FLIPBOARD].[TBL_USUARIOS]



/****** DIM-HISTORIAL_ACCESOS  ******/
SELECT [CODIGO_USUARIO]
      ,[FECHA_ACCESO]
  FROM [master].[DB_FLIPBOARD].[TBL_HISTORIAL_ACCESOS]

/****** DIM-LUGARES  ******/
SELECT [CODIGO_LUGAR]
      ,[CODIGO_LUGAR_PADRE]
      ,[CODIGO_TIPO_LUGAR]
      ,[NOMBRE_LUGAR]
  FROM [master].[DB_FLIPBOARD].[TBL_LUGARES]

/****** DIM-TIPO_LUGAR  ******/
SELECT [CODIGO_TIPO_LUGAR]
      ,[TIPO_LUGAR]
  FROM [master].[DB_FLIPBOARD].[TBL_TIPO_LUGAR]

/****** DIM-TIPO_USUARIO  ******/
SELECT [CODIGO_TIPO_USUARIO]
      ,[TIPO_USUARIO]
  FROM [master].[DB_FLIPBOARD].[TBL_TIPOS_USUARIO]

