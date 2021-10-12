Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B7AC433EF
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 02:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DD8A60E78
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 02:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhJLCW4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 11 Oct 2021 22:22:56 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24166 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhJLCWz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Oct 2021 22:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634005255; x=1665541255;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Hdpfu61NK2jCZ+nrHzbjU16uXJwHiZD1bPqpYESa6NE=;
  b=MEx8a/fpYRWWARL7fxXgHK5mm4knWICKHhe5/cZkgUbkAI+9X9vECnni
   niHmWyfpvzcK+m8PrKEtLCfOR3BDfWKStBWkzbDU4mlwIPsxZmnefpSEt
   tK5YRbaUGx6YX8+/D8NaFLmh71uv+UitjYASozZfvKHlcOXhjApzlrYxV
   kdnprtOu7k8WAa/hSidYqF/iMvmRo0vq97jtaXfxm3tTke2HkzHN7rWlS
   6vVAAKodbXYvXUnjr11ZS0+k1iq0GQLDwR7m7cVCk5lnrSOr7DQVbQ2yF
   PteL9Rr4VnL2L6b5FTF9Mwak/m00wWijZOKK2Z8YvpYIi+Tm9+daXOJ2f
   A==;
X-IronPort-AV: E=Sophos;i="5.85,366,1624291200"; 
   d="scan'208";a="183506630"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2021 10:20:52 +0800
IronPort-SDR: RVRY5b51tl4idNeyAwbTPr3ZKv0DCaVf7MglqurpesmNbYz7/jKyh6YMMziCWIu/SuhnRdmK+I
 +V6acMSDPURy/zaOQvcAGsK370S46BVsQ5Iw1aZ6kHoNEI+jgQBbKnn+Fm4/J9pO3MjSFe80Gs
 3bqBxmVBo4oMt/LgX8P+JE3ceQJj+t/duh3kvrhXxPdRgffzgwwW2SrqJwdkWjMEcmobWjrjG5
 VGgaNP/bGM3AjcOwU4iQlvnbjc8sxeFGyXLXT7akuIaDfDORnKyI4RhWeCm8KXky7LZVbRu/ps
 beLw7LDg0CWp0L1i3Xg4m/nA
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 18:56:39 -0700
IronPort-SDR: KOIcfENYF4+9Im7A0VfREvA0ffd3KBIFYoBdc7wN+adt+DlO/DBERTIj37/XbHpPIrcRqNwFAC
 3px9jjPfp1D2gNYLB39qdFpWWP2+r5xdQ98mVsVMbAb4Vscss6IU6tbZdtXy3Cywq18LtWkNQW
 cemh6mOVtN19HwXvLLvkzWymgALNvuDi+KCAlvExJx4ZqmUe3gdPRwmoPgMmiFiIpgWe0IfbkZ
 u+s9leeX7fd4PQ+UBMxEAyE1wBWYh4dIPKweo4h5PFKSGiWfdWrA3vWdwoG32eSCuU27SIFeRQ
 oq8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 19:20:51 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HSzsv1B7Bz1Rvll
        for <linux-ide@vger.kernel.org>; Mon, 11 Oct 2021 19:20:51 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1634005250; x=1636597251; bh=Hdpfu61NK2jCZ+nrHzbjU16uXJwHiZD1bPq
        pYESa6NE=; b=Q7UNrJGpQn6Dwy1ev2WXZh6jrWp64D4XFeD3NS1hQZflzzwHKuf
        rz1IvZi3RAghdD/Ij0vZ5lxEszLPfQmBtItaoFbT4XSSsQH72kyQumU4Gmn95a+v
        GZIKTurwFvV3jo5xWo+b21bdTd1kS2d3SgOWXT+TTc6qFOfr07/AELmDfUshVfo8
        1qgxogws/IFfRft8tpnTVFzAhf7LRwWBH8SaV+V4tqN3GmBfuqc0IusIakBjF2lc
        W70Z5MDB0kicgRolMQC+vZazBfUTgn0LOnofsVGxYpiRRFqkT+U/Y4Lv4Kj3prba
        K0999BbrJjayBWgQkrgybNXodT6gPqZHaSg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 77XNNTmKfdr7 for <linux-ide@vger.kernel.org>;
        Mon, 11 Oct 2021 19:20:50 -0700 (PDT)
Received: from [10.225.163.54] (unknown [10.225.163.54])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HSzss3xz5z1RvTg;
        Mon, 11 Oct 2021 19:20:49 -0700 (PDT)
Message-ID: <c3a7bdf2-caab-99e6-4da6-25638e3b3c24@opensource.wdc.com>
Date:   Tue, 12 Oct 2021 11:20:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v4] Fixes to DMA state check
Content-Language: en-US
To:     =?UTF-8?Q?Reimar_D=c3=b6ffinger?= <Reimar.Doeffinger@gmx.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-ide@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        hch@infradead.org, Paul Menzel <pmenzel@molgen.mpg.de>
References: <11506f71-80ea-a40f-1d5a-50c8005fcc42@opensource.wdc.com>
 <20211003132851.12574-1-Reimar.Doeffinger@gmx.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20211003132851.12574-1-Reimar.Doeffinger@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/3/21 22:28, Reimar D=C3=B6ffinger wrote:
> Patch series to add ata_dma_enabled calls instead of incorrectly
> checking dev->dma_mode !=3D 0.
> Only the first patch is confirmed to have caused real issues
> that it indeed fixes, rest based purely on code review.
>=20
> Changes v4:
> - split per file/driver
> - added Signed-off-by and Tested-by lines, improved commit messages
> Changes v3:
> - found and updated more cases in pata_ali, pata_amd and pata_radisys.
> Changes v2:
> - removed initialization change for SATA. I got confused by the
>   ping-pong between libata-eh and libata-core and thought SATA did not
>   set up xfermode
> - reviewed other cases that used dma_mode in boolean context and those
>   seemed to need changing as well, so added them to patch.
>   I did not see any places that would set dma_mode to 0 ever, so I
>   do think they were all indeed wrong.

This looks all good to me but I do not see any CC Stable tag. Do you
want this backported to stable versions ?


--=20
Damien Le Moal
Western Digital Research
