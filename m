Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3313770D
	for <linux-ide@vger.kernel.org>; Thu, 29 Feb 2024 03:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709178761; cv=fail; b=AuQlonf0+BWPXb9axVyhNRZUXCl6a/AE/m0aNi99zi5wkRZzEgPlMQoRJ9GmPMGaAqo43pLf/sI0a7VnWlnEHOGC+EzJjffSbPQTnG1fFrB2Jmg8BM2W4tBN+j/BNxHt1bHTyFsGWRB7SIzlxr3tSzCnNTW959sKtJ0XqE33oFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709178761; c=relaxed/simple;
	bh=cNCIpPem5DWxyxT2fiy/PSgOPriZ+Xkc4ANQNvs9eAY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OZgXMDVzYgniExZLfW8n6Qj+TbfBR0yPLLMU39/dz+tu2S8CpKbluMzKyyr60ldFYoCyrPPhN+NvzLVcIhJxJO8/3yiJVm78nfJG98QfXZCWpBBHKiHr9MHk5ZhkBZ9+RjPKNMNfPSe/JxcD6nzyf63p4Kk4nP7fXM00M27F+GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=WsVyO56j; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="WsVyO56j"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41SHNfsF007323;
	Wed, 28 Feb 2024 19:52:34 -0800
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wj8e8tct9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 19:52:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSgisCe0z1QY4ySQztaMFrn1upX6Ve2atdVJwJaUS21CVFGnoT+J+eDJPfJ9kbZ2Sq/8A8O3byu3R+k4/6frdJ8ToF5j2q2bKqwWtUVIcBYUEGvTMsg1FuXW+OCitGRB7Z6GkNyGqMgA1HjxsfYI3AtHgmR4V3hwFrv2roB3/hByLe9CThIG7VkMiKiNC+7m+ZMG7uWc/l6QmG9DEuuB7JNHcEFOJNhGVZgcJbEXxXp36D0HDIRnEyJ6r97wF/AFDKc5kMlwPIHXDCnY6utT8tA6dSo1DXaXLwpRkgfW9t38x+HKrVEHoFnl4LIK2rpy55/qDNIgEYUtm9x5thOR2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNCIpPem5DWxyxT2fiy/PSgOPriZ+Xkc4ANQNvs9eAY=;
 b=h3cbwC1Z8z4HbUfljGPXInBOjsHXt3lTjLp27RiBe7lS2nOafPazhLhG9eXuEi3U/GqyNw/bcnyhwjipFYi1SXMUAyNSy/YiKqFhTt9stt59WJEnZOrwI5vzUohNJwv7nF9AlYw8TMIflHywRbwQSMsiHMUOJ8dVuP/CW9XUj748AlHTqxIbWuiut0/oVsD2QBh5wmKEYLeCgidrlIEInd/2s/0K6nFo1KZHj9cOdfQGsZCRz1cLc6mRXsKWqGhIoW60OyZWHxXJQmeipopAsO4R3kwhdEABmCl+IJHwi6oqWtmgx0bYYSB4JFpJdPcduI6ybdxkkuwdLeryGxkFRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNCIpPem5DWxyxT2fiy/PSgOPriZ+Xkc4ANQNvs9eAY=;
 b=WsVyO56j0/zUsNVkX7PdeeBjd3poZtMKYeouVuDcOMMv0+XOWBAIgR5ecwsYfmjnjg9kYCIVKPu7XShv/ddlpsgtPeUdGr4Ci/cY6cAO7anNrHSD2YJ/T84fefx3Nl+RJ86c77vhjPtkeXMxAni+4iQf89gxUHtURRFaW/28wFc=
