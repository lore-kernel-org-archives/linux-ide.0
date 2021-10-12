Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721ECC433EF
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 01:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AFA360F14
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 01:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhJLBFG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 11 Oct 2021 21:05:06 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:28995 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhJLBFF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Oct 2021 21:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634000584; x=1665536584;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=N86+su4sakzgJ0zUBpvsNyaRc3IVuNp93PfOPvG5Fms=;
  b=gBLXWpYVenWBSYZA8TgqVyKGbDIM6oEQ4XwODM7aAgYIq8b8GMFF2lXh
   4VF8y/U0qSgDxnatHJnMbE0q/earlHjbxYcFWeETHSNI701KRmk/bXZ7z
   ZFldrfgvFWsfZ+vgOX0P+xyBJtT7SryUtoim9LY07davYE3enjr09DFwV
   RxDtE7wN6MuTy2SZnWCtRcbVrZ6CjuCnsazRnU7CGLnNvGPjTEpab7y9Y
   fh77yOv2fwMwmfajA07LA51HuIdK+csIRfzvUJGs65+lLK313bIFBQTqK
   hP8B5P0C3OaJQHsQpIJwMCZk+xq7KJK3VqmqtpQYU7Oe4ZxQzGcoHD185
   A==;
X-IronPort-AV: E=Sophos;i="5.85,366,1624291200"; 
   d="scan'208";a="286401997"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2021 09:03:04 +0800
IronPort-SDR: PhsLAJzdD0qcjAFEvhf6dm9DbjyI+T/bq9hI0QuXYi2RYkS2Ni2DRME72A/t+EWMqE6+tSKkBb
 zwRfpTfgKw2yjyQ6JiSBGMDY7TAOmwB476FtSPi7JDtmJjJh117Hzh+2Of9xEFc89fnGAxRYvD
 oqYoR/dLCqkCIoRzC4XLMbJ8CpDOswzl9wW42+eN9nGIjj/eIE/tPFAGVEjTEEn3KyDaL5bcee
 bRloEY3h6te1bPjX3v0twZ/5MWN+lmau5TP5BeNc6DbzMh3/VcQUBUnniGEky83O5BZGeIiMRv
 0ZDPqcC0nRVfXGowryzZgolm
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 17:37:20 -0700
IronPort-SDR: wCgIY3NXCJxhF+YezP3AK0fucPtez0rWO98RIBMBrsflvalNWvk6e7toJQMhLggvD9IqaATtFj
 IAkIut8o/qREIWYakWV/0IogYh5HZqIwsOwJWGmY2DqJsBbrk1EKDgEKL5T8eyuT6eL8wPltDw
 9uTMEryVz4NersxUx43hn90nMROPG6ZGZJMLxoeYv65q+piE3fqx7N/kqVRDSOLcTWbOD9nsPR
 /lDpTxmbjpPwX2+72rANjxgb6Ds/agsW5BPZzdtIzFDOqpwLIK6oUZAneGA0B2VwvXIUwSOAH6
 mB4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 18:03:05 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HSy883Hh3z1RvTm
        for <linux-ide@vger.kernel.org>; Mon, 11 Oct 2021 18:03:04 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1634000584; x=1636592585; bh=N86+su4sakzgJ0zUBpvsNyaRc3IVuNp93Pf
        OPvG5Fms=; b=BrXDmlOY7cSK9PXPBIInosl0zkS+irFu9J0DjPl77Uy8uusQAw0
        5xfrIl/n/bCQsGPYrS5VAPdQn1PTQRB2+inTYE3Qch2cqz2nXytr/8VmADVG5EGF
        m8ZuFDwLqQOExS1l/LwHbn3HrWjP7cwXp6faxci3WZtfX9qu/KIR1AkyjnmBKO8P
        uEy/GcdOFVcWY/lOBLX6XD3ukrW41aCwmRgE8BnNAxMkw0uIuMoZduFI8427e21W
        9TMzI6V7/qn5v3Q1HqZTmK0FbvFjEkpfp9ArHnF1CpmM9OFNM9kiELn4xSqEDO4B
        X8OLEHpshJmbz91+cne1biiy7Sk853IJs9Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7256wOYbKDWY for <linux-ide@vger.kernel.org>;
        Mon, 11 Oct 2021 18:03:04 -0700 (PDT)
Received: from [10.225.163.54] (unknown [10.225.163.54])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HSy875XXmz1RvTg;
        Mon, 11 Oct 2021 18:03:03 -0700 (PDT)
Message-ID: <cfa8a1e5-d9ad-5810-aeb2-7fbaffff621a@opensource.wdc.com>
Date:   Tue, 12 Oct 2021 10:03:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v3] Add AHCI support for ASM1062+JBM575 cards
Content-Language: en-US
To:     =?UTF-8?B?SXN0dsOhbiBQb25ncsOhY3o=?= <pongracz.istvan@gmail.com>,
        linux-ide@vger.kernel.org
References: <20211011211227.7020-1-pongracz.istvan@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20211011211227.7020-1-pongracz.istvan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/12/21 06:12, Istv=C3=A1n Pongr=C3=A1cz wrote:
> Add support for PCIe SATA expander cards based on ASMedia 1062 + JBM575
> controllers.
> These cards can provide up to 10 or more SATA ports on one PCIe card.
>=20
> Signed-off-by: Istv=C3=A1n Pongr=C3=A1cz <pongracz.istvan@gmail.com>
> ---
>  Changes from v1: rework commit message to meet syntax and content requ=
irements.
>  Changes from v2: format changelog
>=20
>  drivers/ata/ahci.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 186cbf90c8ea..97fd96b67731 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -592,6 +592,7 @@ static const struct pci_device_id ahci_pci_tbl[] =3D=
 {
>  	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci },	/* ASM1062 */
>  	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci },   /* ASM1061R */
>  	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci },   /* ASM1062R */
> +	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci },   /* ASM1062+JMB575 */
> =20
>  	/*
>  	 * Samsung SSDs found on some macbooks.  NCQ times out if MSI is
>=20

Applied to for-5.16. Thanks !

--=20
Damien Le Moal
Western Digital Research
