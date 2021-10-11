Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928B3C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 11 Oct 2021 21:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FBA7601FC
	for <linux-ide@archiver.kernel.org>; Mon, 11 Oct 2021 21:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbhJKVK4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 11 Oct 2021 17:10:56 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26445 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbhJKVKz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Oct 2021 17:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633986535; x=1665522535;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=oDLi+KgfXpfz38eECrrdY+1SKjY5IkDTWIJQj5BFysY=;
  b=br8QneVgjDsbA5Cd8dJH8IU/KzSJWhjWHwPyX8r1DxU6wqmefFCPCXfk
   YGqBIQf0gjp6c6F6aAASIsPgg9LKuw8GntAum3itvB9WGmBqQQlDEe8Bg
   oS9TtkV26EvmCuhzXJV4nM7puCzr5sfL5TUZu0kWk8aE56Esoy0QKfMn8
   LoKeUMSukvxmW2J5QqSt77TZ7BrNUFQSdWce4rMmD0w5sdodKSV17C2Ji
   21pNoPlDSUzTJXqjwMj5Mulcvz51pdFjvBljCtNpscPZZh8G91DGpxVcl
   nE4fRqa9hZhzsJ4hRMEY3/J/XmFFGESh3mfF5OuMZh2T+Eo6tFK11mgXD
   g==;
X-IronPort-AV: E=Sophos;i="5.85,365,1624291200"; 
   d="scan'208";a="294253469"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2021 05:08:54 +0800
IronPort-SDR: A6XY0lr0fr0pOensVpMTkxGPYoqmOxK6IJ0bSuiQl3avh37WCyBFChx13KbIYtEthet/aNMcuW
 xSW+T9cAcPmWzGPl5PlaOD3+4k8M1HK1Gk+cG2Snd/bRRm6Bevya5Vq8LOViz4W6Aty0iovtWq
 16FjbaVxcr6sRw7CK/reyGywFVbibCvlD9WVdfuRUJw+7dManSZ2dkjTb+/0uHYcBgmY0zZ4Ob
 /OHP9LCATglBAxSsfi2FHXdlq5YUVU4wRdB0wD89KSNEs4QYq1gcPOjiV0n+NjJ5nKGl2IPurX
 sbslT+/TLvU3GWqoodwMgxPv
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 13:44:42 -0700
IronPort-SDR: X3FfAXAufRxBVDxSHJbPYDL6HtpznLNHQFzbB9V6+63YFHMnhWvksZQ6VyO+V3v0S/y2exVQl+
 d3fmcI1S3Cw/8SFGHNMH3rVULL5h2T0Jpa1OvSwNJlqJ368P2f4yUX9FtwRGGzgXc9Up9WB7Oj
 uzskFKdseNDpghzmVEWtcAC7j2vNdzNDHGF57ZvA3wr0UUHTkQojW4pW6cjy2O59lTvY2Ne+GT
 vI+G6J5JJjK9eSQtuLsAeLkDJeJOZ7pZxovCwv3S/52TF/WPomP29flozLQ1sQie0EB3zU9Xme
 R/c=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 14:08:54 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HSrxy13Zgz1RvlJ
        for <linux-ide@vger.kernel.org>; Mon, 11 Oct 2021 14:08:54 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1633986533; x=1636578534; bh=oDLi+KgfXpfz38eECrrdY+1SKjY5IkDTWIJ
        Qj5BFysY=; b=d4P0cX4Olz6ptaEIjcL7C/jdgJPHBfM+JTMivzVWkG+mDtAIXb7
        7gPGZTorvMNkrayXvn5Up7rtEgYY/yKjo7/MtVM7DGusd2+XmypCw7/AwNpQkzUL
        s7J0oUWN/ycEoV6seKW93ddcmDCHF+/sd/wTZaqq1flMVmaGZEg/FMEXvsK9sNip
        t35JCYZsnUvTlmEO+OGBWMTUhbW5CtshOw36L1AxCrfdatV0SD/41N1VwFIR+nB+
        P6sQN7pXOTlw2Aj+khrd6meg0NceeOq8c5sGWtpp/uoBTL/WF+0qNI9XM+H+ugjj
        UyGkAxpRVkiX8KA2tm9wXNiLrWsXlmZIjeQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id srpdSdkP70Rm for <linux-ide@vger.kernel.org>;
        Mon, 11 Oct 2021 14:08:53 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HSrxx3F3Mz1RvTg;
        Mon, 11 Oct 2021 14:08:53 -0700 (PDT)
Message-ID: <401bf00b-d371-566b-6f80-26f19ee56f32@opensource.wdc.com>
Date:   Tue, 12 Oct 2021 06:08:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH v2] Add AHCI support for ASM1062+JBM575 cards
Content-Language: en-US
To:     =?UTF-8?B?SXN0dsOhbiBQb25ncsOhY3o=?= <pongracz.istvan@gmail.com>,
        linux-ide@vger.kernel.org
References: <20211011210455.3444-1-pongracz.istvan@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211011210455.3444-1-pongracz.istvan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/10/12 6:04, Istv=C3=A1n Pongr=C3=A1cz wrote:
> Add support for PCIe SATA expander cards based on ASMedia 1062 + JBM575
> controllers.
> These cards can provide up to 10 or more SATA ports on one PCIe card.
>=20
> Signed-off-by: Istv=C3=A1n Pongr=C3=A1cz <pongracz.istvan@gmail.com>
> ---
>  drivers/ata/ahci.c | 1 +
>  1 file changed, 1 insertion(+)
>  Changes from v1: rework commit message to meet syntax and content requ=
irements.

Almost ! This line must be the first one after "---" And put a blank line=
 after
it. After that, it is the patch proper. It should look like:

...
Signed-off-by: Istv=C3=A1n Pongr=C3=A1cz <pongracz.istvan@gmail.com>
---
Changes from v1: rework commit message to meet syntax and content require=
ments.

 drivers/ata/ahci.c | 1 +
 1 file changed, 1 insertion(+)
...


Apart from that, this looks good.

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


--=20
Damien Le Moal
Western Digital Research
