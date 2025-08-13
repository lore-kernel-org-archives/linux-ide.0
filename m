Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176532FE591
	for <linux-ide@vger.kernel.org>; Wed, 13 Aug 2025 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755082843; cv=fail; b=n5P4/a2EtZLTulM/clXoe8q3LBYbhaV8gowQRXTLBJNrAobau3Hqi4ufDVK7hOuCR+iVTleiShj2sRy1RFkwfNt0D1nXfRCztD827btdu879dOHYw8VJm6P4cBv0IKmQJn1xZfFVkm4UoPuEADsGoWk9mSsGlBJ5gJObDyyCAcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755082843; c=relaxed/simple;
	bh=ahRo9325Ecm9Mct0ECe8i0EsJZElMeIJoBBuB1Hcddk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u3GsG/h/C9B3nvtQsBIaW8lLkRuxj7NauZO6Mv9h2Fby6vg42UJjssptpF1roBkFLsOr9d0QeCgbrUA/vwKyosk+pM1dxIM+/4qHv1BAZ0MxKBVOBegCn0LauoDdCAvH+TOEmacK3+LRAonoSQgdPq/j7GNLJIyEv4gwZMki14I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VUujpcRY; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ugoqP/Zq; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VUujpcRY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ugoqP/Zq"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1755082842; x=1786618842;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ahRo9325Ecm9Mct0ECe8i0EsJZElMeIJoBBuB1Hcddk=;
  b=VUujpcRYZO3QygrSo0lDraMa66iVNOSJeBYM/WH8c636YTCgtCmonKcG
   HN9AN5yCQNUYsrG0kJKrmN4xsHVAriUqe5HO6obUfjUl+gdnuFDRwBX1S
   rfIvA0Xn42ush3w8kJXaRtQYyeTJR6UR8dbTWQFGAv3QNlAF2E0zoBpbE
   eG98aSJ38X9qumiwSWZboG9vrz72kUunV6Umxvjt8Xfyjt3p6A2//NCbz
   C5EBN93jDml163lvC6+XU8yNWTj/fKdH7SNkBemkrCct04c2FqwYgKb6k
   bJuLf4iFR98tvqWdZwwNBdPxtJm+NHbmujqAGIIyPAZIb0v9EWO2em4+X
   w==;
X-CSE-ConnectionGUID: mttinJGcSq2N9vV7cEDTWA==
X-CSE-MsgGUID: JhSFeLX7SCqeT70dYLqKQg==
X-IronPort-AV: E=Sophos;i="6.17,285,1747670400"; 
   d="scan'208";a="109205210"
Received: from mail-mw2nam04on2075.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([40.107.101.75])
  by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2025 19:00:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTBUXB9gSAA2UtmoYp3vMl88k34ffDzfiPveTbFrmPZrEbjJYfGWCivL/nJlcbrVR3QwkIzXBmtRhdEAbsMPNSGZY6UcHVQRYParUAgRNt/3zNFhzUuUZDCCof8dyLJXvMg6isMsH9/gnMfpzLhDZykICWMXZvnpDP7NnB7MTqtsTAwD4U9XeEYrrFiGBfhLYtIWpZvC/pSNsK5Kr6gNDgKBN6hZcxWtHX5/6vsinwPMDoHgYSXSB5cTC4RJabwxY8iFIvY+gP972GghzGHToKqd+ADf6Av6a2xPqPYvw92VO+WZfzjXmeKkX9UTKJlm9jOoL7o5fr4BVAKJEr7y1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahRo9325Ecm9Mct0ECe8i0EsJZElMeIJoBBuB1Hcddk=;
 b=JvEblZxeRublyPeDydjLAyVZ5Wy5BBpqKM8LL9KGv3pFXIh45OArzivn3RGK3yJFSjTpensmKW2tVgUI1NgDtWr4wMY4oel4POwLt/LckjGDZAjr0BEkRRnxXWpBAiSwG1lGghNDlYFawbBZTny4xD/PGU5tRhwVDlHF26Qp76zAcC50ByNmurfMXb2hyXevoYBoLxcp5RCffm5Cnb5d1fxn9Ub/Rk0q36yVxGoRIHMLUk3pB03Orma0OYkA9/FNrTeN/kQf0fWlKS0A9Q3coB3VqmH/IxFKm7PhpL2wBiiogGJL43pi8Nxyk74csmvIPdkCD/rUR7i1zywOVmWfvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahRo9325Ecm9Mct0ECe8i0EsJZElMeIJoBBuB1Hcddk=;
 b=ugoqP/ZqtIQrCozhnVon5/55EWx6mysX+BlLhyj+Swu1+RFmO0MCwFZ2UHSHKWR4/nbsbz4D1oCrSKrB7z/443rcOswLWpr2t1zWKvBY4dfwlo111AzxVabOLFPGtRGXYeY79JX62Ev2CvPLMQYQC6ri46j5OaFcwG1ZN+ouSZA=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SJ0PR04MB7807.namprd04.prod.outlook.com (2603:10b6:a03:302::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 11:00:39 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%6]) with mapi id 15.20.9009.018; Wed, 13 Aug 2025
 11:00:38 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Niklas Cassel
	<cassel@kernel.org>
