Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBD0745C6
	for <linux-ide@vger.kernel.org>; Wed, 31 Jan 2024 11:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706699207; cv=fail; b=eGORa0fdXhR/MHJBW51ZaQ3MKYO5ngtl8uKZ8WUzBDXTn8ReZfFMO1lImg+IYGqU2q9KKR9eeRRdFmJBLnkmXrS0ub0SbyIchoDh7z8t7jCvndYNe2C8O+CWJelXriBhnQzQlA4j0Hmi3FGgEQK20zB0v3beyvFXu1l12R8lG6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706699207; c=relaxed/simple;
	bh=lxXNBMTj8fqN6W6RrxsISd8qQVh6R5Q7WkAm8zUNlj8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZS72jj1MIJbA3jOeQgYPh9zty4+4Bz35V+kjqpBQ420Le56oK5EjwncQFR/kKCWW/mO8GSDlHiO6BvBvDlPUIjkbrrBQk2AH724k5WDnMaumkzcLloRoatRsA727BrqDOxZQcB2Z3KLHicfvqLkWrgt4IfWyClOMra2kMUxTfKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=S4Gl8FTz; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=G75EzDe+; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S4Gl8FTz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="G75EzDe+"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706699205; x=1738235205;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lxXNBMTj8fqN6W6RrxsISd8qQVh6R5Q7WkAm8zUNlj8=;
  b=S4Gl8FTzD7+eTVsLIes+EPEf3IkpaCXHpJ5HfMU+XPBN7yWv7Di5vt9g
   aA/mWA2TCoUvWmorh++aHODrZ9QS5Xk4hsYvMlFuxbG4jUF9w86L+lsw5
   6KonyEVJVzXgWpZaD5OQeJGk83JeaSx2iAtxAVzXapBvF+pUD24R+ey3o
   KYzpAYGKOIXhANtL8ZFrpvV2PkRnny0E/HyC7OMTmrQe/la+TD1vFlk+v
   QOvj5subl+1bpkhtPqAWSK+Kg/qUxmvjPEbGoQUp1A3Ddb6qM7K/2SoAy
   5F0LaMJB8Klmg+pi1+Tkk+BebrdhLzpn4gBA3mNynuglzvs+gZM3PCc3I
   Q==;
X-CSE-ConnectionGUID: q2Uglew6RMGm/zLIBPHhQg==
X-CSE-MsgGUID: lNYUkynoR4Wau7EGXSwLAQ==
X-IronPort-AV: E=Sophos;i="6.05,231,1701100800"; 
   d="scan'208";a="8693063"
Received: from mail-sn1nam02lp2040.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.40])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2024 19:06:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQASJoWvaxV4A+Qf2dgGS3v/fn27vIefE8l6VrxiytiUA0I12Fsqn8sSWvgDpJHTKC+Xbd3GVRMjB+Vqgt8fmxQ2Vuyx+f79AE4OymcwjhsPlnZI00VOK2ko4j1b9plupeNrs5TpYNhjjI8jf7DsV78q4FZZSRz6SBaQSMKPS30n0jPvrRuQRTEjU9c9EVuhsRLVAbw1JAtQQl4ZVeShEEy1R6NThmAAYs7iAZsMnPiS0fq5wPA1zCCBieJ0wyHHIcNMhc3XpvCZfNooFMdyJZjiicNC5RIe1ChW2dxpo3pNK6Zwp3/biuELdxT9ZgyGH7I2NY1uCZsvUAGBqW54MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGgJ5hPdvnHBziIBWQl2Luftov4iqm4sV7XTVA2LD6o=;
 b=KlxjZKR2u+uo+hVBas2yd28ADQdP76vvQWQr+hzLNBE9tBA/8m1g812Au+IbEEMYfgDsvsyphqV+N3AQyTVIsE6L8s8wfQ7z6Pj9y3W//asf4+4N7WkEsXtyZaRrrvRKCq4g3LEWw4DojTsX3w/deQQPA5rCd1wsB5SL+eGDx9HpDf8kernQfTUE5mRybUcJgKDpS3Mgj0BcaRnEt/qf0qJnYY1TTqXBVBWOxXzi3K1OqkM39RZQKdrPfYWrqXBY3PGGXRXLC1jIfsnynv9KTSIbMp7uNCuQfr42h3N0U2XIJbpY3rcc44AEsuh6W3sZI6MEGFC+VcYN+xJo4nlNFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGgJ5hPdvnHBziIBWQl2Luftov4iqm4sV7XTVA2LD6o=;
 b=G75EzDe+E/ijmEr2x24n55xy8Twwwlqg7i1FvMNhm5OOf9O4E6IpOl0nqgPegWqFEkQCcgzsmRgf9l6sP2jG+/Yss2vFFGExpTJ2S9OdUR3ytp9tv5GnBxF02wmUovMINqq8nN/MEJpyw1p622C6F6fNE0XskV0+3Q4HULNsbBc=
