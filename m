Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2065.outbound.protection.outlook.com [40.107.117.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03942158203;
	Fri, 27 Sep 2024 02:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727404853; cv=fail; b=fk3ED4ThBak5WYI+1G/fgqek/8VeHOa2cG57yxabbvwfwLidonCRzQqoPlx3zl+NbewCbnxXXmYWvxiJSRYNgW7kK0U/oy15+a6CrOIjM/GowbDA7lVx79NaDx4znkytpKSEJ+L3m141lTIPFI0YkCBsPHNZ1sCa0ATJydgoPzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727404853; c=relaxed/simple;
	bh=cWYBQkVliZjUSHqj1czrYuN4HZpmhf+8RG1xA05OwoE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=avHY90xt4Y/fC4nrVDwDJwU61lHGtRv2cn91ZFk7Iu+c+KtgEGi3q5V6X8JucUeyToYV8BlaX9aQEIe4ZOi2PTV/mx5a+emj0L8ABYJtbAKAF2UX9hOZdzn+hfwrwJjBZ0Tusmqm+LAWJDjUTmThV11YNHNKCgcan7nsjbosjns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=m9p8neLX; arc=fail smtp.client-ip=40.107.117.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="m9p8neLX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzUbh1tdhpaCDP6ghTjYBH4cpNkLSklgzSE/WBgKJQ/j65WQnYIeBB7zCco0Ve3n+F+Oq7WFNTl/T8v7Nx2IejTo6Pt8Om3W0RYbPDNgg9Ju3ecjQ53e85fmPs5xn3zPDCQsX973Rh+BfQjE1mgiu0vqV+HZBqe8lHFwP8m3A4kJ7FbWgTCsUsdR5b8TA3o1dFClbo27hSeCUi3kbWdoHnEc+zNfnynbsyo8ZEo1i1klW4QGV4qaEgtIGP1aVqpabQh9xOG04mU/xQSCk+Ex8ctlPR9VZUfg/5zdFh8xT7SsNRFzXqGHuC2NAIBgSpFydQUMHfsQQieUNNSXWDJrYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrGqklFWJQal629fgCN0PPhug0BBqS3v9KHFFJWT+5A=;
 b=lRwMOg7+O1HsfOfxanehpDpbnf0SpCKMWj/VVg45FqrvA7vioR94UU4dg/o1OPGZLKvOtY5tVnVO/rr6f8OPsdV0SgTALF0+2eafbzMBwDZBT7ff4P7ET1pE/DQnp+YbvR5MGrECWuD54lTI//+ET+acTvNOeskS8L+lFOgYCu91xmW6/6izLlACmoCH24CL+Rhmp7Z2+i+Xb+reEspo1fsrdbc5cGQWKSNvOEnuQcFt2OlStWRT0qdmruFjN2xBH9VcEzNiv3yFcZ8YQsztvK/1nxwgQjg0BqDWcT4yyj6mAj2clkE4XlIAIMhX36SWvQxavOkYCmtlz46ayPxSAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrGqklFWJQal629fgCN0PPhug0BBqS3v9KHFFJWT+5A=;
 b=m9p8neLXR9RonwhQnJmBELKD3sg/vZJOr/ZJQmYL/vxrvh0MsQvkXmQW/SpDtB8UBskEreh802QeGbvFC0ep3QGcsf9SbzWMfOijUhlrk61fXGwLiFRi3wiNobni0QO64oCPgJLDlfjIfckejGXWMpKG8CUnDnaEutjU9Qm5FjC2djcTXSReJ7w1BjxxpZMXudnstPdUcVNCIPPY2hsUUka6NSFmlp/7uK7uUnrKiuV8edtEge12mxcFKnvqLZKFZZXk6NdIZKq3U10FFnJU8V09kEEbUmNf0/jVtmB4YGiJzJAYeFZ/g5re4+5O8hsd/N9Tf/9jugW456fvPXrSQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4128.apcprd06.prod.outlook.com (2603:1096:400:22::9)
 by TYSPR06MB6628.apcprd06.prod.outlook.com (2603:1096:400:477::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Fri, 27 Sep
 2024 02:40:45 +0000
Received: from TYZPR06MB4128.apcprd06.prod.outlook.com
 ([fe80::2bb1:c586:b61b:b920]) by TYZPR06MB4128.apcprd06.prod.outlook.com
 ([fe80::2bb1:c586:b61b:b920%7]) with mapi id 15.20.8005.020; Fri, 27 Sep 2024
 02:40:45 +0000
Message-ID: <b4a9e472-e2db-4115-99f2-4d1b702cfc46@vivo.com>
Date: Fri, 27 Sep 2024 10:40:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: Fix typos in the comment
To: Yan Zhen <yanzhen@vivo.com>, dlemoal@kernel.org, cassel@kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de
Cc: kernel@pengutronix.de, festevam@gmail.com, s.shtylyov@omp.ru,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 opensource.kernel@vivo.com
References: <20240927013301.4162772-1-yanzhen@vivo.com>
From: yanzhen <11171358@vivo.com>
In-Reply-To: <20240927013301.4162772-1-yanzhen@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY1PR01CA0184.jpnprd01.prod.outlook.com (2603:1096:403::14)
 To TYZPR06MB4128.apcprd06.prod.outlook.com (2603:1096:400:22::9)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4128:EE_|TYSPR06MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8ae8e2-c651-4121-583e-08dcde9dc96a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|43062017|81742002;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlZ1RHpmeXpDNFJES3VWT0tLUEhLTzE0eUdhS1ZsbGQxc0Z5NmdJUWI3cU16?=
 =?utf-8?B?NE5uK3RReWtuWlBnMzhWTDhzWXlPQUE1S0xySHNUQVV2MnZXNlJKSmdnQUxF?=
 =?utf-8?B?U293amhqSGV5M0o3VHYvOUsyeHczU1dtSzZ5R0xpSVBHRDBQT2RCMm1TQnBE?=
 =?utf-8?B?ZGp1Y05FbUlnek5CbU9BZFVoRlNmdWpBUG11NnYrd0ZNYy9DMXVITU43bDFI?=
 =?utf-8?B?bWRqZmJtZEtReCswZVkwOHlKZ2ZMdFdNZ0h2U1QybkhvNTBvTklycnYraWhX?=
 =?utf-8?B?T25lUERtMGRjdXVpQ2NMWHVUdk0zeUxDcUxrRDc1azdzc1RWa1pBcDR6V25h?=
 =?utf-8?B?eUVKSVp6L3pjcVBrbGU5SE9LY1NkZ28vNi9QYXdzaW1GcUp1ZnpLQ282YSs0?=
 =?utf-8?B?d3M0Q1ViSWZnZWNaTmxsK1FjUzBEa01NY1JrSG1lOFdJUHpqSHd2b3c2blR2?=
 =?utf-8?B?emNYczdHUi9HQ1JyeVZ2WHNPMGFQbm5RcTdsS0pPYnJsdDdEZ2h0TmlzWmNX?=
 =?utf-8?B?aVlKMXRoREFhK2dnN29DZ2NrRjhyaENVZDkxbnhsTVdDVzduOHYzQlFkZzY5?=
 =?utf-8?B?Vys0WHFSQVBoSUVoU2ZFeVY3WU1sQlI0OFhjSmlhbDdkNWV4TjJmSjl4RnQw?=
 =?utf-8?B?NkZTbUYvZnRON2laa1FNRVYrK2lrdmthV0lyUGlGckJINmJmN1o2bzJWR2RB?=
 =?utf-8?B?a01zOWlhM0U2SG1ycWJCMjBsTmxLSWNjdlhiYWlkWlBHMXFpUFRLUjhiUGJO?=
 =?utf-8?B?UElqUE9CamNHaTVtcXptV1RGNUluNmUra0JxT05RTEF2SysyN0VzNWZWdE05?=
 =?utf-8?B?RzNPajNORzNRd29FZGlGMlRXb2RqMUN0VUdsejdDZnFrbE9WVUVFZ3VjY1VF?=
 =?utf-8?B?dG93Yzl3emRhbjlYVHdpS0ZHWi9JNGFFeHY4UGJjTUNad1g5S2wzL2RjOXZi?=
 =?utf-8?B?U1Y4S3A1RWtHbDNuQ0d5SnRqNDBQTW5hVGlVb0lkdExkY0FNcjd0bFU0aHZ5?=
 =?utf-8?B?aE5iSGJDQjNaSEFmRFhJT3REVld4UUxQUmx4NTNiRll2cGRWa2hBKzZNTVh6?=
 =?utf-8?B?VUc0WXlqUXlhR1o5N3l6MzRYeXJIallRRVBtVUU3N0thbm03aWV2b2hHMXg1?=
 =?utf-8?B?K09FazQ0a3Rxek94N3A0K0Jpc1l3Tkg3MUo0UUtueG5haHYwNm15NlZoSnZY?=
 =?utf-8?B?QXVKZ0R6RU9Vd1ZUTGc1eTNNeEVEWkhRSytsMVJIZ0hDVkhvOEhsTDJ3VCtl?=
 =?utf-8?B?cFNGSnR4aVd1VnlvVmIvOWp4ZnVDL1M5SG5LR2owdFltaDJVdzBMbjM4OE5u?=
 =?utf-8?B?aGlvRnBFb0hRYnZ6cEI5T211NkV5OVRYbjdCUXBuRDZnTzI4eUp0U2UxS1A2?=
 =?utf-8?B?VlFyYjB6M2dlOVNYRmI0OWZJQWdkVmJ2L0djTDhhQndMZFJnSEJLdkhMdnlO?=
 =?utf-8?B?NmFGK1lwYXVZdXdHMXFpL2pQcWZxbSt1U1kyMDkxUVZaTjAvcGZIdllKT2tR?=
 =?utf-8?B?dnpucXpFWkxjeitZdGxadlBKNHEzZDd0c0VSWVZnRHMzSk1vWVZhOXVTczVl?=
 =?utf-8?B?aDVlL3orSnJndEIxb3ZrazlUZW1odU5mVXoxZmlKOE0xZ0xYNjZ4Z3U4VDND?=
 =?utf-8?B?dXNIV0ZVL0ZoZFNwWHIvZnpCdjI2V0Jvc0xPVWFDNHd0MHVmR0JTUE5PczIv?=
 =?utf-8?B?VExvcnpxajJZbFI1aEdBZ2NwVFVoQ1U3aGFkRUZsa1JvMWRjbUpVdHVmQUI4?=
 =?utf-8?B?a2pEMXYza0pwSUhMNGRUTjRlMldLRlJGODhDK0pTeXc2Y1ZxRitWZ2xPTHZW?=
 =?utf-8?B?dTRmdFNpYTVjcE9zQ0cwcHdGWUY5UXNhTXFLbTlRTXliRGxUeDA1SnE1UnAr?=
 =?utf-8?B?WFBXS1VxdFUrakVqVmdXTnFlSmR0eHpCWmJVTk1ZcFN1NU8rTkZuUTZrZldL?=
 =?utf-8?Q?arjIrPutIAo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4128.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(43062017)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVk2eUc2ZDlUbzJVRTE3ckxQQU0zQXF0QXIzMEYzenQ2K0Y0T2cvNWE2S1Rh?=
 =?utf-8?B?eFpDdk5VRHY1MmR2bjZ4Uk1zb2xLc0dCOFZzRzF0UHBKdkdSZkdLVE1Xb1k0?=
 =?utf-8?B?WndaUmJWd1pYZGgrRi9PQmtrME9zTlRETFBVdHpRU2V3YUxUV25BOGRWd1hS?=
 =?utf-8?B?RlJVeG9aM2M5d0l6cVkzelJiSC9Iczk0SlZzMkpxWFlOZVFZRGJHckpuOHdW?=
 =?utf-8?B?UGtCYlFodkl5NHh2WmdTZC9IZ1RCTGVQbzdHZlUvSitnVUxOaHRyNmVRV2xB?=
 =?utf-8?B?dEJ2RFZVT09MVVpCMTZOTTBsOXl6dmZldmhOOUJ5SzRSbHRBTzczampxWXVy?=
 =?utf-8?B?YXEwVDdXUGdKRWNMRlFvME1DcTFyd1ZlcVVGQng4SjB1UWZ5TklNV2NBL1cy?=
 =?utf-8?B?TGNhTUpaYUdyWm91c1F2djFHWUdubHhVckVoTTNBc2UxL2NMUkdvQXp1K0dY?=
 =?utf-8?B?RlphWXFJY2tibTJtSy9lMXh3WjJjdHBiWEVFNkFNVEpWWDZJUit3YkVjNGtw?=
 =?utf-8?B?T1BYbWtBNm9vakNNUTRvTnBBVGM4NE9LUVNHK1Nqdnk4RlNEeWQzY200MCt5?=
 =?utf-8?B?bU43RFMxaUUxVUVJdFgyb3JRTmVWbWFrVkIxc0doRGN4Z0ZuRHpBK3JmNVZ1?=
 =?utf-8?B?Yi95eTFrOHN3U1I0MmJlSDQrZGlLQU5IelFkemJTMXNlTVdaYjdQdjlwZnlp?=
 =?utf-8?B?dHFHME5OZU1JZmthZFJRR0llVk15UmRNRG9jTHRWMFFVcjhrWVNWclVrblVP?=
 =?utf-8?B?dldqaFFvYmN0QlN3TllOTGVReE5DZFBxaFNBdzdtZTl5cGNhSDkrcFNEN2xy?=
 =?utf-8?B?LzNtc3ZsZVMrWVE1VDFEZzN1eEl5MksvV0dxVndVcXROOXNzZ3VDN1NUM1JY?=
 =?utf-8?B?MG1lOXY5MDdVZUp0TCtZdU9zZGdCVVU0bDlWTnNmMlJwVk1xczRMVWlyOGZL?=
 =?utf-8?B?T2NUK3o4ODNBOS9aSzZRUFprbHVhSkhIaGxVaDFTa0FoMGZUUjBCekJyK1dT?=
 =?utf-8?B?aUpQQmwraWJFTDhJQ1loN2o1azR2eFFZUUZEY0VUUE55K3FlQlZ0cFI2eEZD?=
 =?utf-8?B?UnprdjN1UCtkeGRSaS9xYkhaUkV2MnRUQ3FkMlRKNjlnZUpuWU9GWE5VdXN6?=
 =?utf-8?B?QmxFT0llamg2ZHJCeHVSSUxpdi8yN1VZb2VoZGlmRzh6WDFUMjZXcGN3SmVX?=
 =?utf-8?B?MnY3ditYSkROWnlub2l2VDZNTks5UW81VGRUOGhNWThUc1pmcVAzNGU3MnZ3?=
 =?utf-8?B?bFBTd0pZWmhzZXBHTEZlMUlBd0wxWGQ4NW4wYjNRVHM2eHZCV1lsY2JDVUZm?=
 =?utf-8?B?ckZJNVplNEFuR3dWcHNZcWpMY3R4ZEV6MmhyanIweWJlSlJLS2hjbE5KK1or?=
 =?utf-8?B?V3M1czVhY0psLzVJcFp0TE93VjRSb005eUVBK3VsT0R0SmJiWWVVL0JiSDBp?=
 =?utf-8?B?UThFU0F3TzAxbnFoUHUvZzFEYXhyNGlQenA5bkcwNDRMSEJ4bFZjRTc3ZjVw?=
 =?utf-8?B?UTFvUDh2bFJKbzdpZm5zckhkSFdSUUV2WVd0RG1oc0plQXMxQVNRUHpmVXVq?=
 =?utf-8?B?YzBrUmt3Y1dQd054d1BPSUNiUXhtb2RuL0dpWEJlT0p6d29vUEI4SXp5ek42?=
 =?utf-8?B?ZlRZc0JSTWlvcG1JM09kVzluSTd0MlI0Z3lKRk9LWjFmSXM4aDRxUjlWdWMz?=
 =?utf-8?B?dGRvczZRZ1k1ekpXMTFpc0JodCtjMDZoV2ZLTXBXUE5FUTVGdmxXRHZSaDBy?=
 =?utf-8?B?dFVxRldmNHdCR2hSdnQ2R2M3VzR2d2hmNkZNQ1hpUXdLQ3YxSlVFQ3U5RlJz?=
 =?utf-8?B?TDJ6NGQ1NkhYM3A0QjlvY3M0T1VsTXNIZFFwZWFxWE9zQUhNR0JCcVlmSEtQ?=
 =?utf-8?B?N2F0UElLTk9BSURjSDBDanZLWUJ3ZklNVWY4M05pZXZQTHFRWWhHMFIwU1NW?=
 =?utf-8?B?UlA2STNGdzA0b1BjckdUSGhqd3lFd2V0ajNZQXZtMlc3ckdPNHpuR3R1WUFY?=
 =?utf-8?B?QTNFL1A2T0s0QzRMMGRUcGxIejczY2ZFREpNaVBkNFhmNjliQ0ZjYzcyZlJj?=
 =?utf-8?B?VmxabEJBaVdrWVIvQTM2VHFCbEl5bXJTYXp5cUU2TngwQkI1Rk5zK0tZYWdP?=
 =?utf-8?Q?5SwOeUVF9sFYLFn1Nfg76XVo8?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8ae8e2-c651-4121-583e-08dcde9dc96a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4128.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 02:40:45.1152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EzrZQNM7gDo0HHleRsQjCopB4hgxmsq0ZrNWwyPUhweNna0jRyOrXYRR+khBv5m1mkHVrq9uIKaJt5nLKzMGVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6628

在 2024/9/27 9:33, Yan Zhen 写道:
> Correctly spelled comments make it easier for the reader to understand
> the code.
>
> Fix typos:
> 'multipe' ==> 'multiple',
> 'Paremeters' ==> 'Parameters',
> 'recieved' ==> 'received',
> 'realted' ==> 'related',
> 'evaulated' ==> 'evaluated',
> 'programing' ==> 'programming',
> 'coninue' ==> 'continue',
> 'Decriptor' ==> 'Descriptor',
> 'Lable' ==> 'Label',
> 'transmiting' ==> 'transmitting',
> 'correspondance' ==> 'correspondence',
> 'claculation' ==> 'calculation',
> 'everone' ==> 'everyone',
> 'contruct' ==> 'construct'.

Very sorry. A mistake was made in the typos description, please ignore 
this patch. I will submit v3.

> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---
>
> Change in v2:
> -In the subject, replace "typo" with "typos".
>
>   drivers/ata/ahci.c           | 2 +-
>   drivers/ata/ahci_imx.c       | 2 +-
>   drivers/ata/ahci_xgene.c     | 2 +-
>   drivers/ata/libata-acpi.c    | 4 ++--
>   drivers/ata/pata_it8213.c    | 2 +-
>   drivers/ata/pata_octeon_cf.c | 2 +-
>   drivers/ata/pata_oldpiix.c   | 2 +-
>   drivers/ata/pata_radisys.c   | 2 +-
>   8 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 45f63b09828a..2d3d3d67b4d9 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1676,7 +1676,7 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
>   	/*
>   	 * If number of MSIs is less than number of ports then Sharing Last
>   	 * Message mode could be enforced. In this case assume that advantage
> -	 * of multipe MSIs is negated and use single MSI mode instead.
> +	 * of multiple MSIs is negated and use single MSI mode instead.
>   	 */
>   	if (n_ports > 1) {
>   		nvec = pci_alloc_irq_vectors(pdev, n_ports, INT_MAX,
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index 6f955e9105e8..357aba1d5929 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -511,7 +511,7 @@ static int imx_sata_enable(struct ahci_host_priv *hpriv)
>   
>   	if (imxpriv->type == AHCI_IMX6Q || imxpriv->type == AHCI_IMX6QP) {
>   		/*
> -		 * set PHY Paremeters, two steps to configure the GPR13,
> +		 * set PHY Parameters, two steps to configure the GPR13,
>   		 * one write for rest of parameters, mask of first write
>   		 * is 0x07ffffff, and the other one write for setting
>   		 * the mpll_clk_en.
> diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
> index 81a1d838c0fc..7e6b4db8a1c2 100644
> --- a/drivers/ata/ahci_xgene.c
> +++ b/drivers/ata/ahci_xgene.c
> @@ -534,7 +534,7 @@ static int xgene_ahci_softreset(struct ata_link *link, unsigned int *class,
>   
>   /**
>    * xgene_ahci_handle_broken_edge_irq - Handle the broken irq.
> - * @host: Host that recieved the irq
> + * @host: Host that received the irq
>    * @irq_masked: HOST_IRQ_STAT value
>    *
>    * For hardware with broken edge trigger latch
> diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
> index d36e71f475ab..b7f0bf795521 100644
> --- a/drivers/ata/libata-acpi.c
> +++ b/drivers/ata/libata-acpi.c
> @@ -86,7 +86,7 @@ static void ata_acpi_detach_device(struct ata_port *ap, struct ata_device *dev)
>    * @dev: ATA device ACPI event occurred (can be NULL)
>    * @event: ACPI event which occurred
>    *
> - * All ACPI bay / device realted events end up in this function.  If
> + * All ACPI bay / device related events end up in this function.  If
>    * the event is port-wide @dev is NULL.  If the event is specific to a
>    * device, @dev points to it.
>    *
> @@ -832,7 +832,7 @@ void ata_acpi_on_resume(struct ata_port *ap)
>   				dev->flags |= ATA_DFLAG_ACPI_PENDING;
>   		}
>   	} else {
> -		/* SATA _GTF needs to be evaulated after _SDD and
> +		/* SATA _GTF needs to be evaluated after _SDD and
>   		 * there's no reason to evaluate IDE _GTF early
>   		 * without _STM.  Clear cache and schedule _GTF.
>   		 */
> diff --git a/drivers/ata/pata_it8213.c b/drivers/ata/pata_it8213.c
> index b7ac56103c8a..9cbe2132ce59 100644
> --- a/drivers/ata/pata_it8213.c
> +++ b/drivers/ata/pata_it8213.c
> @@ -81,7 +81,7 @@ static void it8213_set_piomode (struct ata_port *ap, struct ata_device *adev)
>   	int control = 0;
>   
>   	/*
> -	 *	See Intel Document 298600-004 for the timing programing rules
> +	 *	See Intel Document 298600-004 for the timing programming rules
>   	 *	for PIIX/ICH. The 8213 is a clone so very similar
>   	 */
>   
> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
> index 0bb9607e7348..dce24806a052 100644
> --- a/drivers/ata/pata_octeon_cf.c
> +++ b/drivers/ata/pata_octeon_cf.c
> @@ -183,7 +183,7 @@ static void octeon_cf_set_piomode(struct ata_port *ap, struct ata_device *dev)
>   	reg_tim.s.ale = 0;
>   	/* Not used */
>   	reg_tim.s.page = 0;
> -	/* Time after IORDY to coninue to assert the data */
> +	/* Time after IORDY to continue to assert the data */
>   	reg_tim.s.wait = 0;
>   	/* Time to wait to complete the cycle. */
>   	reg_tim.s.pause = pause;
> diff --git a/drivers/ata/pata_oldpiix.c b/drivers/ata/pata_oldpiix.c
> index dca82d92b004..3d01b7000e41 100644
> --- a/drivers/ata/pata_oldpiix.c
> +++ b/drivers/ata/pata_oldpiix.c
> @@ -70,7 +70,7 @@ static void oldpiix_set_piomode (struct ata_port *ap, struct ata_device *adev)
>   	int control = 0;
>   
>   	/*
> -	 *	See Intel Document 298600-004 for the timing programing rules
> +	 *	See Intel Document 298600-004 for the timing programming rules
>   	 *	for PIIX/ICH. Note that the early PIIX does not have the slave
>   	 *	timing port at 0x44.
>   	 */
> diff --git a/drivers/ata/pata_radisys.c b/drivers/ata/pata_radisys.c
> index 84b001097093..40ef8072c159 100644
> --- a/drivers/ata/pata_radisys.c
> +++ b/drivers/ata/pata_radisys.c
> @@ -45,7 +45,7 @@ static void radisys_set_piomode (struct ata_port *ap, struct ata_device *adev)
>   	int control = 0;
>   
>   	/*
> -	 *	See Intel Document 298600-004 for the timing programing rules
> +	 *	See Intel Document 298600-004 for the timing programming rules
>   	 *	for PIIX/ICH. Note that the early PIIX does not have the slave
>   	 *	timing port at 0x44. The Radisys is a relative of the PIIX
>   	 *	but not the same so be careful.
