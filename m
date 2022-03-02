Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CFAC433F5
	for <linux-ide@archiver.kernel.org>; Wed,  2 Mar 2022 12:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241697AbiCBMPQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Mar 2022 07:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241700AbiCBMPP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Mar 2022 07:15:15 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31172E0A2
        for <linux-ide@vger.kernel.org>; Wed,  2 Mar 2022 04:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646223272; x=1677759272;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=st7VlNZfsQedcZfoXbBc4FhTRPPMwwLWFLadNwX0BdE=;
  b=Qe8zMEtX23lGRQaCOhWNOYfBp2rjTvXqQkVlYON5VajmO/L/ICRLXLdG
   H0WRNFnYjUCZDLsE6IktpXfEAsKoGi71OV8NrX8j42kkwZT2LZKkzt+S8
   zOVUgnL1MhMJ5Va6WUu5ykZH8W/Ew4tLaisuzQrP254jkLS4O+VJ5ziaf
   eF3eezAJiZjEMiGzZwjvKlgW08wUCZ8UmwhJb/4YwtM1lZQbUyX5mgO1t
   5QngVEOH/z7AU7n7KUDnnlP5g1zs74yKL/Uj1zywpX2fjvDbsmd+Kf1A/
   8QxtiXdtppbpKcFTakQGrNmrlU9MkZ5m32dBcR3/WfABs5ZJ4rhUsi0GX
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,148,1643644800"; 
   d="scan'208";a="194288545"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2022 20:14:31 +0800
IronPort-SDR: jjW3s0l5n0z7TpjrWnXsVZallWN6NdlHfCGv73Gma/7PdfcYGPfTYMhsg9xBn4K7Ug28Go3yXL
 J0hNPXRb5+9VrnLlrqIVj7404/Nnk7unlySwBX7RG0KL3q/4bkpje01B8UiPekTSZluNWFRpCK
 t+AUvXHRw/WoZBUPhSqbegGlfHzTJQ7DGwNh8oUsomiQLu2B0PV8VU6wZ7ffLGXEq9JZKSCXlr
 42Q6BJVqDNV1UnVnIMd2y1pTQp4oZDeCziKTZ+k+SZFEX1vAfgYTyryzsdXVJjnddUWYerEWf1
 iVuCk5Oag09Bd6IPuB11aV27
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 03:46:57 -0800
IronPort-SDR: pdSzWQu00NKDTkCkHwmcJ7uSL0Vlu/1VE7917rcMydcloZdUX4nJedwJe6cKG2vCdiK3ULLMni
 p4v85hqbAZJppFFJVxdKvxSWVKgTUhJDqOnvGb0hjQJbQ7Wt164cilZnnyoAAaOork6sW63G5E
 HFRko2FUT+/9ck3sLQB8hfr4EYGZqUvNQX0bojWRHHbOeCx+V0VlIm4vblWnpSFWYGzf89DoCu
 WrPACyUYAgLNpRWHCimZadGzM/tpkuT67cJct5zxOnDY17rpQA4o7LXCRm2X55sXH7QHK4L1j0
 bAA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 04:14:31 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K7tMq0t3rz1SVnx
        for <linux-ide@vger.kernel.org>; Wed,  2 Mar 2022 04:14:31 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646223270; x=1648815271; bh=st7VlNZfsQedcZfoXbBc4FhTRPPMwwLWFLa
        dNwX0BdE=; b=O/Xqlmd6L9ZYxVWuxfR7//vQFr6cu+V9IZCqSsUSG9mKBN0c+OM
        1TgcokNV4wTCyoZwGM54aSKvgzQRi3kkt3k24oo5kBBwYp9pQ8DyKTEDC2FQyEyn
        cQl9CIaWqJ2UA/1asVX3livd2GhNNQPvNeeO5CFbsNS4o71YYi+kMvjIH+dTzqs9
        2j8/U9vm+t7heVa9v1z877eIlSHyx5XIKCNq5dWukQyTIUFISkKCAbtElji6/fJP
        X2GBYkPwysF34vjfViFYoVrKo8eeopUG52Ut/u54i+YbHU3cet0lG4q35zqiHbJN
        2lcby5a4aBon7Nw5M3Xwo9LPs+pIYrzr+tg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id p_9fAJjE1N6N for <linux-ide@vger.kernel.org>;
        Wed,  2 Mar 2022 04:14:30 -0800 (PST)
Received: from [10.112.1.94] (c02drav6md6t.wdc.com [10.112.1.94])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K7tMn1p73z1Rvlx;
        Wed,  2 Mar 2022 04:14:28 -0800 (PST)
Message-ID: <3ae1eef4-1617-5202-a893-16a9b49638c3@opensource.wdc.com>
Date:   Wed, 2 Mar 2022 14:14:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v3 1/3] ata: ahci: Rename board_ahci_mobile
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        pmenzel@molgen.mpg.de, hdegoede@redhat.com
References: <20220225172319.846891-1-mario.limonciello@amd.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220225172319.846891-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/02/25 19:23, Mario Limonciello wrote:
> This board definition was originally created for mobile devices to
> designate default link power managmeent policy to influence runtime
> power consumption.
> 
> As this is interesting for more than just mobile designs, rename the
> board to `board_ahci_low_power` to make it clear it is about default
> policy.
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> changes from v2->v3
>  * Add tags
>  * Move new board ID name to correct location in the enum
>  drivers/ata/ahci.c | 96 +++++++++++++++++++++++-----------------------
>  1 file changed, 48 insertions(+), 48 deletions(-)

Applied to for-5.18. Thanks !


-- 
Damien Le Moal
Western Digital Research