Received: from DM4PR18MB5220.namprd18.prod.outlook.com (2603:10b6:8:53::16) by
 CH0PR18MB4177.namprd18.prod.outlook.com (2603:10b6:610:bc::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.39; Thu, 29 Feb 2024 03:52:30 +0000
Received: from DM4PR18MB5220.namprd18.prod.outlook.com
 ([fe80::e830:f8ac:b187:6270]) by DM4PR18MB5220.namprd18.prod.outlook.com
 ([fe80::e830:f8ac:b187:6270%4]) with mapi id 15.20.7316.037; Thu, 29 Feb 2024
 03:52:30 +0000
From: Saurav Kashyap <skashyap@marvell.com>
To: Damien Le Moal <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org"
	<linux-ide@vger.kernel.org>
CC: "soochon@google.com" <soochon@google.com>,
        Manoj Phadtare
	<mphadtare@marvell.com>
Subject: RE: [EXT] Re: [PATCH] libata-sata: Check SDB_FIS for completion of
 DMA transfer before completing the commands.
Thread-Topic: [EXT] Re: [PATCH] libata-sata: Check SDB_FIS for completion of
 DMA transfer before completing the commands.
Thread-Index: AQHaZh64LDdenN6GHECu6CcUhWKW5LEXea2AgAk/XSA=
Date: Thu, 29 Feb 2024 03:52:30 +0000
Message-ID: 
 <DM4PR18MB5220EB7026D3524ED9B1F04ED25F2@DM4PR18MB5220.namprd18.prod.outlook.com>
References: <20240223060752.4926-1-skashyap@marvell.com>
 <6e749e30-a35b-41f1-a4cb-97b6eff8328d@kernel.org>
In-Reply-To: <6e749e30-a35b-41f1-a4cb-97b6eff8328d@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR18MB5220:EE_|CH0PR18MB4177:EE_
x-ms-office365-filtering-correlation-id: c5ef27c2-d431-4f95-387b-08dc38d9da6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 BmT4JvmEMUmnohAE8QkPpJiRAMZDMeqyIE5+1FpoyoN+hIMbk0YCtY1B7iuOHyX5oRtLa6xINV46LMdMKVRzxJID78wrQIVvjOe13Mr2D9C059/V0hApPCk3xZE2n3xo+8xjV5pOfCUulPfXqYTz5PvVmekccLhvyaeJinZQjDGGF8sVQiFzj4C4b8nEMfFo3ykCWxviF7IFDzv0t37ir/LwwTxnngs/LgYMvFTgIufF6jExCtjKhEWO+HeQH09URCTekCxJffzFryrxXUfWa8VcEIMJbjStSTINbU+OO1UEd4BjCfEfHVXmKW5bkYZejLg4bsOEBJ/EmV1wSD58/EjlzGna2pBFLjR80U2v//rkNkPIC43bBQIh/5vJymD+woBU9GAy5vzLgQETRhOBhjssIP021R1swRSlOdZulAmC32dpGoMqi6xjlc5QUEpymOP81yIFzVZfaoecAhgyk48yJU97PzvFYq5ZdneqaEQPNCqwAOQyTZIpKGASGoDJ+Krk0cX2ytz0uAfUl35DteLUKZRPDq3R9YJJy32SNfTAt755MpuhRePoThT13oJv7OXG1U0t/mjLUmCkvWdGrUxca31Mpeb9EJSfRX5UPFz2kfQa0RKv+/1AdYHOGyexvpU6UHLxhHNllG7RCbSYV2bp2DJiu0Hf8e7S6QZN4jobhbPCi+Oc906qZU89MWTSDW4SHKySJxf7yz3WG9rbIw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR18MB5220.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cWMrSkFQU3FMUHIvcXZaMURDT1g1WWZ6YTBGd2p1a1NsRWFIb0JMVHpmcWxE?=
 =?utf-8?B?MmR5bCsvd0F0QjZiU0ppL0pWcyt4ZWdyMEhaOGJNb2FvZTEvbEVzVW9Vdzl5?=
 =?utf-8?B?dEcwTDlaVWNuQlc2OGZvSWNqZE5rN1dQenJTTnR6TG9EYTM2TDJQbGg5Ynly?=
 =?utf-8?B?N0tUMXRFdUpaYys4VmtLanlhT3E2YjVPdHNEaUJ1c002SjlEOU9WTmIrMkEw?=
 =?utf-8?B?dGpidXhMdzlXVnhRdHJPTDcxRGZ0UVF6d1BEbmp6dW0xYzR5d2Y3b3RDaHhJ?=
 =?utf-8?B?eld2bEdBeW53TVRnNy9ad3hvTlNvS0d4QXgvZFlWUUpYSmtMV3NLVTFKOWE2?=
 =?utf-8?B?b2tvZzZ3YVhHb3JwYkVDd2NhN1Y1YXBFd000dmRjWjlWZlJCOXVJYXBCeG8w?=
 =?utf-8?B?dFhnMXdaVTlyNWhzdkFKaDVvZCszNEN6V3NUaGRpek9EOVVTRkg0TkFGems3?=
 =?utf-8?B?QW9aOFlxTDFoT0Q5azZ4OVFDa1ovMkdKWEtkZGVveGRENjdMakc4QUN3TXRa?=
 =?utf-8?B?ZDB1QnltY3o5eFdCeGR0bDB1cWVaZEUrc2s1cHdqNktUTGFwN0xYOUtma1Qr?=
 =?utf-8?B?ZzlXengzTW1LUWZVb2JwVTBqOGZZT0VZK1FGeGM4MjlKckxhWGkwbWRZTGdY?=
 =?utf-8?B?RGY1RTRJSktkWjNMZzBRQXJOYXZOYk04VXJBZGZFNk9WNDVnQUpIMDNuQjhk?=
 =?utf-8?B?Wk9ybjJmQU85bURrcFNIbUg1a2UydmJ5T0doWktvMGtIL3BkbVlBclNuQzkx?=
 =?utf-8?B?SVYvKzMyNnQrem52Q2I0MWVRci90a0krcEJhMEN3RENoVHhFbTRLWWJwQTQz?=
 =?utf-8?B?WEVmYm5nRXFyV01IamJka0kvQWZDS1dzL1FuWGdUdWlaTXgxOWhzT0pQWDk5?=
 =?utf-8?B?WVk2dWd6anh3RVZTSDBUcG1TbzA1bHM3eXMyVTg0UmhsMi9VanIzbEtrZGF3?=
 =?utf-8?B?dDdhSDV5eEF6UWJ1cEdrWGUwSi83OGpQUjNTNEMxdUZ1WSsycWZqa3lXVmp1?=
 =?utf-8?B?eXJzNVNteXFYdmZNUVRDNWp1aXdXZEhQcndRWmJFcjdTTXY1bmpkcnlrUU04?=
 =?utf-8?B?Nm5zSWU1eWRVSXBxZHQwcWoxRVVOVVFrOFlWcVJJbkx2WlVqdmNYS0tOZUZz?=
 =?utf-8?B?bUp6b0tjS1J5ZEx4dnhFTHFJN3dnakx1NjN2RDl3Uk9OSzBSbWN2b0pkNkNk?=
 =?utf-8?B?SUpaQUUzOU1oRmVuVEJ4MUk5YjdsMTBQcmtueXZNOGxvRjlCb1Yrak5xL1I2?=
 =?utf-8?B?NVhGdVRpL29aWHM3a1VGVVBNNlU5OSt4Wnl0a3pQVFlUa3NnVzduOGdwcUlZ?=
 =?utf-8?B?WjJyQW5pcEtMbys3RFFnbVplT3VlSzN6NjF4bzhPZ09uUzUzSWRKTWQrQWhZ?=
 =?utf-8?B?bGpBWW9IdHgwR0RSaTBiSVNKY0k1NlpwQlUrL3FUK0NSV3dxb3JjeWFmaWdu?=
 =?utf-8?B?cmhLVFpOUnJoR3NnUElhL1hlVTdWYjJEbzVRc2twRE84cnMvM3pXY3VkSm11?=
 =?utf-8?B?Qkp6MVlhRUZvaDUzdTd2TnJNT0p2Uld1ODBlMVZKaTVPOEVvd05taEpid1pU?=
 =?utf-8?B?cXFuOCt0dkdCSnR4Vmp5ZjFkL2lqdnZOMlM3cEx2MVp3WjRwM2lQcER1aGp5?=
 =?utf-8?B?ancwR1pUQUFEeFBHMnQ0UTFZZEt6TXhRR0lSSHVRa0lVNmFSRHIrWUZtZlM1?=
 =?utf-8?B?VnZSWW1SaTZnakNxVldXRktTZEliUnZjRDdmaWh2dWJNQlBYN1FTVlFIZWtW?=
 =?utf-8?B?RTFaZTVyMFZPMVpTeE5Yejh2MlNGTllkU2lRRE9iSEpTdUVHTXozLzhoN3NX?=
 =?utf-8?B?Z0JHMjMxdkRVV0s5d3VIcUEwNGhRRjRRRHBucEdOTk1jNTlZM2NvUm0yaGNU?=
 =?utf-8?B?VEh3RWx5N2QwWmhqU3hIeHNYN1g4Y0pwbHJxZkpIblM1L1BpbW1lYjRLSFZj?=
 =?utf-8?B?REdjRHgzekxqK0Y5OG1XeFE5MkNyNTZ3SlRCTlRzMnBtOW1nb0c4aU5aNVNm?=
 =?utf-8?B?TEhGTTFoZ09UT3ZtNWhpUEczL09hNHFSRjRvSmdEbDhScWxYY3RDYjBwazhx?=
 =?utf-8?B?RUhFNHBOUUJlbkhBN0JVeWplT0lqU3pQS1Q4cVVib0lYL1BFWWFHT2ZrSVY4?=
 =?utf-8?Q?QwD3QjHgSWuXaGHMZQSo9lS6e?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR18MB5220.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ef27c2-d431-4f95-387b-08dc38d9da6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 03:52:30.3054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2jtXJ57Ust/RB9v3T17VYAxK59/VWE0dJJfthhr5SIQbQtB/bqusFf0glY/rkPUbGqUBIzzmz0sI0P1KQ9yEeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4177
X-Proofpoint-GUID: btv9P80eDa45erJn2fQU5leQ826RHdIy
X-Proofpoint-ORIG-GUID: btv9P80eDa45erJn2fQU5leQ826RHdIy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02

SGkgRGFtaWVuLA0KVGhhbmtzIGZvciBjb21tZW50cywgSSB3aWxsIHN1Ym1pdCB2Mi4NCg0KVGhh
bmtzLA0KflNhdXJhdg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERh
bWllbiBMZSBNb2FsIDxkbGVtb2FsQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgRmVicnVh
cnkgMjMsIDIwMjQgMTI6MDkgUE0NCj4gVG86IFNhdXJhdiBLYXNoeWFwIDxza2FzaHlhcEBtYXJ2
ZWxsLmNvbT47IGxpbnV4LWlkZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IHNvb2Nob25AZ29vZ2xl
LmNvbTsgTWFub2ogUGhhZHRhcmUgPG1waGFkdGFyZUBtYXJ2ZWxsLmNvbT4NCj4gU3ViamVjdDog
W0VYVF0gUmU6IFtQQVRDSF0gbGliYXRhLXNhdGE6IENoZWNrIFNEQl9GSVMgZm9yIGNvbXBsZXRp
b24gb2YgRE1BDQo+IHRyYW5zZmVyIGJlZm9yZSBjb21wbGV0aW5nIHRoZSBjb21tYW5kcy4NCj4g
DQo+IEV4dGVybmFsIEVtYWlsDQo+IA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IE9uIDIvMjMvMjQgMTU6
MDcsIFNhdXJhdiBLYXNoeWFwIHdyb3RlOg0KPiA+IFNlcXVlbmNlIGxlYWRpbmcgdG8gYW4gaXNz
dWUgYXMgcGVyIFBDSWUgdHJhY2UNCj4gPiAtIFB4U2FjdCBpcyByZWFkIHdpdGggc2xvdHMgNyBh
bmQgMjQgYmVpbmcgY2xlYXJlZC4NCj4gPiAtIEhvc3Qgc3RhcnRzIHByb2Nlc3NpbmcgdGhlc2Ug
Y29tbWFuZHMgd2hpbGUgZGF0YSBpcyBub3QgaW4gc3lzdGVtDQo+ID4gICBtZW1vcnkgeWV0Lg0K
PiANCj4gV2hhdCA/IElmIHRoZSBETUEgdHJhbnNmZXJzIGFyZSBub3QgY29tcGxldGVkIHlldCB3
aHkgaXMgdGhlIGFkYXB0ZXIgY2xlYXJpbmcNCj4gc2FjdCA/IFRoYXQgc291bmRzIGxpa2UgYSB2
ZXJ5IG5hc3R5IEhXIGJ1Zy4NCj4gDQo+ID4gLSBMYXN0IHBrdCBvZiA1MTJCIHdhcyBzZW50IHRv
IGhvc3QuDQo+ID4gLSBTREIuRklTIGlzIGNvcGllZCwgdGVsbGluZyBob3N0IGNvbW1hbmQgc2xv
dCAyNCBpcyBkb25lLg0KPiANCj4gQW5kIHRoZW4gd2hhdCA/IGNvdWxkIHlvdSBwbGVhc2UgZGVz
Y2liZSBhbGwgb2YgdGhpcyBpbiBtb3JlIGRldGFpbCA/IFdoYXQNCj4gd29ya2xvYWRzIHdhcyB0
aGlzID8gV2hhdCBpcyB0aGUgZGV2aWNlIHVzZWQgPyBldGMuIFRoaXMgY29tbWl0IG1lc3NzYWdl
IGlzIHdheQ0KPiB0b28gc2hvcnQgdG8gZGVzY3JpYmUgd2hhdCBzZWVtcyB0byBiZSBhIHZlcnkg
c2VyaW91cyBidWcgd2l0aCBhbiBhZGFwdGVyIHRoYXQNCj4geW91IGFyZSBub3QgZXZlbiBtZW50
aW9uaW5nIGhlcmUuIFBsZWFzZSBleHBhbmQgdGhpcyBkZXNjcmlwdGlvbi4NCj4gDQo+ID4NCj4g
PiBDYzogU29vY2hvbiBSYWRlZSA8c29vY2hvbkBnb29nbGUuY29tPg0KPiA+IFRlc3RlZC1ieTog
TWFub2ogUGhhZHRhcmUgPG1waGFkdGFyZUBtYXJ2ZWxsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBTYXVyYXYgS2FzaHlhcCA8c2thc2h5YXBAbWFydmVsbC5jb20+DQo+ID4gLS0tDQo+ID4gIGRy
aXZlcnMvYXRhL2xpYmF0YS1zYXRhLmMgfCAyOCArKysrKysrKysrKysrKysrKysrKysrKysrKyst
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hdGEvbGliYXRhLXNhdGEuYyBiL2RyaXZlcnMv
YXRhL2xpYmF0YS1zYXRhLmMNCj4gPiBpbmRleCBiNjY1NmMyODcxNzUuLmIyMzEwZjNhMmEwMiAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2F0YS9saWJhdGEtc2F0YS5jDQo+ID4gKysrIGIvZHJp
dmVycy9hdGEvbGliYXRhLXNhdGEuYw0KPiA+IEBAIC0xNCw5ICsxNCwxMSBAQA0KPiA+ICAjaW5j
bHVkZSA8c2NzaS9zY3NpX2VoLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9saWJhdGEuaD4NCj4g
PiAgI2luY2x1ZGUgPGFzbS91bmFsaWduZWQuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3BjaS5o
Pg0KPiA+DQo+ID4gICNpbmNsdWRlICJsaWJhdGEuaCINCj4gPiAgI2luY2x1ZGUgImxpYmF0YS10
cmFuc3BvcnQuaCINCj4gPiArI2luY2x1ZGUgImFoY2kuaCINCj4gPg0KPiA+ICAvKiBkZWJvdW5j
ZSB0aW1pbmcgcGFyYW1ldGVycyBpbiBtc2VjcyB7IGludGVydmFsLCBkdXJhdGlvbiwgdGltZW91
dCB9ICovDQo+ID4gIGNvbnN0IHVuc2lnbmVkIGludCBzYXRhX2RlYl90aW1pbmdfbm9ybWFsW10J
CT0geyAgIDUsICAxMDAsIDIwMDAgfTsNCj4gPiBAQCAtNjQ5LDYgKzY1MSw3IEBAIEVYUE9SVF9T
WU1CT0xfR1BMKHNhdGFfbGlua19oYXJkcmVzZXQpOw0KPiA+ICBpbnQgYXRhX3FjX2NvbXBsZXRl
X211bHRpcGxlKHN0cnVjdCBhdGFfcG9ydCAqYXAsIHU2NCBxY19hY3RpdmUpDQo+ID4gIHsNCj4g
PiAgCXU2NCBkb25lX21hc2ssIGFwX3FjX2FjdGl2ZSA9IGFwLT5xY19hY3RpdmU7DQo+ID4gKwlz
dHJ1Y3QgcGNpX2RldiAqcGRldiA9IHRvX3BjaV9kZXYoYXAtPmhvc3QtPmRldik7DQo+ID4gIAlp
bnQgbnJfZG9uZSA9IDA7DQo+ID4NCj4gPiAgCS8qDQo+ID4gQEAgLTY3Nyw3ICs2ODAsMzAgQEAg
aW50IGF0YV9xY19jb21wbGV0ZV9tdWx0aXBsZShzdHJ1Y3QgYXRhX3BvcnQgKmFwLA0KPiB1NjQg
cWNfYWN0aXZlKQ0KPiA+ICAJCXVuc2lnbmVkIGludCB0YWcgPSBfX2ZmczY0KGRvbmVfbWFzayk7
DQo+ID4NCj4gPiAgCQlxYyA9IGF0YV9xY19mcm9tX3RhZyhhcCwgdGFnKTsNCj4gPiAtCQlpZiAo
cWMpIHsNCj4gPiArCQlpZiAocGRldi0+dmVuZG9yID09IFBDSV9WRU5ET1JfSURfTUFSVkVMTF9F
WFQgJiYNCj4gPiArCQkgICAgKHBkZXYtPmRldmljZSA9PSAweDkyMTUgfHwgcGRldi0+ZGV2aWNl
ID09IDB4OTIzNSkpIHsNCj4gPiArCQkJc3RydWN0IGFoY2lfcG9ydF9wcml2ICpwcCA9IGFwLT5w
cml2YXRlX2RhdGE7DQo+ID4gKwkJCXU4ICpyeF9maXMgPSBwcC0+cnhfZmlzOw0KPiA+ICsNCj4g
PiArCQkJaWYgKHBwLT5mYnNfZW5hYmxlZCkNCj4gPiArCQkJCXJ4X2ZpcyArPSBhcC0+bGluay5w
bXAgKiBBSENJX1JYX0ZJU19TWjsNCj4gPiArDQo+ID4gKwkJCWlmICghcWMpDQo+ID4gKwkJCQlj
b250aW51ZTsNCj4gPiArDQo+ID4gKwkJCWlmIChhdGFfaXNfbmNxKHFjLT50Zi5wcm90b2NvbCkp
IHsNCj4gPiArCQkJCXUzMiAqZmlzID0gKHUzMiAqKShyeF9maXMgKyBSWF9GSVNfU0RCKTsNCj4g
PiArCQkJCXUzMiBmaXNfYWN0aXZlID0gZmlzWzFdOw0KPiA+ICsNCj4gPiArCQkJCWlmICgoZmlz
X2FjdGl2ZSAmICgxIDw8IHRhZykpKSB7DQo+ID4gKwkJCQkJYXRhX3FjX2NvbXBsZXRlKHFjKTsN
Cj4gPiArCQkJCQlucl9kb25lKys7DQo+ID4gKwkJCQl9DQo+ID4gKwkJCX0gZWxzZSB7DQo+ID4g
KwkJCQlhdGFfcWNfY29tcGxldGUocWMpOw0KPiA+ICsJCQkJbnJfZG9uZSsrOw0KPiA+ICsJCQl9
DQo+ID4gKwkJfSBlbHNlIGlmIChxYykgew0KPiA+ICAJCQlhdGFfcWNfY29tcGxldGUocWMpOw0K
PiA+ICAJCQlucl9kb25lKys7DQo+ID4gIAkJfQ0KPiANCj4gLS0NCj4gRGFtaWVuIExlIE1vYWwN
Cj4gV2VzdGVybiBEaWdpdGFsIFJlc2VhcmNoDQoNCg==