Subject: Re: [PATCH] ata: libata-eh: Fix link state check for IDE/PATA ports
Thread-Topic: [PATCH] ata: libata-eh: Fix link state check for IDE/PATA ports
Thread-Index: AQHcDDTVYCXMYfT3tUq7LSIi+87yG7RgapWA
Date: Wed, 13 Aug 2025 11:00:38 +0000
Message-ID: <j5xdnnvvkkxuthxdtjqauu2kttzw5rywzspqx6vqkiykatkkk6@cwjp6fqgyxkj>
References: <20250813092707.447479-1-dlemoal@kernel.org>
In-Reply-To: <20250813092707.447479-1-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SJ0PR04MB7807:EE_
x-ms-office365-filtering-correlation-id: 738c4323-1543-48d8-bbae-08ddda58a33a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?DfE9I8tWJFhOqgyIbz0CYtEE57LoDbmU+j0vpN0bc5F2qkPFesJ2gL2hzWJL?=
 =?us-ascii?Q?feF0xchr0mjq8zcwJ6wJbWbpYzWg/ifcogIGpkjIqCVM/da+T2sDJ52Yo9ex?=
 =?us-ascii?Q?PRWhBW9SKxJSalAy8rnpEcmfNoeeEadpnyC2gOVDzi6bc/zoGLHMfT6rcGLd?=
 =?us-ascii?Q?4AZRZhQ4gIW1di80yXXtl/4evxYHBOfQWuXehIVan6GIa4VdqsZj2oOafEAP?=
 =?us-ascii?Q?7ShbhQx71eiDAkyTfj7I9FrqjseGo3y9OjGWW3yeTgLdA+LTja/mr2V86YaV?=
 =?us-ascii?Q?duteOx0EXS26F85y4g8y+w8HCVNSnOsB84yrxgg+YPpIVFKJg6URJ3NN03K5?=
 =?us-ascii?Q?cRGTo6VKFUrwLzNoGJkWCFX2QANmSItH61JahEfew9mkMPnZJ0IvHTnelu9J?=
 =?us-ascii?Q?P59NNTwbapn82PYXOOM7R0m4QN17PA0U4V9qxn0a6RCun7wFhKzKXncbUzSK?=
 =?us-ascii?Q?BeIo/9sWtluW0uNpXOc4cYxwRss+TfKI8ej6q2Is1UfjesoeqIHDkpArtxdf?=
 =?us-ascii?Q?pMTXE0ZO2JKl80KAEDMUN5kc32GUtELsHWVqlV1AL++uaE4hmQ3bVoroozT0?=
 =?us-ascii?Q?7nAxOvlEr5LsXD93yIPXYzr4KZaFQmLAySCzgxxHX6lUNDVSNiEI0cOZES0N?=
 =?us-ascii?Q?Y3r4I2DZ8Vt5QGODESFdKbh+I3MmeBrurE7eqj0pvd6tOCoE45bLbYN08JNN?=
 =?us-ascii?Q?NkVSoASrRdkTs26cWW96RntQqPjV7R4z4HyvACkjE0sFhfSSFx03/me20t2g?=
 =?us-ascii?Q?lblBOzCzX+UjglZsV2UwEb2UeLRzmyFy5wUBb/YGLaMfdPxIa+9GkPxk3lMf?=
 =?us-ascii?Q?2fYrX/J+17zhOOvDXomEGzKPhHG9JxwHjuCB+iF8iyKgCA+QZYJ9EqLK2uEn?=
 =?us-ascii?Q?OJ0XWhKcPB2C+hEbJwnev5WW3opoozQVUwvrmZENno8c/E4L47ISx28JUNPC?=
 =?us-ascii?Q?afVta32XoYBh5sRgTqtt+o+G5Vy8wBe5+IrLud1T0sc/QDdIduexTI0knrVk?=
 =?us-ascii?Q?D45OkPjftmaE6yHrAbml/rdGgX822wmFBW6GUoFoTDCLXFr4W+YMyQFyHqO5?=
 =?us-ascii?Q?KBgD7/w8N66fhY+Gb55mDN2rlOgh5QSJNODV8IV8dt4ef3Z+v2kZorwq/wCM?=
 =?us-ascii?Q?eGaTp1Ug4Gy0/k9QLQyPXZ5kktpx2GQAZmIRAOdwqphGbW8Mpbzw5HIsdJiE?=
 =?us-ascii?Q?Ntu5MZQepo0jItZU5+oGKuAnnb4plAW9xKri6g+5SciqKbgC4oADRls/krBu?=
 =?us-ascii?Q?JRBB28SdF9RK9qs0lvdOXLxjggtByr6LRbIfcsdBUp58s7Gxel6DUJd7BQ/z?=
 =?us-ascii?Q?UDqCuCATbfKCsJM8T9a+2CIwJEhhXpmhdgeg3LQ4+x61AotIbSdG9vSJAP3G?=
 =?us-ascii?Q?vT+mWTp7i4meGWuq+oJST/AdVpJ0coBX9+qOdCtfOMVNktT1duOwda2DMLY6?=
 =?us-ascii?Q?t9uyK8Sy6jE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tjUurFsydFtfYJtja59TH/hKE6zXSGT5xD2NB2DOt6d4aDkXON7hA4EZhhtD?=
 =?us-ascii?Q?+cSoDNd6AQy241w30lMS43HPXChi+mV6Qr6G7Ks+LhrluHOOAOyHisoxlth8?=
 =?us-ascii?Q?wQNpJkeCZE2fx3xBYCRDnr76W79KrD2A4DH+XUa3DfCKL34vnn+e0phPcsHJ?=
 =?us-ascii?Q?ezlN1ddFMzVYMm9LElrrRG5ieB86feluZMhotH6Iz3PpU61o2KyJ5gP+63QB?=
 =?us-ascii?Q?s22nwGkw1igyvMa02pFRREksfLzLP5LGXJAm0BHUuCZWdGvt8GVzeyDguaCk?=
 =?us-ascii?Q?/+VgISzw5Km1h/zirH/WVJNBXe4GzzCDeeybsBhEP9TD0jVqA1C2ZK9aZAR6?=
 =?us-ascii?Q?39KneICSbP58yiYt5YLRzFGYL9Vh6oEj6TjSVKh3Wy+DtV6xw5WTvV1Qi0Q1?=
 =?us-ascii?Q?hGXw/pRb6C0e5V9HKt5ZaTLgbgb/U7TCaGyu13KjfvlkHyBFyAY5WoW+Nx39?=
 =?us-ascii?Q?KQunNZkOIw6HOKl4MLJAhcqTBDMTJOovIHpdZJgamxJQtOusT6h7OqNQHnbu?=
 =?us-ascii?Q?Hrqxng7K77Na0RCtmq4ff0I/V7g/6XoQa/lK28kKcweFKcDQCLtgUJwLEkgm?=
 =?us-ascii?Q?vUzHGLg/rGYgAHvmXG02pPCYL+04jZ2NoA3qhS/DWMFykamW5BB/sccOTd2I?=
 =?us-ascii?Q?z6OYQsOZgOs/N8Ww38l4/V12H4DMqflrHVxWuY0e/GppUmi5U4HaUR9POhQm?=
 =?us-ascii?Q?xvtEAse71T2DGKG+ezH7Ub2gAB94lTfoCrE6UpaGyDv9UYaTK4aIVfRKy3+W?=
 =?us-ascii?Q?FolPkENeZyFKgzjo6CI/LmfYN1a91fTORR8UnmhVEezdOFE4dChvWyAhN0tP?=
 =?us-ascii?Q?3NvX9cyR8qbXLnzOKh0kqWPEHgvcYD6udKioC9tfHp3DAzXfNsw1AAo20Ks2?=
 =?us-ascii?Q?UKl53iPg+dNaR8bznuXd8oCR/3leSb8L2NgRpvtNlHs+Pqr66Mec84OxSlFM?=
 =?us-ascii?Q?sjIdy/xeK3EH67RmHf5yyGVpKXuGig49CJJ7LHFo00zW/N9UIdPl+6IvWs9M?=
 =?us-ascii?Q?eUMuHg8sTk9F8v3/CVTOMB8uxLE9geWomGszkjlZNgsEPBfRIGfD+0E1qhUb?=
 =?us-ascii?Q?qMQuuAiOABgqQVji03fejPZbDYEsMqyrmo9BZRx6x9Gbc5BT7ajeZXkq4fSs?=
 =?us-ascii?Q?VHBAw8gzSaxaIBV/87tgXiG9fN/l/aLm8BL+ivqpZI5IVIEDeOacXf3I0WNe?=
 =?us-ascii?Q?JJk+X6ek+XMff9QPEDungx5o2NMTITSX5tMJppYhaPc7h1jeHbtzkBwtP9Vp?=
 =?us-ascii?Q?GNwzmTh+1AlekZaIJiHPaCUaa3XBov9CPBAARm7UJM9lzApZBYfZC1Ek7xUY?=
 =?us-ascii?Q?NJTJTIGocU9OOOFWZRMSS3/kKHy359IgcqWaV43CA0S9ROZ4os7ut9IMBWpN?=
 =?us-ascii?Q?RSmu4z4yhRoAbgGwjRpvPxjTIl9DjgxxSdspq8BdwaS12rpShvXCPESLvrg9?=
 =?us-ascii?Q?J6U9YbWTiV3/FBXs6iptavUOR0E+Cc6gZ/vaoFMsS4siY/YzikchORSrVyb0?=
 =?us-ascii?Q?ybrPV99TOQmxgyxquRMq3v9mSTZ5f+F+OiN47J9/pJAvcCNY5n2KKwG4zBAN?=
 =?us-ascii?Q?WQPjWvf+H89UHLCFgjKXhSRKKqq3gOMU0oTdsrfG/X2XRO3xvRbwoWa1vf4g?=
 =?us-ascii?Q?18/EJaD1HnKL2yRcwoaGeEs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6BC66D34AAF0E747B982CB3EA01A7C8D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o55zaBTYFFSLS1vROatvjbqcebRLDkvb/2GvJXL/21aI9GYKWD7WaSigv7i8pdrxeuZVv1s3SIt5qnEJIX6GJYcANJZfHLpuhQtANEd/7IssKyvRKPtBWndqCmn1mz23nZYG18sRMXgNPV4A0apLPMdwR6hWCMxoc4aPd+NThkRbxk6Dj3w1dj+xuRNlGnF1q16uWssFRPOByxBnDLv73lrY5Rhxf/PWZmelK6Gco1fglXIq0EsDl/O09O1X2wsPyyWG0A5ce+LbDg5/d1a6gtye5fDI+rZ5FvNrUBgPCV8eqO7HxSBLMJwVFST2+fuz5QQ1/1ghWkkJqMGI/OR+Fe4hFM5NF4EraDUKG9MPmpFq4nF0RkQ5rYyVTN9T96aCGZ6n77KsL5qCwaUj3B+OKzAiFcTaG5GjyDfPQx+JGzvhm/cP451Ke+VCzV1GQtV+tyFPVrfnNbJueb340ebD5LEpdVR9EAu57qR+2T3/13E8aKMrMJLiOeiktY7kSFoanC3gFPc1iffH3kJrv4fT9XtG7NZ49sAfYrkmpIpKgIL+/+bhVL/5SxqG1gCPtytyHFPjFfOmzLh/5D9pWXpjtWjSXeJBdag+vz6qxZnhjaGtfbtGk6Oa59gy73aNlyA8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 738c4323-1543-48d8-bbae-08ddda58a33a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 11:00:38.6598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a6Dsb9WBrQpNX5x3ALCMCxS0GLaYZ/Ifd5e1PZJ162/7cJoexYwkGYYpStP5aLQeSQyas22m2KMosvSIbM2BGjTX3KZ3sYmf3Ik+3abEPWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7807

