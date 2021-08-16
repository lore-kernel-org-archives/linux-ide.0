Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F810C4338F
	for <linux-ide@archiver.kernel.org>; Mon, 16 Aug 2021 00:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A88561075
	for <linux-ide@archiver.kernel.org>; Mon, 16 Aug 2021 00:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhHPALA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 15 Aug 2021 20:11:00 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:58638 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhHPALA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 15 Aug 2021 20:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629072628; x=1660608628;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=aSDCKosk56uufU74cZf+B7UsB9bHxTGaRwjg36I7AP4=;
  b=f4Y65b7NGon2f7U7Lql4FbYcgFDQQQkp4WbbEuisfgo2R2BMdjQ2qzbH
   Y0qNNQi5sCVoZQTK7nxr2QvkgKBRehygWs1EOn/CCZgVXCIQhnbYFhpj2
   lpeDqUBJwtvvtbl1dxQu3RL4Yk2bZLJXODglvQN0KAPoCH1/I8YBmTeWW
   nIH7cQ9EN4s1zK5bKWR6JnwQtwpUersiGQ4tmq9z50Aahd3FVfLkEFFeP
   wQoyTTi4v05gXxSsVSrQBDikEMMgVuSUCxxHTq737k/B3CTRCs9Qyg+Gb
   C005w2XNuqVrGw7CuJv53IaPi+/IFqb3z50ak2p347Vzi9jOkmavwpP7c
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,324,1620662400"; 
   d="scan'208";a="177319837"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2021 08:10:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtGcsG9pypLLu19gsRT8oyVS+1qwrf5SnKeC+2Dju+h+/FizHzbLfd9BTgawuBMq/BhZLd29VV4SNB9IePQVPWLJnnOhYtORH+1WHPSaoX+eNFYmBFlzer7dZkyRy3tKTqHMMnd1xKJBRUBVhuUZWeHLCcAtvbrkI77qQsqqIX8CZmQp2ll7YEINeQ1O4d6DkwLTFlffFJR03pXiRkwB6cYbvf4pJt4vve50boF2Ty8y+eH1RhXIhbo5ifdoQeMWOAki97hbTK2LHl9GtsPE3xmFzzyFYOmJpvgsdbl5xXKlii5yHodRoEePSzbb1gKBgMtUlsh16DzPSjz8kaH/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBXE0lyjEHmB72dKdHRZx9EQ7BkHpAtKPMPtSGp5i28=;
 b=OzTctm0fbCEdmqRolVrD9z4S6xoZek4Pfn8IoewM6T8YeKioTS1/c6CQwx5zVtRr0F3Bin/Y8ojHoCwhAJyBVKaeIuqkqsFVXAYlDuEJCdnk/sqH4r97e9tXksc2bRxQFTusGgMQObXOSaeFqFwhL/PBmEW/NjaB6Wr4YLw6UicLfwRTNk7F7Q37+5bxP31u4G+zPktnTrgOQthIs/eUhuCLhp+y5RBr28c9Bw1BbemMv2tP/sYJPL+IV7jfKTLvc52hDwuELGtHEhexTey47OTuxE+2e3X6k14dAogxNcDLt46ESPrnQh9DuoZEdYYcs00Vo9J5nQ70Zu99MeKBXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBXE0lyjEHmB72dKdHRZx9EQ7BkHpAtKPMPtSGp5i28=;
 b=cJ3E6/Ee59aG2WRpHAJFFlIR+Gbg/vZ7KFeOgbeSTRJV2uTYJc9kKEbc1PvyVsOOLGpqXR5UO9d763JTyinFtzmt4gvOBgdHGau9+ZLo43nc1YNkqqEQf1BNwU6dedOE/BpSDPJDskqtdvgKsS+2KIzCYv4NBlwJ3UHcqWqBoOk=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM5PR04MB0443.namprd04.prod.outlook.com (2603:10b6:3:a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Mon, 16 Aug
 2021 00:10:28 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c%9]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 00:10:28 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Reimar_D=F6ffinger?= <Reimar.Doeffinger@gmx.de>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH] libata: Disable ATA_CMD_READ_LOG_DMA_EXT in problematic
 cases.
Thread-Topic: [PATCH] libata: Disable ATA_CMD_READ_LOG_DMA_EXT in problematic
 cases.
Thread-Index: AQHXkfJ9xwnsD4iI90C0rV5WFPhKfg==
Date:   Mon, 16 Aug 2021 00:10:28 +0000
Message-ID: <DM6PR04MB708117F3FD8537CB6875E2C4E7FD9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <YRjN4oULwmNKI/yi@infradead.org>
 <20210815162725.15124-1-Reimar.Doeffinger@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: adfe247a-fda6-4c0a-542c-08d9604a40f0
