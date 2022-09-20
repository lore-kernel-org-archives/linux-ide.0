Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F06C6FA82
	for <linux-ide@archiver.kernel.org>; Tue, 20 Sep 2022 21:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiITVJL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 20 Sep 2022 17:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiITVJK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 20 Sep 2022 17:09:10 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F56C17077
        for <linux-ide@vger.kernel.org>; Tue, 20 Sep 2022 14:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663708148; x=1695244148;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f9wL3xprubhcYO5Hj/KyhpD4PlV1RUegBWohV+Qtov0=;
  b=WBVakUBjyUpgkIR48pP81p07avzWCEWEC4/IjHpvWsCySOPhyJJZGWgl
   GxRB9q9H8WZjy5rsfN82WuWEmpfRgFlg6zoLvy2UK633SeBaOAptnRUOl
   vh/IkL9aJwZBIML1Ulee37F4hCY6suNEI+0rLhCln9hHESr8g4vrzNtGw
   qCcLrHiXr4cg35dGfxBBeqcitBdiM91bJvvQ5aDMoPJGI9/bD7TtBnbfB
   uFd+VuwpL5KLMDTPVDpv6aOFt2uya7mI8r3RzCQbTzE7NVGPgqF9iq8V1
   IGq6PUapdbbzp0UHfk1lEPrQc3kfQEyl1JLiN/i4A9F0pai6N1QX+KP2N
   w==;
X-IronPort-AV: E=Sophos;i="5.93,331,1654531200"; 
   d="scan'208";a="211845488"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2022 05:09:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLMpfF47vangdX3NfR//WcS1bWKYOqvUIU+oiLCTC6+0ufKnfMb+RmzlM2K30UE1M7lgFkFkeU2XNyfUbYLa1LYU4kzTeKGW5fi1vmBBjHr8/LVImAsbVDBlwBZwwFXtjfdD7zB1UB1dFR7UCzFrfia2MUyLUHKYqRrqGlDsQgoxqiaS300NKcnw1qIfYW5D7c1enOVVa59dU/oUzyffU0Q8klwR++io3OjAvXu3cWBRan1VmOQz2ggF0H/wVmQpEDv3ocQDb8HjKCGA/nJgtxt32LeR/B0sZMOX5VF8f1y+6Xoko7oI5xqzrfDyOvx6CVFYWmrLmN5kC60c+/wgXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fD2Y8a2a+lSc5ChKmTGC45xGkmomdaKETwm5qv2CiB8=;
 b=WDi+BPIH8UjvmIWF4wxCw0Ot8Hl6euUkdJ7dyQ5D8fBfZY85tPFznKIuJc6oXyiEiOvKbpcX7V2eMB++j2cRSBePU7JmV4B1TBRffKo56fgbfuSC/OU5skUaMG4rPX3aq98tMe7ODmD1iAfgUxv1VlTMxBMlE45ovZFc8HeRUrUhtUoUWK4gQxRd+QbQECtnnhaxND4TKuD6W3bE/8dQuSd+JIgrUTdy1tIog7TXORtZdgNicsca1TFG1nvl/2mVbR5MD3cw1ggJGkljWxT2qCxWbNi3nIwetu6L4qNaet7mdzaoIUqn9Z6wHVg2RlslDHtUiTezS2kiZLiPy71GYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fD2Y8a2a+lSc5ChKmTGC45xGkmomdaKETwm5qv2CiB8=;
 b=myirQ2P8+tHyCnrrwi5FLRoPkFeBM2QtzSmWS7GV/U/DYhQo+uoDCl+i4UPIDWLrmH0c0CBsC96NcGIg4SLKyoOWC9IzdOUD+kJ3CyBJmRHGAF8pDCTBxNg0Nm21bT9qoV7718UBtITWgsH9b8P98fpk3oxkm0S31rRSWtg9x3o=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BL0PR04MB4753.namprd04.prod.outlook.com (2603:10b6:208:42::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 21:08:57 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::c8bd:645f:364:f7aa]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::c8bd:645f:364:f7aa%5]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 21:08:56 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     "J.J. Berkhout" <j.j.berkhout@staalenberk.nl>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: Multiple errors with DVD drive
Thread-Topic: Multiple errors with DVD drive
Thread-Index: AQHYzPHXLJ4Av5O6AkGhkxFRY031g63ogKSAgABP2oA=
Date:   Tue, 20 Sep 2022 21:08:56 +0000
Message-ID: <Yyor5zsqHAoNimF3@x1-carbon>
References: <c7e0c932-2e20-18b5-fe9f-36572807f59b@staalenberk.nl>
 <40946617-7f37-b5a6-f94c-d47d1b4b21f3@opensource.wdc.com>
 <f7efabe8-79ab-8c6b-81d5-2cd0a396f148@staalenberk.nl>
 <a4326505-f52b-7a7b-d626-a77fb546642e@staalenberk.nl>
 <0baf58ab-4e7e-e8bf-d1e8-0897542d1bc6@staalenberk.nl>
 <Yym65wlizZydJ/Tn@x1-carbon>
 <9756ac37-6790-7b83-5840-abe04f8ab838@staalenberk.nl>
