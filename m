Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87176CDB47E
	for <linux-ide@archiver.kernel.org>; Fri, 13 Oct 2023 20:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjJMUM7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 13 Oct 2023 16:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjJMUM6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 13 Oct 2023 16:12:58 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC40B7
        for <linux-ide@vger.kernel.org>; Fri, 13 Oct 2023 13:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697227977; x=1728763977;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=S4wc/rIdB73rvJYSosy0R8TTSDcV0pfMg/T7/NU3KpA=;
  b=S/J0HNq+Y058niyY17jwWpVg+jA60uC8TSwvka1WREajwXUA5OqnbWK2
   z2zNvnr8AbggDHy2Oxnr9QFVY5+zoUAPebC2B0oCRmSc2/5uJ8ER8lLOC
   mSqZ4HM6iUUa+nY0cVCN6HwTlPcX8GBCB0K07Wv+9pWNiLPy/B3uiFy/w
   F0WvY1ARlYSD5BeSauMzAmHsE2E7rTPxNwIXzRo5+W6LNk+vjYzSszzZF
   KQoQlAgLhO4LhcNVYyssbdi3BX6fKcp4fGxPAed2MIalysiKYB6MiS2da
   38YC/lTPZerkH238RP4qCWdnbjGDI9EngOOTjcTpu9uFrMu9QNFOGT+3S
   Q==;
X-CSE-ConnectionGUID: m0KPbFnbRWe5F9rttyb6uA==
X-CSE-MsgGUID: n4ivej/SRoSTEltVnvXqnA==
X-IronPort-AV: E=Sophos;i="6.03,223,1694707200"; 
   d="scan'208";a="244603541"
Received: from mail-dm6nam04lp2041.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.41])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2023 04:12:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jk4btFRRmDoUF7ZZsxQC5x5uwM+LpLA5np2pWBykdq0uazLBaTbpHT+0qkuCYM9A9bo8wVXDVw70Io8qIBOFXyjHTSwDDnzSqyxK/QCbFNL/uvaHWXJ0455Qd6Y4Lly/OjvEUsPpF+tggUyIj0Sy4PQvv2LoHvmRbNlGFsTx20V9uTAvdZMjKNjcNAyyNA6/YqbaHWMIxPQXe3ueaofKvwhK3rjSZL7VKNCk3LQBvnxv4d+ik8khXD/liJSqOvxuelq0bngV2nSeOySZlgQcXlAailugyARTY8/TcdsH0bKoDeyLO+cScANZATxplcmFwIfhJeytzGTxS8AcV6wbEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WScEufdgjlFozW+QbPJx+za5AAegKDIhXxDzMfR3v8=;
 b=UjROnni2K5pvPhyjWwa/RWG0PV/W652Lwnr9jU3rTTJyiEOxMHd9QCqWg3AM+4lHjVXnBK1+LEWP4tstKwsySlWHI9M+Lt3tGz5V6mXk2qYZKNiWHeO69BVV6CYEeKkesXxCNnfb5+3TOvuysjGyKqGgX5zoJhk4zetSpNVSfGPeHcO231rahGtBefA+D6rFKxGvmtimqrc5e3F/FrCeOeXUffXbNo88m7b7qfdljneoB78moLQLQAfEb3EV8snesvDB5fkYV/2pC+sWKbwDC3RbdprswoPcvMX+VJMuzEoT/9GfgT8vksRhQUwWN5ePoq4WNMfWCKJmZNS/+BE+5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WScEufdgjlFozW+QbPJx+za5AAegKDIhXxDzMfR3v8=;
 b=GrybLml/Eo6a5ustP52K+1Tp2IEg0tgWk8BSnJ90MZmq1AFu+SZDWJnAkX9Ah6kKIcf0/qa2WnJYFnShi2xocYHXjfCzUBZlxMZoUMhsXJqHo/dK9kO8aH7DFLVlkyz0fQYGyDWoB64qwbX8mh2rniqAZ9mrGjNB9y+c/Kkp/zA=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SA0PR04MB7258.namprd04.prod.outlook.com (2603:10b6:806:d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.17; Fri, 13 Oct
 2023 20:12:53 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d%6]) with mapi id 15.20.6886.028; Fri, 13 Oct 2023
 20:12:53 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Phillip Susi <phill@thesusis.net>
