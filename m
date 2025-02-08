Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2128.outbound.protection.outlook.com [40.107.22.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441832475DC
	for <linux-ide@vger.kernel.org>; Sat,  8 Feb 2025 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739022159; cv=fail; b=FDlifVHU9f1woxUBrZKJCyrHsXpWliWHBvbx50H0jS/+IMr69w2Yhh1NOeGMc2KN/7zm9wFZAuhWcOZCH43oyVeQi+w5THCZamni80RmdFBj+YcIuNuTZnaufBvIgs+VmnhKN66AFCG+Le/tJZ8PA8YPyT51JJCfSdV+HZD5Jbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739022159; c=relaxed/simple;
	bh=pied94lYREDso4NR7BuXB1CfMoDzQ5niU4hZDKZIl1w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gT9wG0hc7xSMXVv1+m2wu/xOUiFG84CrKhvVZ6F4YnoFPQMg+9vstQFKAvlWnOtp+YyNS2rDXMg7bag+2hUMdikT9TJ1A4yL+ZWlRzDtQ66DIt/3KSP/bAtndku6EKWd57j/IL/VjfZScFNMdt5rl7LVaSdBf9HiZ26H4jorIa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=bPTGQkhe; arc=fail smtp.client-ip=40.107.22.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="bPTGQkhe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGwOWPaB40QWPxGxOA8jYVH8A8JrOyhIj4mtkQxCwypJefiHIJ5fXmSEEu6tqXZALlqFdz1/Le7mnQTUjbC8R2CllDkAiM6otUm4llZiQimi9cecVByEdmEHMTOjCdIcgfysPfOWQeS7SsXaj+PXu/xALsLB2r4nuCLrITgp0xggVBJ1anFGLxJ9BYtrQyiEzAfsiPYfIdbd7M3QbLklrrDi2xcyGh559MyFBRCKq8ncumX29GyYeHPInfGIjhklzjUFuIHfUsl3dX2l8V6+jM/AdCAMaHKHrHV8aOzdwI/6a4AZUo3w6zyYOhjd2mV7Pp9gb05ihR4ByhXKDVvPgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pied94lYREDso4NR7BuXB1CfMoDzQ5niU4hZDKZIl1w=;
 b=HZVjlzrkejcpWGVg6KrJLECVognVAGQ0kLjyCMRrIPaoLg4/zUe6Ig+QeYobAXnIGnJIY8/Xr5AVvABfM5rf/kLvTvrkj0kUQViXB1J1Ine5wUH1F+u9ssZtF1BHN/hsZ0JIzoDzx1Necp4EC2DNmojKFp5x1IOUG5tJYkn5LVZQP1BW5savqjF0T1yVq1BlgweR4GQfQDFDOZmG41UfE801eaATIqLIg7LW+EVaXaRVozPYO7GtFjRpTU5oaT7VYb75qNyuobBOYPaLwnEEOsD8xXcKpDO2c6Cu6OP+HrDjCE22L+ozMrj20JLJIWCDiIjuHw3Eb5CpkkCSJ4w+Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pied94lYREDso4NR7BuXB1CfMoDzQ5niU4hZDKZIl1w=;
 b=bPTGQkheVCebMwp+lEkpI3f9h9R4eB+MeEFv83F+jPqrQ6k30UE+stDXkYvQvRKrHNH6CW7QgbJzECYJIIE7Yu0hV5wORU/9JBXRgjbra0ghMfl/dx+beNfd9sJInKmVN1x2U9xRE0nY7n6rJIJk+dEmQyvYhn4s+hMC6y3OR4s=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PAXPR04MB9469.eurprd04.prod.outlook.com (2603:10a6:102:2b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Sat, 8 Feb
 2025 13:42:34 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%6]) with mapi id 15.20.8422.012; Sat, 8 Feb 2025
 13:42:34 +0000