Received: from MWHPR04MB1040.namprd04.prod.outlook.com (2603:10b6:301:3d::18)
 by DM6PR04MB6683.namprd04.prod.outlook.com (2603:10b6:5:248::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 11:06:42 +0000
Received: from MWHPR04MB1040.namprd04.prod.outlook.com
 ([fe80::5c41:d0da:15a9:41ef]) by MWHPR04MB1040.namprd04.prod.outlook.com
 ([fe80::5c41:d0da:15a9:41ef%6]) with mapi id 15.20.7228.028; Wed, 31 Jan 2024
 11:06:42 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Szuying Chen <chensiying21@gmail.com>
CC: "kernel@wantstofly.org" <kernel@wantstofly.org>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>, "linux-ide@vger.kernel.org"
	<linux-ide@vger.kernel.org>, "Jesse1_Chang@asmedia.com.tw"
	<Jesse1_Chang@asmedia.com.tw>, "Richard_Hsu@asmedia.com.tw"
	<Richard_Hsu@asmedia.com.tw>, "Chloe_Chen@asmedia.com.tw"
	<Chloe_Chen@asmedia.com.tw>
Subject: Re: ASMedia ASM1062 (AHCI) hang after "ahci 0000:28:00.0:Using 64-bit
 DMA addresses"
Thread-Topic: ASMedia ASM1062 (AHCI) hang after "ahci 0000:28:00.0:Using
 64-bit DMA addresses"
Thread-Index: AQHaU0GU7heHhjFJBkKCDaM6s218FbDzxJ4A
Date: Wed, 31 Jan 2024 11:06:42 +0000
Message-ID: <ZbopwKZJAKQRA4Xv@x1-carbon>
References: <20240130055757.2573-1-Chloe_Chen@asmedia.com.tw>
In-Reply-To: <20240130055757.2573-1-Chloe_Chen@asmedia.com.tw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR04MB1040:EE_|DM6PR04MB6683:EE_
x-ms-office365-filtering-correlation-id: 99c8ea22-efe9-4fb5-e7a9-08dc224cb49f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 SDZC1WgsfZ2mFG76iKIVWRNvEsP0p+58De1tluN8vDl0XrvUpw0XGsf9ljh7WUYlH/H7QG0gPw/+XQsfyFYive8zI1CR3IlSLEcqgnJSquiB8lNwj+YK2gGS+Gn0m6sMyMuVlM1u7H5bBT9jwjxZPu/n/USg2OpMQ4mMG4GYU0Lrq0MYIG018izEoCX3CQXU5BER2B52steGBusjQywhS9fGYQAANT2cIo4H8ITOC5MtAjlA2+RL/r9oAGy8DgOEs9yxvCOWD9msO9z1KLiIkaAHmnwrhwcRbCXjVEYGp5f0DCBWMANeDhdy+IU4fw0DWEdNZDMQrIYHKISZRcfN5oMzV9uJo4sc9DaZjvIo/QsnhUVsTi4rpg5CP95Eq3CNuEJL61P0dUIeoMGfEzBodsbMgiF7u4+ELBCB8ABdDNfb8timDZDot0AHjKdFoW/uVdglYQA39uc/ncGzrZAOYPzNjVWj14xOIcK0gvlhNZe5hheY5xeedlqVgZZJxGVgvRrFuJfU+e+cSxTT77NP7EUSE8oYE5siBpwzxXBTRlNKNdwlK/LyUwZof2LiriXRAyBayOzO1fuVGVtC2bnrTe9WVbRr9DyesTBXq1TJRf0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR04MB1040.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(39860400002)(136003)(376002)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(122000001)(86362001)(33716001)(41300700001)(82960400001)(38100700002)(478600001)(8936002)(8676002)(4326008)(76116006)(91956017)(6916009)(66946007)(966005)(66556008)(54906003)(64756008)(316002)(66446008)(66476007)(26005)(6486002)(2906002)(53546011)(9686003)(6506007)(6512007)(71200400001)(5660300002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5yrL+MZ3Xa6CUlA294D8sWg4GgnhlFU9ZSr4yXTBf5vOdY3+ycM89uoQ8Yus?=
 =?us-ascii?Q?Ca5oy418lQzW591tqCBG+223gv/AIMG8+B8EAUKh2PIgl6QqnoYxJ8Ukj0/0?=
 =?us-ascii?Q?UJ0sot+rynnNvwAQUtJZB4BzXMMmdR/0DI7QWb+DRz8+UwSZg3O0fXohMcWi?=
 =?us-ascii?Q?BYcg7PUz91Hke6UEjHHw3JW/ClNR0ujzbuPXJe0ZsiO9Zdk6/gudPY6zUIAg?=
 =?us-ascii?Q?Lf5Akhionx1+RNrUc1Yzvw9fr5XoGipV+UFfldNrZUIu+jdSLgUpBDsa0vlz?=
 =?us-ascii?Q?RtXBSgPXeb8nuiuZpNOmLlZeH9vanCvJGhjVlBhuq7eqmQdvqsUc7M8pxTds?=
 =?us-ascii?Q?ajRhjhkHu0AuR9z6NU9xZp9jtX351tkBXicf4R2tux3AlWnXrqVuctXoA5v2?=
 =?us-ascii?Q?tt9WSRQ22XRvXMZv4WNVtZKXFMSLMNUvw5/os63KgrJ5V3IlgcbSxaVzQYUx?=
 =?us-ascii?Q?eqC8aenYvxAluXSnJXl0OVflWj8v0cRc3mTNB9Rer6JI8gKXNFZ5uD3mVUsS?=
 =?us-ascii?Q?/M148pgmXsyVuAHwc+ce5k4RkYxid9+MKxHyhTz6Hk8+wmvjn9MYNBZhX59t?=
 =?us-ascii?Q?G5toLfhg19e0EM8NgyyMooDcwDMNikbxRccgMVj75UnETmufnxN9uFwK5cdl?=
 =?us-ascii?Q?xQ77h1XSYvOSaDyectKiwZsePZ9Bpw+WyZWJsWCFG1TNWrbd86ohwjl+CKA5?=
 =?us-ascii?Q?pU9c9SQGU2r+f6ElX0uJOi22kRU3d+QlBK8oF2QU28bP24wE4S3DaeyR1m9Q?=
 =?us-ascii?Q?GVacUdiUnrT1tRbFstAWw+GgebGARiHHUk41qPistJJ682JBTQQV0IcwiO1R?=
 =?us-ascii?Q?MUR752FpXa/OUl0g4yzMlefXMy8pv+x/lGXHAms8lZGyHjdbTmjP9L0x2f5R?=
 =?us-ascii?Q?0LWon77vgkkG1pU1PXBGBoStk/Etx6/ooJir2rdz5EDnGBZdezPLuv1I00Zj?=
 =?us-ascii?Q?51UD2TkU6zaQIdy8wnVdV2rW/Q7TghMvpj8lKQVYgcn3QOJqLHbh788XafMx?=
 =?us-ascii?Q?Hffq/CLgRLkdfk/qrKLqyUc5ppxIjrug2afbBm3x3iOJJVcSsxN6Uewcujct?=
 =?us-ascii?Q?YWy0WlJTfd0QuW7jCC1iUu2j4w9y83YaialMRKnC+2VKxQzGA1J8hq9y+1u0?=
 =?us-ascii?Q?T9dp08yOXUQ8MaadcLzFkFvQm2nD3f79dBnfAqOY8k0f5llSKi2dQVgrVvja?=
 =?us-ascii?Q?SLfdqp2PFsGNgChu5i/Psc9+Vn5g/5MRPVus7inTVli5pm3DFSNf26jk7wgN?=
 =?us-ascii?Q?b+EQF3+PTnlWqslCclB1xqXTCHZy+HYITcxKO8IG+KrHvmECcXtenONAswkS?=
 =?us-ascii?Q?5kbLwtGecbeyduY5ZLoovzkw/kaL5su2jk87t5Jx5YEG6LUQqHIgwVOfCMGW?=
 =?us-ascii?Q?UO0f1sVBvweQgVtacyjPiNM/5QTf/Qo2Zy3zxg1yhuim4K7hNQzqOQW0x4If?=
 =?us-ascii?Q?t0bzL/7s/lxCJ2NngF9qzk3zm6fey8UcZqSnih2BdJR1s/H4w6tWzF1FL9uq?=
 =?us-ascii?Q?OZm/NxyHMoYFfzV4NjEr38CvsxKKV6ympUxl5GoM6G4q8TpmtDaPrqTZj2HM?=
 =?us-ascii?Q?hnH0/cr1puEAmmqHt5Y35JzRkCSsF0tndcL/bKGAa3JSLSSNzgsDJFXEmFES?=
 =?us-ascii?Q?Ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <070505A5E153E64DA628D8CE779A944D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YPnZpVehLymjkqUnZrsfBlPXDZHJg5zCEsKbLfLNP7tegmFWcNCxXrMzQL1xLYSixBOvgEXcGbd9mROXX4df3wDLTIZXafHGaeaRrQCxSH2Q0HhbRPR0pe+MV4BVvEk8ulTsNkvS+3WdTlriZa2NYSSA8cC3/K4P4Dm8EvNiqOcEo3hROQJQ1XPhh+DVZhuflSQvz8b8PV9o4+5AC8uvIxrcVMkgGr2MLplpW4EP+ZnOk5dJ49QKARZIevW7lx9WgPPubZS7I3uXNBJst0NrcPUgqG5mSJcr7kYRZyprG/jE3HQCV0QRoNlwle1otsOvqSfX2eXRQrAg9ROIx6xP+lXOhUBT9EFEUTFKH7XsY2X0HMcZCaS5F2VuRC0tyA+CxWJzkWF2bcEECv7wmkFVpIhchoEjORBi54tN/K6GHa+lwMHqICmnamLspO3duwLpap+17udyFuodK2TUG50KoQOENwvhnKO3QpOT7bU6+oe4VqPT58YrYdllFMhhVUsvSFdtqtpSPSX+hFw5WjqyZmW0SazLbA94CsgXbLCrWkSXfxFhH0SMIAhxGmJtzgfXfQyXtloAf9NcIA1zkighCifu1CbrTpsz8525QjoKQheLFcCj3PstuS5Xv7Ns9l/6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR04MB1040.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c8ea22-efe9-4fb5-e7a9-08dc224cb49f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 11:06:42.2932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xeFuCMLRSw+Kn66ubYK2bdPv1Ow+h61ESXgvfdbKi+r6B7WZTCHTgAXScYkwuzRBh+qVIr6Faam7q2ra5ou2ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6683

On Tue, Jan 30, 2024 at 01:57:57PM +0800, Szuying Chen wrote:
> Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> ---
> =09
> On 1/29/24 17:53, Niklas Cassel wrote:
> > Hello Szuying,
> >=20
> > Please have a look at:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/ata?id=3D20730e9b277873deeb6637339edcba64468f3da3
> >=20
> > This commit is already in Linus's tree and will thus be included in the
> > upcoming v6.8 release.
> >=20
> >=20
> > However, this quirk is currently only applied for:
> > PCI device id: 0x0611 and 0x0612
> > see:
> >=20
> > $ git grep ASMEDIA origin/master drivers/ata
> > origin/master:drivers/ata/ahci.c:       { PCI_VDEVICE(ASMEDIA, 0x0601),=
 board_ahci },   /* ASM1060 */
> > origin/master:drivers/ata/ahci.c:       { PCI_VDEVICE(ASMEDIA, 0x0602),=
 board_ahci },   /* ASM1060 */
> > origin/master:drivers/ata/ahci.c:       { PCI_VDEVICE(ASMEDIA, 0x0611),=
 board_ahci_43bit_dma }, /* ASM1061 */
> > origin/master:drivers/ata/ahci.c:       { PCI_VDEVICE(ASMEDIA, 0x0612),=
 board_ahci_43bit_dma }, /* ASM1061/1062 */
> > origin/master:drivers/ata/ahci.c:       { PCI_VDEVICE(ASMEDIA, 0x0621),=
 board_ahci },   /* ASM1061R */
> > origin/master:drivers/ata/ahci.c:       { PCI_VDEVICE(ASMEDIA, 0x0622),=
 board_ahci },   /* ASM1062R */
> > origin/master:drivers/ata/ahci.c:       { PCI_VDEVICE(ASMEDIA, 0x0624),=
 board_ahci },   /* ASM1062+JMB575 */
> > origin/master:drivers/ata/ahci.c:       { PCI_VDEVICE(ASMEDIA, 0x1062),=
 board_ahci },   /* ASM1062A */
> > origin/master:drivers/ata/ahci.c:       { PCI_VDEVICE(ASMEDIA, 0x1064),=
 board_ahci },   /* ASM1064 */
> > origin/master:drivers/ata/ahci.c:       { PCI_VDEVICE(ASMEDIA, 0x1164),=
 board_ahci },   /* ASM1164 */
> > origin/master:drivers/ata/ahci.c:       { PCI_VDEVICE(ASMEDIA, 0x1165),=
 board_ahci },   /* ASM1165 */
> > origin/master:drivers/ata/ahci.c:       { PCI_VDEVICE(ASMEDIA, 0x1166),=
 board_ahci },   /* ASM1166 */
> >=20
> >=20
> > Could you please supply a complete list of buggy ASMedia SATA controlle=
rs?
> > (I.e. all ASMedia SATA controllers that only support 43-bit DMA address=
es,
> > yet claiming to have support for 64-bit addressing.)
> >=20
> Hello Niklas,
>        =20
> ASMedia SATA controllers that only support 43-bit DMA addresses are liste=
d=20
> below:
> PCI device id:=20
>         0x0601  /* ASM1060 */
>         0x0602  /* ASM1060 */
>         0x0611  /* ASM1061 */
>         0x0612  /* ASM1061/1062 */
>         0x0621  /* ASM1061R */
>         0x0622  /* ASM1062R */
>         0x0624  /* ASM1062+JMB575 */
>        =20
> Thanks,
> Szuying

Hello Szuying,

Thank you for getting back so quickly!


Kind regards,
Niklas=
