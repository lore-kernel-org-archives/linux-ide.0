Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BB6C636D4
	for <linux-ide@archiver.kernel.org>; Wed,  1 Feb 2023 21:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjBAVGh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 1 Feb 2023 16:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjBAVGd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 1 Feb 2023 16:06:33 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527916DFC9
        for <linux-ide@vger.kernel.org>; Wed,  1 Feb 2023 13:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675285590; x=1706821590;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iRKnL0h2vDqLOR7wwetQc+wVcIvEQsrF0Mp7+5R7hA4=;
  b=h7s5KrF9z59Ya/DfLyHy36chPuJOj0NYjb24DK35Eepv27PA4CDsrs2D
   u01bkbxfukVC5aU0omiOYnKZWE7C37FgEHHew4OAf6gx8RhVVUzuu1lfQ
   eHfl/sBR0Bmm9ySc2AEdcXT0f3P01M3os+V8ZYJfUQ2qC54rp88CJchB1
   fXQ1Zhv3F0AxXhIn8wKVIAGJKyGWJwfSh+/LTpxu6hbIjH/h7bkCeTqSh
   xC4nuJsC/hTzfNiyl/3CNvwvUI7OwxzHwBUIagD5z6AX+8JT4ASXlldGL
   gK5nppYkhkpslB9OsFkiaa+nHPxqX/lVZdB6fhBzcJx6XqTAP9ctu7F+a
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,265,1669046400"; 
   d="scan'208";a="222354875"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2023 05:06:29 +0800
IronPort-SDR: aaE6glIN/XZcx6zAhp1B3Tyle0BHzwUxQiCKWIL7ebTA1mTUG0inmf5GFzj9uAu3qb77AdM10C
 j00Iizg3mSmJlw0Wn4dS4ScrT5DEY74XaCFJSKDGFdhmscDnUTAWvwSjFmF3j1zTvs7K1xzj73
 ZVCTMW20bTAIjv1HGaqMB9YIoVrt+/jIvUjRcuCHk5Ha+vmPkAnKdEYqTGZJ2thkKfgH5YfqbV
 4e+CGDUjqCqpT5oYs2dutZHDmS2iTGAMSyI+XADu/3nL2Naf3ih848QM6LM8RiLWTs/ELP//BR
 K4I=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Feb 2023 12:18:08 -0800
IronPort-SDR: ZF/MND1F9YpaWHbqqjQgXMwdta4URDlTV5X0v5rjMWJ0ksQBe5/q8InEsvhcRDWwwyFmTR5IBS
 oO8C8wh4VjLVBhv6RQMQ5MEfsHMNy0q9odiZN66rW+yGx6rP6vqrOHpzjW8qR9pqy+cnLB/Xc3
 QyKogwtqCvljXLGoVAReYJ5L0GL4gosZXkpKIxsM/F6ILWoqcsDWCbIcpcaNp4BXPoMzPy6dYb
 6q7uABZV9N6r7iDG7LTH78HzvzYzX2b4FXAHIa8QACdBpqztaIEtFZrMmua5ZIydn3Kmr4UvtG
 tBA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Feb 2023 13:06:29 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P6ZGY1Lcxz1RwqL
        for <linux-ide@vger.kernel.org>; Wed,  1 Feb 2023 13:06:29 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1675285588; x=1677877589; bh=iRKnL0h2vDqLOR7wwetQc+wVcIvEQsrF0Mp
        7+5R7hA4=; b=V8ZS818BsRUL1nCwybqdEYTe8Wx0WBi6qOXAxFoZKbXfCBwwWFf
        VOosxalLJs4cfWKySVQbx1ZrLB5YonTFBaoj/OLDVfT8cUBJ8bD5tiSE5hzQ46RF
        TEakRsy3ipmA2B41lBPZ393WOLeL83l8wWtcOnR/4nSLayBR+cXU60TKUAZZkqU3
        m9id8XIALxEB+iWm2k7m3TXJnm913IifTzv30TSMO2LexFx2Yy+QwW5uL0PLMTEh
        vHlfWflhhZbCIVwDj00GWrUNQ6CJKTuSmUOhYwjGnWlId5TVTF+fr24Bl74RV9QG
        GmSDm/bX8s7qZ+Mjsw8eY/3NXzRSKvHjbdA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tuAA8zZaF9U0 for <linux-ide@vger.kernel.org>;
        Wed,  1 Feb 2023 13:06:28 -0800 (PST)
Received: from [10.225.163.79] (unknown [10.225.163.79])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P6ZGV4bwJz1RvLy;
        Wed,  1 Feb 2023 13:06:26 -0800 (PST)
Message-ID: <7cf17a27-13dc-e6b4-c34c-47454239af30@opensource.wdc.com>
Date:   Thu, 2 Feb 2023 06:06:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] powerpc: macio: Make remove callback of macio driver
 void returned
Content-Language: en-US
To:     Dawei Li <set_pte_at@outlook.com>, mpe@ellerman.id.au
Cc:     npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, linux-ide@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <TYCP286MB232391520CB471E7C8D6EA84CAD19@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <TYCP286MB232391520CB471E7C8D6EA84CAD19@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/1/23 23:36, Dawei Li wrote:
> Commit fc7a6209d571 ("bus: Make remove callback return void") forces
> bus_type::remove be void-returned, it doesn't make much sense for any
> bus based driver implementing remove callbalk to return non-void to
> its caller.
> 
> This change is for macio bus based drivers.
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
> v2 -> v3
> - Rebased on latest powerpc/next.
> - cc' to relevant subsysem lists.
> 
> v1 -> v2
> - Revert unneeded changes.
> - Rebased on latest powerpc/next.
> 
> v1
> - https://lore.kernel.org/all/TYCP286MB2323FCDC7ECD87F8D97CB74BCA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM/
> ---
>  arch/powerpc/include/asm/macio.h                | 2 +-
>  drivers/ata/pata_macio.c                        | 4 +---
>  drivers/macintosh/rack-meter.c                  | 4 +---
>  drivers/net/ethernet/apple/bmac.c               | 4 +---
>  drivers/net/ethernet/apple/mace.c               | 4 +---
>  drivers/net/wireless/intersil/orinoco/airport.c | 4 +---
>  drivers/scsi/mac53c94.c                         | 5 +----
>  drivers/scsi/mesh.c                             | 5 +----
>  drivers/tty/serial/pmac_zilog.c                 | 7 ++-----
>  sound/aoa/soundbus/i2sbus/core.c                | 4 +---
>  10 files changed, 11 insertions(+), 32 deletions(-)

For the ata bits:

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