From: Josua Mayer <josua@solid-run.com>
To: Damien Le Moal <dlemoal@kernel.org>, "linux-ide@vger.kernel.org"
	<linux-ide@vger.kernel.org>, Niklas Cassel <cassel@kernel.org>
CC: Klaus Kudielka <klaus.kudielka@gmail.com>
Subject: Re: [PATCH v2] ata: libahci_platform: Do not set mask_port_map when
 not needed
Thread-Topic: [PATCH v2] ata: libahci_platform: Do not set mask_port_map when
 not needed
Thread-Index: AQHbebhJgQJh+i0to0yM7ION65YSe7M9aywA
Date: Sat, 8 Feb 2025 13:42:34 +0000
Message-ID: <e0c77e98-3ab2-4381-809d-261a3386ff03@solid-run.com>
References: <20250207232915.1439174-1-dlemoal@kernel.org>
In-Reply-To: <20250207232915.1439174-1-dlemoal@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|PAXPR04MB9469:EE_
x-ms-office365-filtering-correlation-id: 620c562d-8742-4cd0-419c-08dd48467167
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V2FJSWRGWVVOdGdrRUdYbjRUUk5yKy9SUU1Hc203QkVsSlJvVGR6MGxBZjZ5?=
 =?utf-8?B?WkE0WDZQbU5tYVVEVFB6RTNvTlhHY2FEaGJMcEs5M3pZVXVYUWNNWklaMG5G?=
 =?utf-8?B?dXhkNDhqcW5MMjMvSXNwd3FSQk55eGRTVzlMRXdQbHN5Y1UzYTB2azZSMEdP?=
 =?utf-8?B?Ni9pNHlEenBTN1NWSVRlMmVmVlptSlpNUjBRQU1pb0FXR2ZyM2xCNWdNMUdX?=
 =?utf-8?B?bmdHaUZZbVYzZUJIanpmOUxMNEdpc0tLZDByWlMybG5UK0VVMVowS1pUYkMx?=
 =?utf-8?B?bEswNGRoNnBJNnJvN0NVd3dvb20wME1rZzc1MGt4OWxCRnY0QU1iL2I2eHN1?=
 =?utf-8?B?bS9tc2pOSzk4bGxyQysxTk16MGRaNXVUVmd2bzFZakp0dm9NT2NHV0ZJVW9E?=
 =?utf-8?B?SXVqazlWNE5vQjY5YW05czl0dkx2a1ZBOG1PbFVLTWZUSkpWQ3RNYVl6dExH?=
 =?utf-8?B?aWpzWk5yYmFMNmM0TVd1SVBsZEdseFhZbHFNOFpZRVhzdmFiZEN2ZXVGKzBx?=
 =?utf-8?B?VFdqcVlVOGhFSitaMUpjeWdkUWtBUGkxRHBRdWoyM1lPaTlMQlR6bURUclo5?=
 =?utf-8?B?NSt6SGdRUFlqVldVOGZCbmZmVjJvTmVUN3VKQmlsb3Y5L2FrVnErZ1AzTXpB?=
 =?utf-8?B?eTBuVWNkS3d0a1o1d1BFZ3RSMThiY2tiN0ZMdFhZS2d2VDhFTmUycU5iWlQr?=
 =?utf-8?B?RHhwb09ZT3M2R0VQa1lNMDBGczlmQVFZakpkcDZ4R1VNN2VzVHhUSFhTUmVh?=
 =?utf-8?B?bmtuclpXaERQdHRMaU9wenF4OFJ6M01UNXc3UEw2UCtRVjFzcGpoVXM0U014?=
 =?utf-8?B?N21HaTM4MUhpTEpxYUNjWndWMEJqcjc1a2dTcVQxcEVoTkR6OW10MzJ2QzdG?=
 =?utf-8?B?MjMwVlhSWDBBTmJCRUlrSkN6SC8yMFg0TThjcGZhZ0w1WFVVUDdZMnJmUzR3?=
 =?utf-8?B?d0FZVVM3ZHl6Tkd5dDcyZk4yWnRkVVlzWjBnUEdNblBxbnA5MTlDYk5jenlY?=
 =?utf-8?B?dGg3K0NxdWRJZmV2STU4Z0JhSWZZSFB0LzYrZVhlRmcxMnh3TU1GZ1FBVko4?=
 =?utf-8?B?N0Z6c2VwcGNhTkJlWFQ2RmlSVks5Z3Q2cnJ0TUdzOHVxTHBzbCtVMUFqeG9W?=
 =?utf-8?B?T2hvdDhuZ1pvdnlQL3Qzc21IOVg4RUZXM3NJdUJjQkJ5dnl3VG05K2c3b2pj?=
 =?utf-8?B?bTBmaEZJVnY3Vk14QjB4ZVBwOFZuMXIvRnpNM2pQZ3Z0eEZsY2JIM2hpYWcx?=
 =?utf-8?B?VVl4eWJGQVN5anBNdExyQ2ZlT0c5clg0UXJRTkJKTGlsRTAyL29RRThNV2hm?=
 =?utf-8?B?akRWRTAzWTBSeWZTMVExRnhCQ0JzTG9NZCsyeFV5dEZ4QWRiZFJYb2RETExv?=
 =?utf-8?B?MTRyc3V5WE9pT3BKanA4K0M0RDhhYmp2eVdZODdUV3BJK0IwVUdWUVk2QTZj?=
 =?utf-8?B?QjRyYnhYNTdJUlBIL204aVo1SDRLMVk2UVNlbGduQllYTkxQaWYxaU1wZnh4?=
 =?utf-8?B?cnkwbGt1aTRzTXJFZ0lPN0R0QjBhYXJob2R3U3Rnc1pHZk12dXhBdDlKSDho?=
 =?utf-8?B?T05zK2hZUjNXMm0wNnRUQWdmSEFXSDlGdExLS09GUkYyQ1hnVWQ4ZTBlUTlq?=
 =?utf-8?B?L0p0ckRMTzFFY0Q3SXRlNnpvV0RrSEQ2c1VTd1l6QllOYVIzZXdBNkhDN29W?=
 =?utf-8?B?eVNTb3BrNHE4RW1kbnpTUXcxT1ZUUERSWkIzcnN0aTV4OXVWZTZhTjJCZ3Yr?=
 =?utf-8?B?TkltMFFnY1NJQjgyT2hSUG5UQ3Ard3FpbkhmNFdmV1N2L0lCOVpLSy9RaGs2?=
 =?utf-8?B?REV5cndYNzZGSGh3emJpVW1zM1lmeXp1ckxWWlZ0SGw0K1NNdGFQRjlld2JO?=
 =?utf-8?B?L2IwYjFPRkdaQ2xVTEtYQlQrSmtkeWJXWHAxSmVBRG16cHpLcHBxVjZRMFor?=
 =?utf-8?Q?jzpCLbgo+bYKtnoJ2lNHNQDyqMttCb2H?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UlpxbjNKTGRPWm5IMS8yVmtCN2xjdTl4U3lYei9PMUdXL0EzTUJYZlJNR0Qw?=
 =?utf-8?B?SUxzZ0lnWElRWFlCK2QxRVNCRmJSbDF5b2FuOU90a1JQMEt0ZUNwdnNEbkJ5?=
 =?utf-8?B?RmFuNU9nN1FTTzZUbUdleHZjRHdPUDhvOE9zNjIyUS9lSVF3dXV0N2RVZVJk?=
 =?utf-8?B?bVpTdndiVytTcE5MdlNHb1hBZlFHWW0zRlhxUjc1TFE5eTIxWGx1NEZXS1N5?=
 =?utf-8?B?VnBRUU54WTJ0WG9XbzE3cGduSjdFRE9uYzBqZG5UUVZuME9ROXpGS3hMWWxR?=
 =?utf-8?B?NDJqUE1GZXY0cGhhTTlwdkhqZmlRLzNCWnBkV3Q2bDh5S2kxd3lFa0hWZnBv?=
 =?utf-8?B?SXBFT3NoYzJKc2xwWkMwelZhMVRETk9LQ051WTZyKzNXS1FyNmRhS1ZqbDRF?=
 =?utf-8?B?MUtQOHlmVElkc21YeW5scXFNZU5LRG1pSnpKbjhDaW1yU21iMjhqVWsrbzZr?=
 =?utf-8?B?SnpieGhiSDFDY2FJbkRZNS92Um9XeHZNdUdJbVJvZk9DS0h5c0l0YSt2bXRU?=
 =?utf-8?B?RnJISGNMQjZLcmVSdU9CV3VXcEJHMkZ0TVlyc2lraGhlcVJwSFkvLzlFL1NT?=
 =?utf-8?B?UmJmdkVjYlJtMksxanRIclg4R3l3S0ZYU2lxeDVCemFScTQxWGdEMmRGZ1ZI?=
 =?utf-8?B?TVUyZjBXdzZ5aXUvU2IzaEt6Sk1MMW8wbWFZOUs5eG9Ua3VlRlJBZ0RSazhQ?=
 =?utf-8?B?ZzlMMzRIcjBPQzR4cWtTckpiT2VCeXhkY25SYmFtZDZYeVMzQ00vam5LczJK?=
 =?utf-8?B?ZGI3T0lxNVFock5ha29aNWJzdGowM0tSSU1MdHk3K2M3QTZXdjhicmcrRVhJ?=
 =?utf-8?B?czRlWEJremJKdU5Rd1VKTzhLYTZQU1Q2N0dMUXIyMkJENkJEUmRnUnNUR0xp?=
 =?utf-8?B?QmZOME9zQkxDak42OWs4R0w0bVdlK2UrZ1pseUNtdThrOU1Sa0lmNkc1L0dE?=
 =?utf-8?B?MEZmdjQ5SUtzN0VnYzVOVitkRnVtclZPV3FLNlh1QjY5VnQxcnJtc1NnR3dH?=
 =?utf-8?B?S2JlVEZpTURXeDFVZnRRZWQ2LzNEb1djbmJCUUJpRzUyMm1wejcrOHRvMW5u?=
 =?utf-8?B?RVJ1T052S3FodEsxbHpjczV3dnZMWjczWE9OVEJVbzgyRzAxam9CS2ZQUGxi?=
 =?utf-8?B?SEFteHl0UWF0dXdSa0hlSElWTW1qa2JHUUt3b24wNCt5N1pwSndWK1hMRHpO?=
 =?utf-8?B?MVZkT0FaWkQ2YnUybXdGNEtXTjBHb0RyU3JPemdyL1YrYVdaQVkxdlhOZ1M4?=
 =?utf-8?B?RVE2dVZiRUpHcC80Z00zQytLV2VDbldZU09aZVdRWXhJR3BFV2ZBWnRvL0p1?=
 =?utf-8?B?MWJsYmZGdThPbDhWL1FIM0tFWFNiWGlncEFvcW9YaTE4MHVmY3c4Y1MzSkN6?=
 =?utf-8?B?NUNtNFhGTWRRNi82dFBta1cwNlF5UE1GenlaNFNqN2VsOENvazluUnppSTk4?=
 =?utf-8?B?UDdJMzlaNG1QVWx6MXJjbUZEU2QvNDhkeWI2RjVZdTQyc08vR3dEeUpLK2NE?=
 =?utf-8?B?a3FncEY3OVNtMVcrQnZDVlREUFNLeWJOMjB1ZE1SVU9ES3pMNWRHbmhuRmZq?=
 =?utf-8?B?TTJqYXpqWkZ0dFhRNSt4SWliWUZzYnpGTURGZFdKZWdlekZOQU45d0M1Yk4z?=
 =?utf-8?B?a1NxRzJ5aE1vdy9kalZhb3lUT0ZPUEtQVy9SMXgrRTFRelRJYTliM2Z3UWQ2?=
 =?utf-8?B?TGpxU1J1end3T3BmNk5LVVord3o3WDQ0RkUvb3gwNFM0eW9ERnZaV1VKZDZK?=
 =?utf-8?B?S0hyVTA2aThLL005V0dOb2pNOFpSanJsMTh6TkFWNUNpdm5UbE10d2Y5YUMx?=
 =?utf-8?B?WjllY3lDSFpkVVo4WjI4S0w3a3hvaWFBMzVkbitDY3hxOS81b0VMc0s0ZkZ5?=
 =?utf-8?B?cjluWm1JWlBNMThTQ0RXMFZhRzFaQ0o3M2ZGbzBRRE5ObTRwOXphWjdqd0x4?=
 =?utf-8?B?a3FoOXozYndMWTdTTWNFNGE0Ukc5NzBXUmlyWWo0bFFNUDhlS21UamttQnRK?=
 =?utf-8?B?R1RhaS9PTGU3U3JYUWRnVEs3d09tUGVaeXF4SWl3SCtTYXZiREMrTjhlZStn?=
 =?utf-8?B?R2hlNEtKTGE2Qzg4cjIvWTNDNzdzS3JzZURPS1pPSDQyamNNU2pob01GMC9o?=
 =?utf-8?Q?/P6/Ctdy8Z+S6DdGj2sbo6dq5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBD4E3A675242C41818A996FD200FAF9@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620c562d-8742-4cd0-419c-08dd48467167
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2025 13:42:34.3721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2K8xwfEmaCpzPQF+WcNeQVNrIwZG2QJfyv0d+ayZ1JHD1RtUZlACnzWSEmnZ7KweqNOe+oWBVFM31RFw/hUg3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9469