x-ms-traffictypediagnostic: DM5PR04MB0443:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <DM5PR04MB04434D18A3EC4F476BEAFF33E7FD9@DM5PR04MB0443.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Iw2g2fADNLT5o9xeq8saohr9Hsyjn/0JpJeMIWgyTSedUfgCOn7psjihKUygwM3pp4/DirUm++/SZW+28ZzVmsCSkbnQD62z5BYF/5QE8mknv/pyGnW2TH4sPStnUAEgYyTUeoyQpZ5QCDqAiqgQoBO+CNR/uMKM79ZKmeYJ1jgFvwmGmXa+ViXu6N07rgsUb9ThPoFLvS3CNcflhconcbUpD7Ch7YYyIy3A1DefqczWz5m/MHrzQeHKFdDA4FyHQQacHXiWcnmznl0ZTf+2fEXlUBjTJ4ICteRYvPgJPJnThJSKuiTevM3W0osL/HJABUE2xjtfv0wT/nfGwKhr9iBA4HVy0bnjKMjRUYsaERpp7TH0G5+4FD3JNi8XamAIGkRWZzZvYGDWOvk3Rrg7RFDtN5om02t0sWA6KqfTO0eAQv5B0VwgSJyeRkK2Dwok/dCdhohAkL7W/rKbQ33nAbH4+kcT2UzlGRU0gud7MguZf7A6vGLaHHgSf9J5lXcuaN7xuQwnEwvlMZj3YTWXFlVT3nbYYiRMltMNwnoG6I2ZNRkd2hQmLvw4QwR2xnlK6wkg42F4TdtrMicVQPvic8cpDrk456TUfxP22MaJcwQytloGBW2fnQYuB2JQZbRZcivn40ik+fUI9qWdEWpR7n0HqtPgAl2UuWOR/9U/ad6azxLQ5oMAw7EhsMZ4O/WDIhWFIWNq4f66hID8N5SlD8NzR6yvS4drAfAtXXgZYVP5In9QNVvL/vM3I5oqduT9GJT5zBT4IcLt44GdK0mP28w4bHQDMfgEmNNb7Uzr1FE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(38070700005)(64756008)(83380400001)(52536014)(91956017)(38100700002)(8936002)(66574015)(76116006)(66556008)(66476007)(9686003)(2906002)(66446008)(66946007)(110136005)(186003)(6506007)(53546011)(7696005)(122000001)(55016002)(316002)(5660300002)(8676002)(71200400001)(478600001)(86362001)(33656002)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eeoj7H4Fgv4dw8gh3cSYyWCqJlQp46qsfkgJANF6qRe4ucT2jZCA1cg/DA?=
 =?iso-8859-1?Q?QmzN6jXNMJeNnHRojlMnZCDckdfdCfK8S6+VanJqi18LBCKggATFUcTHtM?=
 =?iso-8859-1?Q?60nLCTiewyy0YmzhQYbn2OTLugZ5n4aFZt/9mGT8SPsLHwa7jXjaF8msyv?=
 =?iso-8859-1?Q?46iyBN0rFo7lE2JLDJLy4pzUn6MNSbTP5b/CQjNemFmxMiuqPyVBsA3bw3?=
 =?iso-8859-1?Q?Xjc69L7svJZhPuIKF6KokdIbQ7Mhn/7o5KLY6QRuHT/9WqltkxBhrp/r7u?=
 =?iso-8859-1?Q?CVo1uIa9KhSLi/pf3rE0IusXMZoLeS1FpYke8P2H4fjDpohond8N3nzkhL?=
 =?iso-8859-1?Q?FwgMdHzJlb/pbpXNyzaH68wkSuxXUgESSp++t5nUC2RZWnNLvaZWCInYZ/?=
 =?iso-8859-1?Q?SRMsXKJzKO7Feh4PNmYxYzHns4484P4Ph/B7PaSBNHHnyKIPq/5enZz++N?=
 =?iso-8859-1?Q?sqo76tAM6ScG7veC9Q92ZyoF9UHrZWgdlbMu4y9VnOHgTWTTax7+RhCl9s?=
 =?iso-8859-1?Q?DvkseS/wFk2Yk5GdIil7XMUjUxDRHsjhWWxZ51S8F2xOYJ7Fu1TRaqv56h?=
 =?iso-8859-1?Q?64vtEWB9WjxgqDeleJX/L6r6kHjOhkM2zRQE50zLHZS9Cv1272s9tCa7+w?=
 =?iso-8859-1?Q?RCKEo+hmo6rwREB8tVuYZSzwY4W33uKVvURCy3JycV8f9vF4GhIT3tPr0g?=
 =?iso-8859-1?Q?YWZy6QJAzJODrKEMER4Z59U7kOseLCLsx09RVuzESDOzdqqwXZzvRUU2QH?=
 =?iso-8859-1?Q?Q068n4eM4WsZ2qzbQ0iASoMI+g0drpvFUemigjlfr+0h7I+V6vkW6+PyDQ?=
 =?iso-8859-1?Q?iHIliX5fkIwCwIGgokbCVOygLo2Ls/mBBR8uEVvRU2+A45RR57lptarsD1?=
 =?iso-8859-1?Q?YW6G0H8HRLDvStm5eXRVyZEEPCwftnm2otUCHsH7I8WNP2voR0F55MkSKS?=
 =?iso-8859-1?Q?B1cwHMguY6ZjMDGYuCzKmvogAXuTUNHy99uyzYyH6A5fS0I+MLurJXYqCY?=
 =?iso-8859-1?Q?oKc85qKg7IyCvlDNj7wrTc1Fp0RfKnZ5FV7Yymj0kxlDbrRalhPl7FLit2?=
 =?iso-8859-1?Q?g/2Ipuuojuc0RPY5g4bYflER3F+yzNQ01ZdapAJItw7WxUHkG0bObUU0fY?=
 =?iso-8859-1?Q?u4kvMyH9s1Y+9JErmxZ84XjRQ4gQzY4UsfNmm/bXZ99mNPD9fuH4qjhIvD?=
 =?iso-8859-1?Q?fTZH8pShdjSkcsUBunXstqz55/F6eD7s3b3B75iMDxBjMeFugU079bWfIM?=
 =?iso-8859-1?Q?7n2zlyFZzZ40654ViDOgqhp7p0h63EU0yJX5t35AWFst2qt7VWOivdq3Ha?=
 =?iso-8859-1?Q?3WW+tOtuyRD2ApTS4Qm/LhUFCeqGCndLc3CrLOR0GeweeRrKmp3Dga1n1c?=
 =?iso-8859-1?Q?N5RXfz4FsISujrCIoXOJVLVeJunJpp1Y0KtIHv9Up/CJ49OozPPGU1ZOmk?=
 =?iso-8859-1?Q?wYLO6p3FpZFXiNllDcjzqOW0Tx36FQxF39OndA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adfe247a-fda6-4c0a-542c-08d9604a40f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 00:10:28.1829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jqH7nhh53XYC++Qizx8Rr6mB9WnqjASqsiV5Iu71VkG+eciBV5TKKhO3JXUHfYubKaQZtL3IQunT7nCIjAvcEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0443
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/08/16 1:27, Reimar D=F6ffinger wrote:=0A=
> The ATA_CMD_READ_LOG_DMA_EXT can cause controller/device to=0A=
> become unresponsive until the next power cycle.=0A=
> This seems to particularly affect IDE to SATA adapters,=0A=
> possibly in combination with certain SATA SSDs, though=0A=
> there might be more/different cases.=0A=
> Comment 5 of https://bugzilla.kernel.org/show_bug.cgi?id=3D195895=0A=
> is an example.=0A=
> Disable it by default on Crucial MX500 devices and all=0A=
> PATA controllers.=0A=
> Also add an option to set the workaround state, which might=0A=
> help with gathering more data on the exact devices/controllers=0A=
> affected, and speed up narrowing down the cause for users that=0A=
> are affect but not covered by the added quirks.=0A=
> Existing workarounds like forcing PIO mode do not work=0A=
> (in addition to the performance issues) because READ_LOG_DMA=0A=
> is issued even if PIO mode is forced.=0A=
> =0A=
> Signed-off-by: Reimar D=F6ffinger <Reimar.Doeffinger@gmx.de>=0A=
> ---=0A=
>  Documentation/admin-guide/kernel-parameters.txt |  2 ++=0A=
>  drivers/ata/libata-core.c                       | 15 +++++++++++++++=0A=
>  2 files changed, 17 insertions(+)=0A=
> =0A=
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt=0A=
> index bdb22006f713..191502e8fa74 100644=0A=
> --- a/Documentation/admin-guide/kernel-parameters.txt=0A=
> +++ b/Documentation/admin-guide/kernel-parameters.txt=0A=
> @@ -2551,6 +2551,8 @@=0A=
>  =0A=
>  			* [no]ncqtrim: Turn off queued DSM TRIM.=0A=
>  =0A=
> +			* [no]dmalog: Turn off use of ATA_CMD_READ_LOG_DMA_EXT (0x47) command=
=0A=
> +=0A=
>  			* nohrst, nosrst, norst: suppress hard, soft=0A=
>  			  and both resets.=0A=
>  =0A=
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c=0A=
> index 61c762961ca8..219fa92ffc06 100644=0A=
> --- a/drivers/ata/libata-core.c=0A=
> +++ b/drivers/ata/libata-core.c=0A=
> @@ -2004,7 +2004,11 @@ unsigned int ata_read_log_page(struct ata_device *=
dev, u8 log,=0A=
>  =0A=
>  retry:=0A=
>  	ata_tf_init(dev, &tf);=0A=
> +	/* Do not even attempt DMA with PATA-SATA adapters, they seem likely to=
=0A=
> +	 * hang, see https://bugzilla.kernel.org/show_bug.cgi?id=3D195895=0A=
> +	 */=0A=
=0A=
This is not the standard kernel comment style. Multi-lines comment should s=
tart=0A=
with a "/*" line:=0A=
=0A=
+	/*=0A=
+	 * Do not even attempt DMA with PATA-SATA adapters, they seem likely to=
=0A=
+	 * hang, see https://bugzilla.kernel.org/show_bug.cgi?id=3D195895=0A=
+	 */=0A=
=0A=
Also, I would remove the bugzilla reference since it is in the commit messa=
ge.=0A=
=0A=
>  	if (dev->dma_mode && ata_id_has_read_log_dma_ext(dev->id) &&=0A=
> +	    (ap_flags & ATA_FLAG_SATA) &&=0A=
=0A=
Why is this necessary since you have the ATA_HORKAGE_NO_DMA_LOG flag ?=0A=
If this is really necessary, ATA_HORKAGE_NO_DMA_LOG should be set for all=
=0A=
devices that have ATA_FLAG_SATA when the device is initialized. With that, =
this=0A=
additional condition can go away.=0A=
=0A=
>  	    !(dev->horkage & ATA_HORKAGE_NO_DMA_LOG)) {=0A=
>  		tf.command =3D ATA_CMD_READ_LOG_DMA_EXT;=0A=
>  		tf.protocol =3D ATA_PROT_DMA;=0A=
> @@ -4000,6 +4004,15 @@ static const struct ata_blacklist_entry ata_device=
_blacklist [] =3D {=0A=
>  	{ "WDC WD3000JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },=0A=
>  	{ "WDC WD3200JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },=0A=
>  =0A=
> +	/* Devices with observed READ LOG DMA issues - unclear if only=0A=
> +	 * specific firmware versions or only in combination with specific=0A=
> +	 * controllers.=0A=
> +	 * Specifically broken combinations reported=0A=
> +	 * CT1000MX500SSD4, M3CR020 with B350M-Mortar=0A=
> +	 * CT500MX500SSD4, M3CR023 with PATA-SATA adapter=0A=
> +	 * https://bugzilla.kernel.org/show_bug.cgi?id=3D195895=0A=
> +	 */=0A=
=0A=
Same comment about the comment format.=0A=
I would also remove the bugzilla reference as it is in the commit message.=
=0A=
=0A=
> +	{ "Crucial_CT*MX500*",		NULL,	ATA_HORKAGE_NO_DMA_LOG },=0A=
>  	/* End Marker */=0A=
>  	{ }=0A=
>  };=0A=
> @@ -6104,6 +6117,8 @@ static int __init ata_parse_force_one(char **cur,=
=0A=
>  		{ "ncq",	.horkage_off	=3D ATA_HORKAGE_NONCQ },=0A=
>  		{ "noncqtrim",	.horkage_on	=3D ATA_HORKAGE_NO_NCQ_TRIM },=0A=
>  		{ "ncqtrim",	.horkage_off	=3D ATA_HORKAGE_NO_NCQ_TRIM },=0A=
> +		{ "nodmalog",	.horkage_on	=3D ATA_HORKAGE_NO_DMA_LOG },=0A=
> +		{ "dmalog",	.horkage_off	=3D ATA_HORKAGE_NO_DMA_LOG },=0A=
>  		{ "dump_id",	.horkage_on	=3D ATA_HORKAGE_DUMP_ID },=0A=
>  		{ "pio0",	.xfer_mask	=3D 1 << (ATA_SHIFT_PIO + 0) },=0A=
>  		{ "pio1",	.xfer_mask	=3D 1 << (ATA_SHIFT_PIO + 1) },=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