In-Reply-To: <9756ac37-6790-7b83-5840-abe04f8ab838@staalenberk.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BL0PR04MB4753:EE_
x-ms-office365-filtering-correlation-id: cbb82eb0-db6b-4424-d5a2-08da9b4c54cf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tNEwJ5hTeJbwseO94RYuMuCs4ilOB0t781s4H3NBCy1lLyrXfEWroBIYDY/QL8DSRz/kAx68ANkBxEIg61xSyiHulwvN2veYtwdBjvLcSv5nCSAfmGqjpGn9LJILM2ozMtOJL59FwHiQqw07pRe866Kt+5CkC6RWkQNxviFhtyK2tirOxMs4mn6UTgzlzn11xlqsUxZEss75dUc/GcKu6kN+UIBGjnBzMQAObh93Y41aaLjULPbpgovUK7eBES6lioGOI2U5FszXPWklfIH/UViubIet6mDKkn31H+pDroKJ50KoNgFaBjCJA6jJI8CSexznZCiqMXEtfZsHJgYAXpQeoD6Q+RYZjzOXgMbIdf2PVbWCrSy8tswtVwYDG7n4oFH6EnER8qyByghy5U1MkiqTBTc0TP0KMyF/YTz+dpaR+NC/fEMwvSDSpEyYRl87uyosR5a3aFibniD88StZlFPFE0WhsmTaG8p3aipamVdP/gUrHf/zpXaY74z3akYjVHstM64DR8/AP63lrEzNf/Gm/+zUGx/tml+WZmnQoZa4fcUYmTg+Wzo3w0JoAL80Ftfrg+5Auc3aoWqPOlyutx2EjkMuMD3A4YdrjeOQhORmFJ/wdjePJ9d8D42hgTTJ338seVR2H2YAHzSANSauan2h8b51nT0vfMVMSeed18vLRKiBWADfT9h2RbD2tTw5sgHhVb67uNirckZIbgBcg9Gcwe+fH1uxnY68giLjjQsPmyXSgt9rg/1L63dXz/XBSKYCELYxzIxqo/0C69Im0unxsNyExSSKdjw+4zD6JYk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199015)(41300700001)(478600001)(6486002)(966005)(71200400001)(26005)(6512007)(6506007)(2906002)(33716001)(186003)(9686003)(8936002)(66946007)(316002)(5660300002)(91956017)(66476007)(66556008)(76116006)(64756008)(4326008)(8676002)(6916009)(66446008)(38100700002)(83380400001)(82960400001)(122000001)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fOTqW64y2nlBm83sw6xEkziUttxSI4QCVLIqMU6Z7x7bA/BccpHnHyISTfKa?=
 =?us-ascii?Q?cG4AvfkX0aV7Qvv6SYjiDCbZXusx3xAuYcFNcK3+CYtCMThWZEG7OCpi+qrw?=
 =?us-ascii?Q?MEjMcLVchjHeHxeoPEOK2bjaWV0Qha51jG9hCtIpiyNOIRrCiAEA4TrwrWf3?=
 =?us-ascii?Q?QA8jV7/0pAIu8KKzOWaVkg9q6pp/QKf3eczREVosUoO0sxJMzkccY1fc2/Jw?=
 =?us-ascii?Q?8Vc+3fJfmIyNlnotj/1Zu6BV+/tJha13WzoovxFkTVHQK3NqPsMKlsLpjHIx?=
 =?us-ascii?Q?7LZmjy/9YKs0MhAjHTlnRkRd7bQxd2Z4bCCZKEtbu9GJg0XLTseoH77/9o2t?=
 =?us-ascii?Q?vYLbobCe0RBiOdC3mkXfNwLbkBLscxBCo6LROC4kqQNFdMGYCk8gFnGJhDCr?=
 =?us-ascii?Q?iOrHriovG0RbxfuTQSslWFOTw4XKZxwN/jctXViF4QYNkT7prK/R0fyEOlFG?=
 =?us-ascii?Q?SqWGZ6T+rwhAVKjycWxr7xkzFvC8fNvNpTeWFSXsDm9S/KcVN4OnfIfK/Miv?=
 =?us-ascii?Q?MhEoyF/h4XW84W9dWpCWp59BuUUADRFOQiGUf2CmGeFP4EjrH5pH9XY2ZOk0?=
 =?us-ascii?Q?c0klViT2VphOJV+izZS2FX1vFTus+5vxDDCn5WDAZ1CUYl71Fh5LuKP5ATXO?=
 =?us-ascii?Q?rwBmrdYZ7ujxdPjaqTHJfVqxOGQ6gXPACevyb0AuA2YlV/rBCdAkrxVjYaMF?=
 =?us-ascii?Q?MHf8xxymkSoeyMrz9EfKT8YMuoKhv4GKtrZpSqwed4WoLKfSVm8EwyPiTp+3?=
 =?us-ascii?Q?Av+EVzIf/LLARS78zBigsAQktkXUDuZRJ4OOpJPQNWEPoAq7Xub2G89dzSvp?=
 =?us-ascii?Q?D2sJWHQgVZH1y/0MdOlDOjHGzA9UhJe2/xwlLG+kVIsfZhBx4mDJA5XMiiky?=
 =?us-ascii?Q?dMhyL5Oe9IVmFrVpjLHudIiGJ4SXrnVoG1TWCu+i5uveI+LO6PIx2yp5wXJ4?=
 =?us-ascii?Q?Wo1Byc0ANb/KeOpRk6Gmra+Y39xxbTlizEOenauXhD71SFz3GMMfEDim/Wrt?=
 =?us-ascii?Q?TbMB4x3uOKJEqqquPDE1QPNY795KQyPW6pAnDdhQLl+0DlpOlHv2BV7SeL89?=
 =?us-ascii?Q?uIc6tmYyg2IbTiUeEjMfviVGO22eXR1nWsLKh5j+ZBFRv795pNEVijrQGnEj?=
 =?us-ascii?Q?qMczrBL+KF/OXXS1TRMaBEmqRahoDx9cjS68fO9NtH97ydOwOng8gQrO6njz?=
 =?us-ascii?Q?Qy2pRKlylxQYx/+CckKg4kus+74E9UrEUajHIl5qWv+d8SiwofGkSmzQMdTp?=
 =?us-ascii?Q?ECuwqbu45zxvPgNKHoivmr57UBsg4PYAiI3izsd8T9BHaY2rsuxYUmT9OsDU?=
 =?us-ascii?Q?0/4ul+/FD5lHWJZg2xJw1+OW0H2am84LS7UrdL+U9at+bwQk6UQskbAryU17?=
 =?us-ascii?Q?QPUKfBUlXZFZ1CbM3NMzd50lyDCj0iCTeCZy+kM5ACs6hXJazHCnX3BZft1q?=
 =?us-ascii?Q?F3gJBauzWZ+0c4LNSeLdOqcQ0/E4zUngjd7K1MokJwf8rXPHFUDcxJMy1C5C?=
 =?us-ascii?Q?+Wmcs3/hTL2KhRCyK+TZYzvbQl67PIwnfw/PoF0ZmpW7b+HNedZ3ptZLnkHe?=
 =?us-ascii?Q?5UU0MkeF80pu7ISdh4J1YgMjHzE/plsQUEIzvyUIuCF+j22pYoI1SpFpM8aD?=
 =?us-ascii?Q?kA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2186DF470F051D458A64A8EA570AF368@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb82eb0-db6b-4424-d5a2-08da9b4c54cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 21:08:56.8448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BB3RhJ1r6teaf4rLxNfhW9pmLNGSJh4A8oIe6vwe3hrcxAXgNFpahnwvnovcFtdz+dIQBTLbxghHrbQlhBVbHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4753
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Readding linux-ide to CC.

