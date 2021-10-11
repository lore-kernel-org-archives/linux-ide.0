Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2462FC433EF
	for <linux-ide@archiver.kernel.org>; Mon, 11 Oct 2021 19:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00FC860F5B
	for <linux-ide@archiver.kernel.org>; Mon, 11 Oct 2021 19:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbhJKT5V (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 11 Oct 2021 15:57:21 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:10439 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbhJKT5V (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Oct 2021 15:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633982121; x=1665518121;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=1YMeQ5r83MkT1oG1aU+cAEHmUmqCJwWcJPrUosXf2rc=;
  b=G1Jq0XfUT+5VlPDGLslCXU8UwLJwJkBYQOqxMIjOoolHIh0FxCrj9aJv
   gTuUYoe8MPNd6d8IeOOFL2a9sgnGScn+uTf2LsoAZqTvgPnpqKa+L8JiP
   Rejf4p8SWyohp0Rzs06Jgk4OXzDjWFlUgelehM4xeeBCV4IHoQOyiQG2I
   pmE17vMsJeMC5TtwXXq/qWFFrLvJxfWJ5zz4JjGHgAu9GEpBs/DwOjmbo
   z/cvHcm3Sa7+gK0TZmuqeO3Y8ENV00u67Bj5ARh8FMxsAfR1wqxeJiPNi
   QVUeEbAgQ1F2Iq2sHJ7BFoRrVLPPSeYhnf6J9Vo68OhjUPGjdfnCYzutZ
   w==;
X-IronPort-AV: E=Sophos;i="5.85,365,1624291200"; 
   d="scan'208";a="181553931"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2021 03:55:20 +0800
IronPort-SDR: cB6UKN131nSRHCND5C9F6useKOCIa4e9qsNRIRU52wPblFdMtufe5XOlwOyismAXrm/oM9MPOL
 GPqvBD8jQ7QseU0sr+rYvoUAYNFKPQzoFjWBv0Dlnc+EHopJjjaKiyvvOCXf6fIilepEvNj4wf
 jdTNuZymRzz4BPHxwJUV1y8Spznuqy1yTZL0PEhIWpCsT+ZlorR79I9OQChyvXbBER0DnYXh2A
 +wKq4eM7oZK88MAZWanKhQ1L2+yFJfX4MjGpL86Y9rhvzvzQgvsnXGFHaaA5YBWoppooOZsrXf
 CXzxasHdWqa1Zr612No4Pt8/
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 12:31:08 -0700
IronPort-SDR: O4+YIlQZ90+7qcua2lsNdA8L5I45Xu619HMkCg7xB2/Rpa4HHTnT1RBX4NNd/pApBYpcbBHEtJ
 QDesVeWwvwyj04mjqfKmSwsb6waOfKUcbRS60HSMFPmI2tTtHVCGvOhFEfcdP6ov5m9xxYbBWJ
 NfOfPyp2m13x1logQmCQ+c/g83cNhW1mxcNtKwNtlZmVXkhY3Elttyrf/QLA8Re79zx/RuEaqN
 Ae1jy/akuClP6MMf26gBs/6xNdzTRy6Nn14QfXR3P4l0lMviaTBTdRC6Yjw4obVoH/OtQTElM/
 SJY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 12:55:21 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HSqK41sVqz1RvTm
        for <linux-ide@vger.kernel.org>; Mon, 11 Oct 2021 12:55:20 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1633982119; x=1636574120; bh=1YMeQ5r83MkT1oG1aU+cAEHmUmqCJwWcJPr
        UosXf2rc=; b=Uh72Y7VZnnceDTZUME2StYHplZNwQ32eApq9jbitPcWRiM69Z3M
        vzo7Hq0fn1yStNVZRl6y+SJHrgWuOFO+otSmkji3kD4Ec27TR+X3gKoHRVWX3EWy
        mTYbHIN7cOuDjshMBK99J3jGeU85Dt57I+WCbdY2JrCNGs8KhBeYIq0iowzbtjzj
        ZJK0nB5NaxI8/s1M92Q3qCfx/SCOWzly/hfJWryECzqWkmE7JqJ5Vd7SouzKxXM9
        tRGzASIBQ08o4MZ2vdVH8Htj9eqbaL7qB4um3ZOdaS/G45jn1x9pzyzdXOcNlLFA
        /puhh5Z7sbwr3x2yONvEGbeE5psc2Io4Dlg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4xblNVGhsble for <linux-ide@vger.kernel.org>;
        Mon, 11 Oct 2021 12:55:19 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HSqK31zgTz1RvTg;
        Mon, 11 Oct 2021 12:55:19 -0700 (PDT)
Message-ID: <e4fba31e-27e5-c199-11cd-1cbffc7135af@opensource.wdc.com>
Date:   Tue, 12 Oct 2021 04:55:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH] Add AHCI support for ASM1062+JBM575 cards
Content-Language: en-US
To:     =?UTF-8?B?SXN0dsOhbiBQb25ncsOhY3o=?= <pongracz.istvan@gmail.com>,
        linux-ide@vger.kernel.org
References: <20211011114834.30773-1-pongracz.istvan@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211011114834.30773-1-pongracz.istvan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/10/11 20:48, Istv=C3=A1n Pongr=C3=A1cz wrote:
> Signed-off-by: Istv=C3=A1n Pongr=C3=A1cz <pongracz.istvan@gmail.com>

Getting there ! But you forgot to add a short commit message. You do not =
need
much I think: simply describe the hardware being supported. I think this =
is a
SATA expander card with port multiplier, right ?
So something like:

Add support for SATA expander card based on ASMedia blah controller chip.

Will be fine.

> ---
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


--=20
Damien Le Moal
Western Digital Research
