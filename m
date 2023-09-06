Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D915EB8FB8
	for <linux-ide@archiver.kernel.org>; Wed,  6 Sep 2023 11:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239353AbjIFLYD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 6 Sep 2023 07:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjIFLYC (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 6 Sep 2023 07:24:02 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6777D10C8
        for <linux-ide@vger.kernel.org>; Wed,  6 Sep 2023 04:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693999419; x=1725535419;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=p2yvSKTRmvzN/bcedhAiB16T+qoAodO6+ns+aHhNCHw=;
  b=N/90A6C06/St1cqBTz6dPqd3CwbsaBD0sRiEV41DMI934UgTiOwA3G1L
   Yi7okHVBhVhvkk3CwBpqURCK/C/F6GRTdCiOG05hPoNNN0L652K6lwDJC
   Cc3+M/T7iI3oetTqLAdjncXrLd2jAjtdeuSDZ/UJIJAdE+SyHTflyx8NH
   kuLQnc0Fg33hoM+mj3vCjMkNxx1RISQO0IxPHARb5acx3zVr74snaZ61H
   hTgBhSjvwZ6yrBxjFUydeMNSlWfM0wTDrfqTq3tyZ1dGsbFTjCDyR1OXD
   tIXvrTt2IFvZ7V8zOeYeegqAKwqZe0sBoLdloxMljDhhqBpxcZNBTeMbA
   w==;
X-IronPort-AV: E=Sophos;i="6.02,231,1688400000"; 
   d="scan'208";a="243085134"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2023 19:23:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbvgD77FWVxAVrkQn/3kc5RSq2iIGIhrgP0/xNnqDpTPx2Eps2fUI73BdAnYsXj8a1m8Ai8uBXPgcZ78XBfbdMbgtYvvbLCeQSgXgc3SHsKtX26oV49W0Ukm7NuGyd/vJPJVjNDVN4nwep1Y8DIDak2SmkFR8D3xdfcv7EkCuRfRfXsArk1n89rSXhj82ctyQQIgOnHQ7KwmDVgkkyhcrnQJvHmLDKDU1tFRf6NBR7IGSOI1WkajU1bx8lYEzHOCv0RSOpwjpPTDj1NvlMG9pkYGZ79qq94kliozz7tnkU+5VQs1hjsvOO98ntDEzBMdZgvNEXurqLcRy5+4ZHfcMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u868cKNirHH8rvqaANiw/e0EpadKws3DDrPFVmf83j4=;
 b=ZsFmO7fErH2p8duYnudFk9rxAJTkAnl09QfkDeMH6RiktkdeVxzA9TtArcB0QIcGtl4paNVvKgThp4cL1Ggspta3GGO0k4uIzKjLotNjGIJ+sGcXpaYlPqHNl8P64JgaD5mw50g0FFBCOVQfPCEsyH7DV8mGHefh31m2wJ4gQU8xAheRU533Uy6aOSBHJZP6NNm5sCPCtZ4QjVZDqY1aZgRULtDhp5pQA87CafQ/vL21oL+sG0/GkwGnSKPo13MLs8oLzHiwJqoGHmtmZckpf7pTIMsONHNP2icluQKpJPDgrTf5QsFbrVB1ByaqHQ1+DKYb31QRE9hWUFvxWt1eGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u868cKNirHH8rvqaANiw/e0EpadKws3DDrPFVmf83j4=;
 b=oH2Nc5RLvKSHvosz2UQJHXusuoA4sT1T9cm/Z/WhnVh9rg6oQV3hDelJCXAf5kJs8k+X5EL8gZdSt91+WEzQPc9RNGUKBFSUEIRWPNjH/womwTMmziJCSNIeQ+VwNWku8s/yVGCrbzXdyhFqjFq1nfZ/MRq1G7Gi6Jhat4b6kKg=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BY5PR04MB7043.namprd04.prod.outlook.com (2603:10b6:a03:223::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.25; Wed, 6 Sep
 2023 11:23:36 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5%2]) with mapi id 15.20.6768.024; Wed, 6 Sep 2023
 11:23:35 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Hannes Reinecke <hare@suse.de>
CC:     Niklas Cassel <nks@flawful.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH] ata: ahci: print the lpm policy on boot
Thread-Topic: [PATCH] ata: ahci: print the lpm policy on boot
Thread-Index: AQHZ3/eIUXWDwAHvZkOqRwmEVhUUSbANiUyAgAAf5oA=
Date:   Wed, 6 Sep 2023 11:23:35 +0000
Message-ID: <ZPhhM1GLp4LM1Q+E@x1-carbon>
References: <20230905124909.3334046-1-nks@flawful.org>
 <5755ea72-ec44-4f2f-b0da-8069cb169fe9@suse.de>
