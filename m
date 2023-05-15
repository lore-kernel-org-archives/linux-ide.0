Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A0EC77B7D
	for <linux-ide@archiver.kernel.org>; Mon, 15 May 2023 10:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjEOKJc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 15 May 2023 06:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238353AbjEOKJb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2023 06:09:31 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E59199
        for <linux-ide@vger.kernel.org>; Mon, 15 May 2023 03:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1684145371; x=1715681371;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EdheYfK3loRxrywrw6YJxiR+IDpNilY7I1cehyeCqFc=;
  b=YVPob7JwhJs2s9UN7ZDy4RZA8ETMaDwLZJvXMLRRK+YWcT3Uk0EdsnnQ
   Rcj39iE78dAX2wYozRPjy/Q9DRRj53/3FVyPua4M9hoi66RuDjBLn4ANV
   Ot9Pg1FeX+okW9HAcMUZf7XNn+EHsOa2KpzMbF5Q7vIIwyuw5aeNHZwVz
   pSbz/XrqXZcerL0HTTlVcIIMiX0GxzzWArSgYMsbvXs39baUl/tvNfJT9
   WpqnyKaaXkE1ZVLOjUY9TDgZHu0ii8Xe5hVo7AtBEkZN4WRHPe/UPuHj0
   tA7xWQdQhUMqU39aYRywRcgACM5zXdAfimhwlLY/5dYi31quNnhW34Xqu
   A==;
X-IronPort-AV: E=Sophos;i="5.99,276,1677513600"; 
   d="scan'208";a="230736757"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 15 May 2023 18:09:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDLNj0HYimUYhJeetKtQatk78FXJaqQ5s7mx7wydKYMzv3wkBZrMJGpJUu6JzS7h1wWQEuEKQ9GDupLMoiXMmmFChBctmM0zJ/5ZQ+SC9DrN//uK8qNQaThvHA6L8AgP0gVSnpvNipMBqNz9ldefH8mfBa/YJVv8RtA9FKxuGF7tNzgfxY5RdZetD7pyPXuGrih6ZDcbH4J7BzfG10+SpsQl/P3XlZ/V2AK0Nd3SIlB+mkgOZ9Cr3UxInCm8rK2BO4APHBQSlHRp/dtDYQxH+TzXGRibpOMhxcXYBqYMQx611wzukZWxdJx4O6umi9t0DyA4rfvY086O+gc290+tGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D24p3KY3QwSX7GrAkv+4NaLRzolON4KTKHXXOI0+/SQ=;
 b=fBVW6kYPXlVG9rPwpQw87CCjVaHsc4/SRyf1yTiW18o0k+JQbEPhjQuOzyGDdD8xF1K7nF081re7jllNh3y+dgx9sDmxQ7+mH1zryHYhaz70DcykOGXDN8qSpdbc4OJnHm2Zp2OjeZg5u8UQUsj0p/orPuZTnvrHwRaFYZU/AcXYTAsJ1HSGTeheqed1s9qoykac6Q0jXJx23dTDhcltQDuDK97T4pqwt2lH9/9OM7xExqSpD+ZupOzOE3uEm2H55dWB6dvWw0jd4/ibgh4Aq/i/k1gISb4l53f5pNNwpfU8UaJpB2VhajFir7mjzQuXnvdD/uc9ZluG3LcmHys/WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D24p3KY3QwSX7GrAkv+4NaLRzolON4KTKHXXOI0+/SQ=;
 b=qc6nls1Koo0jYTozQt0oLtv8+Cp9ZyO/wQbOv9n0k1oaOjxrNWPorgtHkHLF+ypG46MgU55nm3HqVkdlyfaaGlW78QjKVmUo4JttrMQWNylL1ML4fN4Ohu+tXQBKFHEu/8TZz1Az3MTL0XxF01j7rwylm3xybW4FvcHk0IhCIPw=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SA0PR04MB7275.namprd04.prod.outlook.com (2603:10b6:806:e5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 10:09:28 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 10:09:28 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Hannes Reinecke <hare@suse.de>
CC:     Damien LeMoal <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH 1/6] ata: remove reference to non-existing error_handler()
Thread-Topic: [PATCH 1/6] ata: remove reference to non-existing
 error_handler()