QW0gMDguMDIuMjUgdW0gMDA6Mjkgc2NocmllYiBEYW1pZW4gTGUgTW9hbDoNCj4gQ29tbWl0IDhj
ODcyMTVkZDNhMiAoImF0YTogbGliYWhjaV9wbGF0Zm9ybTogc3VwcG9ydCBub24tY29uc2VjdXRp
dmUNCj4gcG9ydCBudW1iZXJzIikgbW9kaWZpZWQgYWhjaV9wbGF0Zm9ybV9nZXRfcmVzb3VyY2Vz
KCkgdG8gYWxsb3cNCj4gaWRlbnRpZnlpbmcgdGhlIHBvcnRzIG9mIGEgY29udHJvbGxlciB0aGF0
IGFyZSBkZWZpbmVkIGFzIGNoaWxkIG5vZGVzIG9mDQo+IHRoZSBjb250cm9sbGVyIG5vZGUgaW4g
b3JkZXIgdG8gc3VwcG9ydCBub24tY29uc2VjdXRpdmUgcG9ydCBudW1iZXJzIChhcw0KPiBkZWZp
bmVkIGJ5IHRoZSBwbGF0Zm9ybSBkZXZpY2UgdHJlZSkuDQo+DQo+IEhvd2V2ZXIsIHRoaXMgY29t
bWl0IGFsc28gZXJyb25lb3VzbHkgc2V0cyBiaXQgMCBvZg0KPiBocHJpdi0+bWFza19wb3J0X21h
cCB3aGVuIHRoZSBwbGF0Zm9ybSBkZXZpY2VzIHRyZWUgZG9lcyBub3QgZGVmaW5lIHBvcnQNCj4g
Y2hpbGQgbm9kZXMsIHRvIG1hdGNoIHRoZSBmYWN0IHRoYXQgdGhlIHRlbXBvcmFyeSBkZWZhdWx0
IG51bWJlciBvZg0KPiBwb3J0cyB1c2VkIGluIHRoYXQgY2FzZSBpcyAxICh3aGljaCBpcyBhbHNv
IGNvbnNpc3RlbnQgd2l0aCB0aGUgZmFjdA0KPiB0aGF0IG9ubHkgaW5kZXggMCBvZiBocHJpdi0+
cGh5c1tdIGlzIGluaXRpYWxpemVkIHdpdGggdGhlIGNhbGwgdG8NCj4gYWhjaV9wbGF0Zm9ybV9n
ZXRfcGh5KCkuIEJ1dCBkb2luZyBzbyBjYXVzZXMgYWhjaV9wbGF0Zm9ybV9pbml0X2hvc3QoKQ0K
PiB0byBpbml0aWFsaXplIGFuZCBwcm9iZSBvbmx5IHRoZSBmaXJzdCBwb3J0LCBldmVuIGlmIHRo
aXMgZnVuY3Rpb24NCj4gZGV0ZXJtaW5lcyB0aGF0IHRoZSBjb250cm9sbGVyIGhhcyBpbiBmYWN0
IG11bHRpcGxlIHBvcnRzIHVzaW5nIHRoZQ0KPiBjYXBhYmlsaXR5IHJlZ2lzdGVyIG9mIHRoZSBj
b250cm9sbGVyICh0aHJvdWdoIGEgY2FsbCB0bw0KPiBhaGNpX25yX3BvcnRzKCkpLiBUaGlzIGNh
biBiZSBzZWVuIHdpdGggdGhlIGFoY2lfbXZlYnUgZHJpdmVyIChBcm1hZGENCj4gMzg1IFNvQykg
d2l0aCB0aGUgc2Vjb25kIHBvcnQgZGVjbGFyZWQgYXMgImR1bW15IjoNCj4NCj4gYWhjaS1tdmVi
dSBmMTBhODAwMC5zYXRhOiBtYXNraW5nIHBvcnRfbWFwIDB4MyAtPiAweDENCj4gYWhjaS1tdmVi
dSBmMTBhODAwMC5zYXRhOiBBSENJIHZlcnMgMDAwMS4wMDAwLCAzMiBjb21tYW5kIHNsb3RzLCA2
IEdicHMsIHBsYXRmb3JtIG1vZGUNCj4gYWhjaS1tdmVidSBmMTBhODAwMC5zYXRhOiAxLzIgcG9y
dHMgaW1wbGVtZW50ZWQgKHBvcnQgbWFzayAweDEpDQo+IGFoY2ktbXZlYnUgZjEwYTgwMDAuc2F0
YTogZmxhZ3M6IDY0Yml0IG5jcSBzbnRmIGxlZCBvbmx5IHBtcCBmYnMgcGlvIHNsdW0gcGFydCBz
eHMNCj4gc2NzaSBob3N0MDogYWhjaS1tdmVidQ0KPiBzY3NpIGhvc3QxOiBhaGNpLW12ZWJ1DQo+
IGF0YTE6IFNBVEEgbWF4IFVETUEvMTMzIG1taW8gW21lbSAweGYxMGE4MDAwLTB4ZjEwYTlmZmZd
IHBvcnQgMHgxMDAgaXJxIDQwIGxwbS1wb2wgMA0KPiBhdGEyOiBEVU1NWQ0KPg0KPiBGaXggdGhp
cyBpc3N1ZSBieSByZW1vdmluZyBzZXR0aW5nIGJpdCAwIG9mIGhwcml2LT5tYXNrX3BvcnRfbWFw
IHdoZW4NCj4gdGhlIHBsYXRmb3JtIGRldmljZSB0cmVlIGRvZXMgbm90IGRlZmluZSBwb3J0IGNo
aWxkIG5vZGVzLg0KPg0KPiBSZXBvcnRlZC1ieTogS2xhdXMgS3VkaWVsa2EgPGtsYXVzLmt1ZGll
bGthQGdtYWlsLmNvbT4NCj4gRml4ZXM6IDhjODcyMTVkZDNhMiAoImF0YTogbGliYWhjaV9wbGF0
Zm9ybTogc3VwcG9ydCBub24tY29uc2VjdXRpdmUgcG9ydCBudW1iZXJzIikNCj4gVGVzdGVkLWJ5
OiBLbGF1cyBLdWRpZWxrYSA8a2xhdXMua3VkaWVsa2FAZ21haWwuY29tPg0KPiBTaWduZWQtb2Zm
LWJ5OiBEYW1pZW4gTGUgTW9hbCA8ZGxlbW9hbEBrZXJuZWwub3JnPg0KPiAtLS0NCj4gQ2hhbmdl
cyBmcm9tIHYxOg0KPiAgLSBJbXByb3ZlZCBjb21taXQgbWVzc2FnZSAoZml4ZWQgdHlwb3MsIGFk
ZGVkIGV4YW1wbGUgYW5kIHJlbW92ZWQNCj4gICAgY2Mtc3RhYmxlIHRhZykuDQo+DQo+ICBkcml2
ZXJzL2F0YS9saWJhaGNpX3BsYXRmb3JtLmMgfCAyIC0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBk
ZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRhL2xpYmFoY2lfcGxhdGZv
cm0uYyBiL2RyaXZlcnMvYXRhL2xpYmFoY2lfcGxhdGZvcm0uYw0KPiBpbmRleCA1M2IyYzc3MTlk
YzUuLjkxZDQ0MzAyZWFjOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9hdGEvbGliYWhjaV9wbGF0
Zm9ybS5jDQo+ICsrKyBiL2RyaXZlcnMvYXRhL2xpYmFoY2lfcGxhdGZvcm0uYw0KPiBAQCAtNjUx
LDggKzY1MSw2IEBAIHN0cnVjdCBhaGNpX2hvc3RfcHJpdiAqYWhjaV9wbGF0Zm9ybV9nZXRfcmVz
b3VyY2VzKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQo+ICAJCSAqIElmIG5vIHN1Yi1u
b2RlIHdhcyBmb3VuZCwga2VlcCB0aGlzIGZvciBkZXZpY2UgdHJlZQ0KPiAgCQkgKiBjb21wYXRp
YmlsaXR5DQo+ICAJCSAqLw0KPiAtCQlocHJpdi0+bWFza19wb3J0X21hcCB8PSBCSVQoMCk7DQo+
IC0NCj4gIAkJcmMgPSBhaGNpX3BsYXRmb3JtX2dldF9waHkoaHByaXYsIDAsIGRldiwgZGV2LT5v
Zl9ub2RlKTsNCj4gIAkJaWYgKHJjKQ0KPiAgCQkJZ290byBlcnJfb3V0Ow0KDQpBZnRlciB0ZXN0
aW5nIG9uIEFybWFkYSAzODggSGVsaW9zLTQgYm9hcmQgd2l0aCBhbmQgd2l0aG91dCBwb3J0IHN1
Ym5vZGVzLA0KSSBjYW4gY29uZmlybSB0aGF0IGJlZm9yZSBteSBwYXRjaCBhbmQgd2l0aG91dCBw
b3J0IHN1Ym5vZGVzDQpib3RoIGNvbnRyb2xsZXIgcG9ydHMgd2VyZSBmdWxseSBvcGVyYXRpb25h
bC4NCg0KVGhlcmVmb3JlIEkgYmVsaWV2ZSByZXN0b3JpbmcgdGhlIG9yaWdpbmFsIGJlaGF2aW91
ciBoZXJlIGlzIGNvcnJlY3QuDQoNCkFja2VkLWJ5OiBKb3N1YSBNYXllciA8am9zdWFAc29saWQt
cnVuLmNvbT4NCg0K