In-Reply-To: <5755ea72-ec44-4f2f-b0da-8069cb169fe9@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BY5PR04MB7043:EE_
x-ms-office365-filtering-correlation-id: 620f532f-32bd-4592-21fd-08dbaecbb60e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TjDD/pYgq56vKBXrHgX7nD9M+YXu196kO5hduRb1gKdpK7gg2CsQGeIqA8m0hnDzdmkr21iTUmIeEBS/fyiO+21BX+kb88iy4q4JMKvWBG9Kf2NN02Go0N4OABmfHe67U6wuXf6J7oRkk2VHg8bY5FFzHn+nLW7u/ZrsmUHo998XXGINMjd9i6eL086XAViNnfGA1w1TDkJPu/OErwN9QbxT+IAd79NiYYJwyNFAkNeUIDW4mZuyGG5zYw+lV6JZwGnRDWL0pHGhXnoSbflJd4rd1FXt4NTSptpGOX1xX7sAFTjx4rSmraiKvS2oxzime+alyvrKRpqquF/1pWH+rFmMpropxUFiKxmG9/1qQIgyGmYE+fBMvOrRxafY7+o92bLwRBsizrtSuVlsuzPvLpCiRa4THK8x9Y8/Phb2N/Xy/AskTf5TfNUvB3NEbg0F2K3PE9CLUfV7fke7NasgTiaeUyCi+CF99JSsN+2ZY3iu9lY0VkkK3vSmgHsc1Mn7qtC9l9rWx5Y94WNyZuwP3HMTZ3puFci4pqvYWBE9Ui5x2joNFQzgNWeDV+cODPdu+kH+gSp6FYLPTbgr9RNR8ndosyLEOHbKIiXcpPRikMJxw0maXubfCqZDfd9//cDz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199024)(1800799009)(186009)(53546011)(6506007)(6486002)(9686003)(41300700001)(6512007)(66476007)(6916009)(66446008)(76116006)(71200400001)(66556008)(64756008)(966005)(91956017)(54906003)(66946007)(316002)(26005)(5660300002)(33716001)(478600001)(8936002)(8676002)(4326008)(86362001)(83380400001)(38100700002)(82960400001)(38070700005)(2906002)(122000001)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F69Vmfei2yNm3PcHzZq946JcKZI3EUc6Up22hv0h4L66F1VljB8uzyYZ4JJq?=
 =?us-ascii?Q?aUiC+Xly8fXhNDIxZfOUSVRkTGuhA557h82n4gLYASjJoPoukIkf3NZ0pxeG?=
 =?us-ascii?Q?6Sjvhti1VAS+0geXXx0Kz1e3aMKFWQwyNGsGgtEZ73UoX7LIceEfkUwjN03S?=
 =?us-ascii?Q?Gd0j5FP2UNH0vw8mBdgTzGB2TZLCiYw9QV9ol5UYvRQOVwI+Z4M9KYpmOtgx?=
 =?us-ascii?Q?ptQpu1utlQKZCautyR7y6U/BFnGL7rpzmkMD7TN3i/OwyStnNlffTE0/V71t?=
 =?us-ascii?Q?FZj0tEkg/qD07qEEQrWkuc7M5pb3BJpyPbpdXoKhlNYtcoFW9qhGuFO+2H92?=
 =?us-ascii?Q?o7tHnWXETQuwBDHFYqPuTCvm4kUKACac37wEQl8ecS5npqZt3BIo0Ld/64FG?=
 =?us-ascii?Q?3R+uraOxh7XP+PkjIR9Wv19MIVzhg6OBkFM5VrH7zmy3UVt+Ff8THToqXCYQ?=
 =?us-ascii?Q?NHuiiyZwD6gZU7JQoGzcH2/uIxskL9ln6GeddZy+6Greja/bhKkcYoCLjgxz?=
 =?us-ascii?Q?poS15lulddDYf+mUa39r5JsnUA4GmWDFieUYDk5g46dNmtsdokir4xXXR5RD?=
 =?us-ascii?Q?fZzkQ2+5RRM7u+pBIfEDTmC034XDfzRYL8vFIh9dTq+WnMVEFw1uHWEwqaDI?=
 =?us-ascii?Q?x8fl3u1D+vnFSdTyVFf2PBVjb4HUDadoqIlyLkfaz+iwBXzhjSfxA5EXY9id?=
 =?us-ascii?Q?ZFsxDUAWWT2bDP1DiHhndccgcOSLVajQmGpTF8uLLkdpyMl7c6XLv3GY58uz?=
 =?us-ascii?Q?giUGiZeC3Wrpe/ZSb8CJmbbm2FP+fSBNDhCGWtDsRJZTbYqrgoFri+A1qfG+?=
 =?us-ascii?Q?VQGbN4Ztcino8NpSJKTPfRGJKkGTngwwt53FPcA/cYiH4zgRZ19hLPbv0+nJ?=
 =?us-ascii?Q?EP64otR/u/p4tw5mAUTXKk55RG6ONfriybII1ESLE5SHoAv7wY7l8IpCOd5V?=
 =?us-ascii?Q?aO2vWE0VWmcNUdQ8k62aS/nAoAyU1Ql4k+VuCiF4YHQvhmsUGyC68Tv8j8jw?=
 =?us-ascii?Q?pKQLBcl78L8E8l9/BC3L16Ywkf4oAzPPupYNqXpBj2Co2wfX4DWTaZIKtZ8g?=
 =?us-ascii?Q?7BokHuq8Db7y5Bcv3+2rC1OkMH1mlCtRCkpNMJdKlmuSpfZtHQAR4hHVyjc/?=
 =?us-ascii?Q?Pz3xJcjAa2FXUzNy1CWrEelWwjFYiV1A5TWc/lHnmtwnUMPvrQCtVRYXJ1E+?=
 =?us-ascii?Q?pHmey1+XJLT4hNj+zNTsUsW+KLN0mcvWwGAP93j9hV4m09zZdYaQjLGWWJ2G?=
 =?us-ascii?Q?oH0AtS92ptUdeJEupx1+pS/fe4saWfBF8YheQMAzYeK+8Ev4IYQp7ZdvKMw3?=
 =?us-ascii?Q?Flfg9betro15NzksgyFwuICGqYDXlfCXJ2FnLI7sqH56OgrwxQTdsi5jD32o?=
 =?us-ascii?Q?B6LLhi+6NmB46Olo/6Tw5K/MGfU28HreRQHTrM2wAqPrl+EtN7P/na5/gl1R?=
 =?us-ascii?Q?tpVeLrwQ24CXaQYHHs3Xg1d1uyNo4/iJqb9vz1oHR9DEnVR8pSbFFFfoooqH?=
 =?us-ascii?Q?+0rebN8mtc30JeK/hn3Y1QLseOT8iCvdGd0lCOHWLth5kkWAME7h0M889N3J?=
 =?us-ascii?Q?kOkh5hTuzFvBRUL87tygNmB1HcJUove8d32xkR3Id5zwpvmPOLHfv1q/j8Fz?=
 =?us-ascii?Q?LQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <069A6D13B3B63A45A18685783C291E00@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bPq3RC43lbVC8cT6fd0BZ76hncg3U6UqJsJgSmCYn5MVqFXnY+6bKShmyx2FLH2EvnafNxsWYFwQBxh2PhnaG7meeYj7QEnHvL1s2plLwgg/rR8DCsx9d9btqCMtSDMQo4Ow12wpg+el+yuHMGsGY3ZwW8IkRgiTMpX51DNYbIe+9H/qzg38jTq1YF1d0rv2nmlKrWwA5bZkfpHeeHwDLrmliqJvVkvUUL1r3qWQFrV8W8Q/gEe8nmueS75ymyoMHhH9Zz0WyGMZB+/9Oy7HCIZ0+61NhNLNtSq4CDsEj2VTYQesXFw8FcOCdzfnXiEnooOdVD0JaN5KxxYu0907TvcSuodlmkskTQ9jVA1A/fxfrFnh+QeOsNtyrJlw+lfiT0n24LdgvVvQQxzN3F0kUkL+1lcF8W/jl7SLloNjS5sVAEioqDEUQHUeSOwoqM+jexA3/YfHJ6Loo0YnG3/81VphkxTt6Oll2PgQD2TGB86wbuOlqRJE5Ekl76LKE9627GjDPPpmSjEIIOHlw4Yk7UXnz2uRWrTFO9GCU5HiJLXlXo4oEisxJ55IABkyjDQyv2M7o5CKArfmnY3kJt9MNAT0XffOAfJR2Btxw97SOzCYH96+x3ytCqe/l8/0GSCdc/STYa7JcBOtm4+MV91+piblogUc1Bpfm8UVPRX5xkyv8S4JHApu8eWjj8YGxtmfaXl3ygadxL+sT4/VIe6VWmsTbE0SdKzyh68zBX1xtcGMtfeZIQxNr21XScM/BRyad6kY25eo4HNuNVAJrs7Swla03UuKmBWXSJ5f9eNuYWUsujrBmJGhsy3DD2ZthHou0/iQGqx+NQeOfVyeYU+1uYMqy/0EbYEkiHxYLDro6GM=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620f532f-32bd-4592-21fd-08dbaecbb60e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 11:23:35.8473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lcg2drvOhgmemLMqd008hNa2xh96LBqPXHRtJm5VjPtCaQe9n4Ms8Y1hyagrvqwFcHs5fiJL7df1DTYP9wvU9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7043
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello Hannes,