On Aug 13, 2025 / 18:27, Damien Le Moal wrote:
> Commit 4371fe1ba400 ("ata: libata-eh: Avoid unnecessary resets when
> revalidating devices") replaced the call to ata_phys_link_offline() in
> ata_eh_revalidate_and_attach() with the new function
> ata_eh_link_established() which relaxes the checks on a device link
> state to account for low power mode transitions. However, this changed
> assumed that the device port has a valid scr_read method to obstain the
> SSTATUS register for the port. This is not always the case, especially
> with older IDE/PATA adapters (e.g. as emulated with qemu). For such
> adapter, ata_eh_link_established() will always return false, causing
> ata_eh_revalidate_and_attach() to go into its error path and ultimately
> to the device being disabled.
>=20
> Avoid this by restoring the previous behavior, which is to assume that
> the link is online if reading the port SSTATUS register fails.
>=20
> Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Fixes: 4371fe1ba400 ("ata: libata-eh: Avoid unnecessary resets when reval=
idating devices")
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Thank you for the fix. I confirmed that this patch avoids the failure of
blktests test case scsi/006 with QEMU IDE/PATA device that I reported [1].

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

[1] https://lore.kernel.org/linux-block/suhzith2uj75uiprq4m3cglvr7qwm3d7gi4=
tmjeohlxl6fcmv3@zu6zym6nmvun/T/#u=