On Tue, Sep 20, 2022 at 06:23:07PM +0200, J.J. Berkhout wrote:
> Hello,
>
> Thanks for looking into this.
> I do not see anything like "ASMT109x-".
> Output of lsscsi:
>
> [0:0:0:0]    cd/dvd  PIONEER  BD-RW   BDR-207M 1.60  /dev/sr0 [11:0]

Ok, then we can rule out the patch that adds the ASMT109x quirk.

>
> The output with the last non-working kernel is the same.
>
> Concerning the patch: I do not (yet) known how to apply it.  Help would
> very much be appreciated.

Basically:
git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t
cd linux

Try to copy the running kernel's config:
zcat /proc/config.gz > .config

If that didn't work, try copying the config file from /boot:
cp /boot/config-$(uname -r) .config

Since the patch is only one line, you can apply it manually now.
(Note that there are three spaces between "BD-RW   BDR-207M".)

make olddefconfig
make -j$(nproc)

sudo make modules_install
sudo make install



Looking at the logs in the bug report, you do have a AMD Green Sardine
AHCI controller.

The commit 1527f69204fe ("ata: ahci: Add Green Sardine vendor ID as
board_ahci_mobile") added the PCI vendor and device id to the list of
supported AHCI controllers using the low power board version:
	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_low_power }, /* AMD Green Sardine *=
/

Before the commit in question, your AHCI controller relied on this
catch-all entry:
	/* Generic, PCI class code for AHCI */
	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci },
which does not enable/allow any low power mode at all.

Now, I do think that low power modes *should* work with this AHCI
controller. Most likely, it is simply the optical drive that does
not work well when the HBA initiates a low power mode on the link.

You should be able to test this theory by adding libata.force=3Dnolpm
on the kernel command line on a recent (non-working) kernel, low power
modes should then be disabled, and the drive should work again.
(You can press 'e' in grub to temporarily add something to the kernel
command line, and then ctrl+x to boot.)

But the proper fix is probably to add a quirk for you device, either:
+       { "PIONEER BD-RW   BDR-207M",   NULL,   ATA_HORKAGE_NOSETXFER },
or
+       { "PIONEER BD-RW   BDR-207M",   NULL,   ATA_HORKAGE_NOLPM },


Kind regards,
Niklas=