CC:     Damien Le Moal <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] ata: libata-core: Improve ata_dev_power_set_active()
Thread-Topic: [PATCH 2/2] ata: libata-core: Improve ata_dev_power_set_active()
Thread-Index: AQHZ/hGkMqyVrEl6cE6PkRoc44TCeQ==
Date:   Fri, 13 Oct 2023 20:12:53 +0000
Message-ID: <ZSmkxGv6aFk/YyoN@x1-carbon>
References: <20231012071800.468868-1-dlemoal@kernel.org>
 <20231012071800.468868-3-dlemoal@kernel.org>
 <87y1g6ftby.fsf@vps.thesusis.net>
In-Reply-To: <87y1g6ftby.fsf@vps.thesusis.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SA0PR04MB7258:EE_
x-ms-office365-filtering-correlation-id: d4f8810d-9be3-47de-b990-08dbcc28c881
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dKN37EwO/9mdIyb1jqCbUNTTiHJG4Jme/kKnkzSMqEZ5uP77PgVTd4/M0mvNB0/5Xx1elbvDKWcL/826Wp81gKIHG49eCaLRkxgvVWhxOiz6bTrDpiOMoyo8FOgg8Pzz43FTygirAHD1cHiWHJIFxnF7HmJxCcDzDvaLNOeeGyrQlvBTEhum/57Dd6ApkM41npbDiJC4VlN4LOp44IZM3JuJvesXtWyQNGX7FcSU7u/ZRRul5Yu35r2YrhO437j5hX5N8rkoPO8LKOxWJvP3z3329Y+QRNam4Ztu86ZMHCyGFORxrIy1ntqRj6L86NWP//fulhOOg0QXLzhC59P8fWm8vXzKX5bKsZQU68MKZ8EabtMQPzU4iTy85Z7n8hkZ/SRMt81yI/7Cu1S3rNJiGgnu6XJcsv6bSYNbCODAulBFhWG5V66yA9EbBmm3vjUm/W1g8wd8kxwZ217aEtJaEjqdWNWYsa2vDeAbRulvPNHIMIEYs2wc/eADD6Oa3fxLDq2kkxIfnfnzJbbPhnfjs7Q18st/9pXt8whMzEeG0UdVjC6Rmdhcb/anoqJpNB2J6NaDFpTft+APV3PICkJ3gcoJh/LQBI/WbS9fbewoM40=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(346002)(396003)(376002)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(9686003)(6512007)(71200400001)(6486002)(26005)(6916009)(83380400001)(8676002)(2906002)(91956017)(54906003)(66946007)(33716001)(66446008)(66476007)(41300700001)(66556008)(316002)(5660300002)(64756008)(76116006)(4326008)(38070700005)(8936002)(966005)(122000001)(86362001)(6506007)(82960400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+/KjTWl/7O9NtKWtHfyPM5TcoI56tS01vWkHqSZVExQZ/cNgz4qNvjthXMhn?=
 =?us-ascii?Q?vJaxS1qDhHB6BHKtM0XTibB62zs6EsTnsVNhPEp5VsLpoYbPFV6z0DrdH0pR?=
 =?us-ascii?Q?Jo9zBAHvsd3SRnEGIwEAaInw04Ys5UEYdegkFBeLdh5q77ifsrkg2XV9ZgBL?=
 =?us-ascii?Q?d0rl4PoPzcYda2lbMmIh/9598MtoSh53WMR8y4Y9aEcaorUFhBLRWXoJTnCW?=
 =?us-ascii?Q?WFbDbbzMgKtkuh1n6bwzc3L5HqpuEHx7LhNl5oeclrGEz3s4qAvRpRPeoChO?=
 =?us-ascii?Q?uVktw8+Mi3r7gT7NnszbbS9rn378lZLFCDcJwnBHaPl/1fSPLtSziltehLT6?=
 =?us-ascii?Q?7Gz7VknT5dA8/NiVhiNWa7kLz2s55nW6ZAIHnF6QMH7DCIXGeMPE89lzg4xQ?=
 =?us-ascii?Q?7DjB2aEqEY87hfDfTFjxiI3xsSNt9+X28ObLcM6AyC0hmuqvuCP6Y/CANX4I?=
 =?us-ascii?Q?mApfETD67VFXfq3iQubHYlb1VjsCWDDxg2FErgMnCpYo3kv2nTLJNSMDpgjL?=
 =?us-ascii?Q?d8tfnQ/aJNvtHLtFUuOysYqhh1ozZGilrg64778xfmFQO3s7pXiJ2EbBHjpG?=
 =?us-ascii?Q?q37PaMbhUbg3j8V0CrDoRMII5OnBbQ3vwB1TEWd1vi856MHignzgWd7Ql1fD?=
 =?us-ascii?Q?Ky9+sOZfM68xSZKhjbYNQPknbe+JR8QkG9vn3C4UTtjBU9RJjzojm/YWeedp?=
 =?us-ascii?Q?NvvQ8Xg9/lKZJYLKV4SUFxizRIO/ni7c+VTMxMm+US0dnxEbBgX4V9B7BdvS?=
 =?us-ascii?Q?i0b8Cmfh/isJfZmQvmFNIrXKI1kyGzBaS/V250YPomxwWXGMkM0NtqKQeX+l?=
 =?us-ascii?Q?D+9OZoyVdyCxe4hI9kMJeTIRsZqvvBHOTgGiRC+OHGyJHbmyOiqmo05DJU+Y?=
 =?us-ascii?Q?ArBYwmcIGmFw1GlYG+H+YKMmxXiQRUlfhi8oQ3gQoa7omVbMHN3euKKmG3Ye?=
 =?us-ascii?Q?j2RogGz2M9Itx0moAz/Q0SvHkph964yA1V4F+KfQ3PyQ7GZq0Tbb5fbjt32z?=
 =?us-ascii?Q?3UHuK/tTsIfdiq5EjDrBGNhPYVcmZDlatUsVHKiK4TMhvqJ6//ndH3F8u6dx?=
 =?us-ascii?Q?1YdH7Tr/w9iUJ9FSm8ss7Adh690KlU8mP1nrFoLhuFlSY8aQDWGiRFvZ2/0j?=
 =?us-ascii?Q?nyKZNZ74/mw2ak/UPJ9Icgb6Z+k2Eh9Q4vwQmm7MpcmjBoGuzzA8YA2XJWZL?=
 =?us-ascii?Q?u9JU/fACtJ7WmCE3rVHDZ4Nh5mkvd80INkYthvINXVFM7pN3weclIqYMwh+/?=
 =?us-ascii?Q?c77LIz5glMY5eDUZH1rqZ7SfVQRHygB95/tl2VjFmK+TLSM0zXk6Y67ET+t7?=
 =?us-ascii?Q?sx/8RpeW65N0LcrbKWSkCvcEqFWKwWKCA1Lza0UDLOES7KITcp04ARtKszSv?=
 =?us-ascii?Q?gzCRqf2BQ/uS3Sg4miF0II9yi9AAyUC9U47iJiwbPHAMAE9NwU0h/+1JNV2m?=
 =?us-ascii?Q?HqpyQOg5v0U1o9CdW/sa1HBWe/jX4knCnnD2HKl0M5J/knMGksY9ZYwf3bYr?=
 =?us-ascii?Q?qGVMlBNX3AbtS+HE4clHC0Iib213GKzEq02i+D7yWKQrsdeFYrQCWEZ4ZQm6?=
 =?us-ascii?Q?WDPLlB6ZahbhMn7YXbcggFF+ATm9TeXjrZ+jgwP276fgzVRhAOauwIm5I8Lh?=
 =?us-ascii?Q?2g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D6B7D0D074CA064CA48CD43AC27E6258@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: haFcugBCSp9cIikBrx7MZOVAg8Z2mKYwFSCOrzD090wIMVhs8SBN06reg1wX+SIAFBeTGKqMhbOjKv3Ja9iqa6JxbdJjXLtQdX/ioL/kbH0kP86WiZwH2/1T7O+GlZEGe8OVwwswnnC/lU4Uaa/NyNIsakGlpC1BlxG3r22KtA87TZboPg1nlnwgCXOfR33/jj/amz4qrtzV35QW8sTsN/gdaUccEAO7euk6MGTFI+z61BbxASIkY0IAzcwkV5slRhhohe9qDLPtbgd+9q+WQcTGTfP5AE3AzQeWpHVK5OWBdAdl4RU1yFfbF9PFfdPMESheexiCE0B2GgO4gMkq0AIPlV0QAwSlck7LcaOFh2t6f3VgpoiLKN2d0+77rxE52CHi3LTP2Y/+vrvVys4u0Sp8xJB/rJgSHgvDVXmDK4WSfo39+BMRZyhizcdvb8Wd0kEARAyIU86SoQcWEkc5Npf2iplu6RPHns90jWDZs/ReISR+id/o7ahq6wPlfFYGQ1huCoGW3Q79wnPV5iDML6qKQHchSfiV1PME1IJZQRG4V9F+pueoqK1XIlr3oeTexT07+rp5hNTJxPsIwW9G1mOImBVqmoFXUDHTgDMDNcyN9b4cQ4pqifRyjTltYoaVRLat07NppMgLzro+Hd7Z5TTkF27cpgbl/KzmX9x3II42KeNVQ6XVTar3kMmXZqRDxzq226ylYzTaeRcTyB9u/ccT/PZx855SQBhsr4y+miiJBEI/T9V3aK9nMEEVh5X3RQWg9Qi9MXppsTtlLaZ3x1N8bApzAIgE++Ng7KSRaY5Bc88Gl6yqN424CEocUYUiyzX/6OFzvsAOUHxthkUNkhVAykGGX9HdJ9NPSChUIa7Bmoot0fBR0BS4clCzlVrY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f8810d-9be3-47de-b990-08dbcc28c881
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 20:12:53.7678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jHQmASjckby+edz7uRXKJdev6PGSguTyTTxKd7GKK/mTObiilzn7/GGFUhszvgVyiNDt+wjutIaPecPgoI/3ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7258
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Oct 13, 2023 at 11:14:09AM -0400, Phillip Susi wrote:
> Damien Le Moal <dlemoal@kernel.org> writes:
> >  /**
> >   *	ata_dev_power_set_active -  Set a device power mode to active
> >   *	@dev: target device
> > @@ -2065,6 +2092,13 @@ void ata_dev_power_set_active(struct ata_device =
*dev)
> >  	if (!ata_dev_power_init_tf(dev, &tf, true))
> >  		return;
> > =20
> > +	/*
> > +	 * Check the device power state & condition and force a spinup with
> > +	 * VERIFY command only if the drive is not already ACTIVE or IDLE.
> > +	 */
> > +	if (ata_dev_power_is_active(dev))
> > +		return;
> > +
> >  	ata_dev_notice(dev, "Entering active power mode\n");
> > =20
> >  	err_mask =3D ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
>=20
> This bit didn't apply cleanly to what I just pulled from Linus.  It
> seems there are soem differences in how the tf is set up.  Why not move
> this check to before the tf is set up?  There isn't much point in
> setting it up if it isn't going to be used.

Hello Phillip,

This series applies cleanly to:
https://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git/log/?h=
=3Dfor-next

The for-next branch also has a bunch of suspend/resume patches that will
not go in to v6.6.


Kind regards,
Niklas=