Thread-Index: AQHZhxVVsfd7gsfnO0OIWUhtgOwDZg==
Date:   Mon, 15 May 2023 10:09:28 +0000
Message-ID: <ZGIE1r4uZUhqh8WA@x1-carbon>
References: <20230510225211.111113-1-hare@suse.de>
 <20230510225211.111113-2-hare@suse.de>
In-Reply-To: <20230510225211.111113-2-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SA0PR04MB7275:EE_
x-ms-office365-filtering-correlation-id: 0b68aca2-101f-4a4c-e3a6-08db552c77f1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KZ3I4WaLtUmIgcB4Rchil8VaiUjouHg4PTb8aHs4/Za3aPn37nC4N/S8pJ1+TqdiOWxVh+p6g2pSoqWDTJ5k3ZADlqUlRG/9QwieDy1R2WiYBxjIAsnD3YslNr7f63UUSM+goeh8h5ColZCQCTFcK0FhjGVOmpb2ke0zJ30/vJYAr4HFOjFbhYUFSAmtXAV4V16Dj4Uh7MveytQ69h3v7mAniPEcn0DDe4lvNiChrpk3bKme/+j7mTygV5kPfsWi13dlOxORoaD44OxBr9Q8Rah+xok80JGidZSeOk7P7H0MStupvQ6go57Gw9x7OYuAeoC/8FTwcGHkE1+B297SjgsVSdxesObYZRdk3Ci2GiuQzl+xbeOmBdEw8GfQO1oSSb1aqTH64Twab14U4YDoYW0zc6Cz9fR60uTrRPI7CgBtWE4aBU7wHAUVSFyFO8409PDjtWraCs6G0ZkrPA/AqBRm1Zhx7hOwUQp2kHnCm0az2Y060SV12yaboKhaDyOfIM1U95jtBGJvNW8d1ZdV2YIB+PsKL1tpNkl22OhjNGiHaumtvIaNiroFBcX3Bk0u0tVZb8Krk9L7esFgjUrGayXNwrOW3Ddw9GlveZLq/flEQoJDNTGejt5BCZb6t3X8flPzLe5srFNa79DPdr/HJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199021)(2906002)(33716001)(9686003)(82960400001)(6512007)(83380400001)(38070700005)(6506007)(38100700002)(26005)(122000001)(186003)(8936002)(8676002)(5660300002)(54906003)(478600001)(86362001)(71200400001)(4326008)(6916009)(316002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(6486002)(91956017)(41300700001)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bpgDgUPTW6S8nRMEvA4oAO2VMSIbJ7QYH8zfqyT/eK8EXieogyA6YujQEiA8?=
 =?us-ascii?Q?HBj4+GmPS2cSwiLCe0GWjaUxnsg6NXQKCGFs/+jRxisEcM4L7jiQbe3r5Q8x?=
 =?us-ascii?Q?p+Xd6PbrjMIZD80sLJMGyHJg/9Gc3wZRBLaSZ5vJYkMmNx5XRaSmOgqFnryl?=
 =?us-ascii?Q?bPdrm8nv3+H2S5jIJLU7BSBNiC8RPh80GWsuTppSRRDs4td9DhJaVYy970jm?=
 =?us-ascii?Q?dCJ1w3WKJKB5t+YjYAP2Yo6P2meypEGJUxpUzytOQHGrYGGH5vUYqUYcQdJF?=
 =?us-ascii?Q?bXRVhdtr35G/I7yXwTCA1xIkACbYczyQM0C9ZTVHaFIsHTLuO+8bbfHiXx3f?=
 =?us-ascii?Q?C7+TCKAHZWMcQFXh8CfjhtzN0Xzi7kfH4+zxz/iMNXa6g6xUmTRIkElqEFEY?=
 =?us-ascii?Q?fH1WaGOpwf7vdbOTcfNkp+OVYx7fel2ul7338KqiBVR05KMIBHR2ydTCV8pO?=
 =?us-ascii?Q?pVC4mTO2uHDBXz01kpaCdjPFBC2+NvYZul6xzZ565oDhBLJv8tQvAc4J7c8a?=
 =?us-ascii?Q?vr/SJj4mODStxiIwrD8ghvdei3RdtxLkWzMR22nqgtMZ0PruVoesiaEgOmM4?=
 =?us-ascii?Q?kZqyXK09BEV6EUzVk2ktGU9B2UH8Vt2WxOtdeSJDozsckrsbmGTpww79PrkN?=
 =?us-ascii?Q?oBlIf9mZLpEQhjl0dx72WbIG3KBnHB2ld1pRuOT2SC9yCgg8337y/S3AfVC0?=
 =?us-ascii?Q?fVWbORyV38HU3O/xj2mDWIdV60wk7pCvjkwzWmx6IgSLmS9YEXJNjL/1oohi?=
 =?us-ascii?Q?EvX0drWrf6KF9D0HU2CIklu/Ti3lcIktWw4hfqtQMSCj/zDC4i4Ujb4EMhjL?=
 =?us-ascii?Q?7dA+N9xNez/oiRq7h7eLRHgCtPX7YTSxZN4/LIRyyP8vjRgv+gH/bG9L8+UV?=
 =?us-ascii?Q?TVJ3ljWg67cLnqt9yJ58M3/Rvx9UN72n3oxM0fHUA8mvhGPISPGZ3omiLoPT?=
 =?us-ascii?Q?p61I58ytgOYrCIZynLCYpvR7yt+Dao2p9vCqfG2wRzZVDhL+Av0b0IXZf49A?=
 =?us-ascii?Q?mgZ1lTTDuf8ybKibRSFdGuUJH0q1p7J0IveBsUE7R58lmUSaYwUysDEBubYd?=
 =?us-ascii?Q?+Czbk9+ZvelW93ls7Y4T77b7f8h4PiAU+2Wyg+scdLUKTbdSb0vPT7KG/hWS?=
 =?us-ascii?Q?e4whOzzUonYFR7BbOTUOgnuwCIPRw51BO96ZRO9LoiHxCJ2bvfOLz+hpkx4q?=
 =?us-ascii?Q?OcT+zG6BlrR66/6Lqen4a2f5mB4jmAdH0Q0llqgiMWAkjcZL+9pI5ZuNHs6/?=
 =?us-ascii?Q?BHFrgOucxljWqbg8ZR82Cj4VboT4hnAvi59P+/5NPeXTz+I4CV2xDKH9HZCg?=
 =?us-ascii?Q?hczoa6ICg94etUvwf6zh+DE+4Akm7MJf2wRPvESqPaonXIcvb2t0FSOgqzL6?=
 =?us-ascii?Q?TkDZZmFCI5jomECCvzXkyCGR76kFAC2x04b7FCCyjRzG/Bezg2nsHMQwwcdu?=
 =?us-ascii?Q?o+S/xwdiuL5iXRPIMcxnelMlY87Sr5Ci/iaVMTU1NpvZoWQ0LcVQ1MNlN8dF?=
 =?us-ascii?Q?Rm4JuC+F5OpH9hu+T8sRWYpM1Ie86ht/Mi9AEz44LfddK2Qu3hyElZK6XNNF?=
 =?us-ascii?Q?kPtee2Qy6D0rQcstd8yT9zBdmUOExADMa4C6/j5Zhtop/2V5vQ5Hfr389wJk?=
 =?us-ascii?Q?QQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9DD852B89477C1448E1B18703446819F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ECa9IblCsIAVcfJgO7SZrH1iXe/OdvpUZaxlLK+uJ+Uvh0s4zni5pKLYsPQwVkLxw9r7jtFP6wqcIKTgCwUYSWUBxnvRFm51w97PiRP9qvXrS9kY49Wfo8Kbi20VNgJN0F5QxV4OmVydHbYih+cd2TtQ8XPWJUjXyZB1q/8k23JwC/vf00+4s0EGpu6qvBZls1z+Sg71msp8j+5XCt8zXqFj63novc+UjYJJCvjFR6l493abEqUQj5eKeA+QsrbZkZ2AJptUHrp+eIC/RxHEXho7S9ERZdDqUyJRSm7KJTpeVdhwmj8ZvfNGLOKZP5NOv+oQNYsQDChIrtLBNYp6ncEJhwex9nbTT2q+rlOmb3pRKDwuAogJ3emYROBUg2Hg+xQQlTFLMRPSIKP96WNoyQzUDUrpCinBE8zJB/3ndfUwcuGOi6VRbHMmnMxcEfUok0xpMsMkAUd86yg3w3lg63MLjW42jomAh5Bspg5iSOELMwyGtKWvytlzzJ9iew8IhgS1vYv/ip033cCo9n7r+VffmkLnX+aXBTmk1NeCL3Z2SEz4++uKkV/eY/h5fdhoD2RIKH4OYRoIAlhDGJMUBVuhXbsKsqgj7fFAIKj27YvAXRuSVpZ17tH0tgvxdz28anIwmQaKeqKq4Q51WlC7oilrE6KCSeSWwX/82ddENMFTwdyNtrcdGuxkC0ErCc5dfWTbGyqRuSipPMVq99AQl16vzXqKg0bFeRt3JNSZ19fFn45nHzdtExz7aXFjaS5XgV1bLFV2FfzSlES9BB4rl5mqOKOSPRQRaORhGePcFEXxlKUKCjzkKV5wbXIr9NOYAIVCcq8GlIvZgHZTz06znQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b68aca2-101f-4a4c-e3a6-08db552c77f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 10:09:28.2012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D/lRaiN74Xbb6xx9jPTDTofUn9a/P3xgfDKyPZrqYtoyNqS03cQsUIA0ksftLUGbdgGzcB6y3cHtZOEi30pnBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7275
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, May 11, 2023 at 12:52:06AM +0200, Hannes Reinecke wrote:
> With commit 65a15d6560df ("scsi: ipr: Remove SATA support") all
> libata drivers now have the error_handler() callback provided,
> so we can stop checking for non-existing error_handler callback.
>=20
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---

Hello Hannes,


I think that you forgot to update the comments in a few places:
$ git grep -i "new eh" drivers/ata


> =20
> -	/* XXX: New EH and old EH use different mechanisms to
> -	 * synchronize EH with regular execution path.
> -	 *
> -	 * In new EH, a qc owned by EH is marked with ATA_QCFLAG_EH.
> -	 * Normal execution path is responsible for not accessing a
> -	 * qc owned by EH.  libata core enforces the rule by returning NULL
> -	 * from ata_qc_from_tag() for qcs owned by EH.

I think we should keep this part, but rephrase it to not mention "new EH",
as it does provide valuable information related to ata_qc_complete().




> @@ -1680,9 +1674,8 @@ static void ata_scsi_qc_complete(struct ata_queued_=
cmd *qc)
>  		/* Keep the SCSI ML and status byte, clear host byte. */
>  		cmd->result &=3D 0x0000ffff;
> =20
> -	if (need_sense && !ap->ops->error_handler)
> -		ata_dump_status(ap, &qc->result_tf);
> -
> +	if (!(qc->flags & ATA_QCFLAG_QUIET))
> +		ata_dump_status(qc->ap, &qc->result_tf);
>  	ata_qc_done(qc);

Why remove the newline before the call to ata_qc_done() ?

With your change here, you will start to print all QCs that doesn't have
quiet set. That is a functional change and should be in a separate patch
if we wanted that behavior, but I don't see why we would want that.
I think that you should simply drop the call to ata_dump_status().


Kind regards,
Niklas=