On Wed, Sep 06, 2023 at 11:29:21AM +0200, Hannes Reinecke wrote:
> On 9/5/23 14:49, Niklas Cassel wrote:
> > From: Niklas Cassel <niklas.cassel@wdc.com>
> >=20
> > The target LPM policy can be set using either a Kconfig or a kernel mod=
ule
> > parameter.
> >=20
> > However, if the board type is set to anything but board_ahci_low_power,
> > then the LPM policy will overridden and set to ATA_LPM_UNKNOWN.
> >=20
> > Additionally, if the default suspend is suspend to idle, depending on t=
he
> > hardware capabilities of the HBA, ahci_update_initial_lpm_policy() migh=
t
> > override the LPM policy to either ATA_LPM_MIN_POWER_WITH_PARTIAL or
> > ATA_LPM_MIN_POWER.
> >=20
> > All this means that it is very hard to know which LPM policy a user wil=
l
> > actually be using on a given system.
> >=20
> > In order to make it easier to debug LPM related issues, print the LPM
> > policy on boot.
> >=20
> > One common LPM related issue is that the device fails to link up.
> > Because of that, we cannot add this print to ata_dev_configure(), as th=
at
> > function is only called after a successful link up. Instead, add the in=
fo
> > using ata_port_desc(). The port description is printed once during boot=
.
> >=20
> > Before changes:
> > ata1: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780100 irq 170
> > ata2: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780180 irq 170
> >=20
> > After changes:
> > ata1: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780100 lpm-pol=
 4 irq 170
> > ata2: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780180 lpm-pol=
 4 irq 170
> >=20
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > ---
> >   drivers/ata/ahci.c | 1 +
> >   1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> > index abb5911c9d09..541f6ec7f395 100644
> > --- a/drivers/ata/ahci.c
> > +++ b/drivers/ata/ahci.c
> > @@ -1898,6 +1898,7 @@ static int ahci_init_one(struct pci_dev *pdev, co=
nst struct pci_device_id *ent)
> >   			ap->em_message_type =3D hpriv->em_msg_type;
> >   		ahci_update_initial_lpm_policy(ap, hpriv);
> > +		ata_port_desc(ap, "lpm-pol %d", ap->target_lpm_policy);
> >   		/* disabled/not-implemented port */
> >   		if (!(hpriv->port_map & (1 << i)))
>=20
> Hmm. Not very instructive ('pol 4' ?).
> Please use a string mapping here to translate it into something
> human-readable.

While we do have such a string mapping:
https://github.com/torvalds/linux/blob/v6.5/drivers/ata/libata-sata.c#L774-=
L781

I do think that printing such longs strings will spam dmesg more than the
current proposal.



Add to that that the the descriptions are extremely misleading... E.g.
min_power_with_partial and min_power does include dipm as well
(if the connected device supports it), even if dipm is not in the name..

Likewise, min_power_with_partial sounds like it is like min_power,
but additionally has support for partial, but no...
min_power has support for both slumber and partial, the difference is
that for min_power_with_partial aggressive link power management (ALPM)
will jump to partial instead of slumber when ALPM initiates the sleep.
However, since DIPM is enabled, if the device is in state Active, the
device is still perfectly capable of requesting a jump to slumber.

aggressive link power management (ALPM) is enabled for medium_power,
med_power_with_dipm, min_power_with_partial, and min_power.
(Since ALPM is enabled for both med_ and min_ states, one can wonder
why we don't have a med_power_with_partial state...)

Oh, and both min_power_with_partial and min_power will, in addition to
enabling ALPM, also enable devsleep, but only if the HBA, the specific port=
,
and the device supports it...

So this is a quite messy... but not something this patch tries to address.


I guess the problem is that you try to map:
-slumber, partial (which both have their own supported bit in the HBA's CAP=
 reg)
 which can be initiated by:
 -the HBA if it supports ALPM, and ALPM is enabled
 -software, if told explicitly to jump to that state using PxCMD.ICC, but l=
inux
  never does this, except before probe or revalidate.
 -the device (if it supports dipm, and dipm is enabled)
-devsleep, which needs support in HBA, port and device.
 -cannot be initiated by the device.
-automatic partial to slumber (apst) - appears to never be enabled by linux
-aggressive link power management (ALPM)

all to a single integer.


> Also one might consider a sysfs attribute to retrieve the information
> from userspace.

Yes, that is a very good idea (although out of scope for this patch).
For now, considering the vast amount of information libata already dumps to
dmesg on boot, and considering the issues we see quite often with LPM, e.g.=
:
https://bugzilla.kernel.org/show_bug.cgi?id=3D217114

I think it is helpful to also dump the lpm policy currently in use.

Because, usually people only upload dmesg, since that is where the "link up=
",
"link down", and link reset messages appear.

So I do think that adding the lpm policy to dmesg is helpful, regardless if
we eventually add a sysfs attribute for this as well.


Kind regards,
Niklas=
