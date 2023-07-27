Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F36C001DC
	for <linux-ide@archiver.kernel.org>; Thu, 27 Jul 2023 10:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjG0Ky6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Jul 2023 06:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjG0Ky4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Jul 2023 06:54:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F36E2696
        for <linux-ide@vger.kernel.org>; Thu, 27 Jul 2023 03:54:55 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A19D61EC0D52;
        Thu, 27 Jul 2023 12:54:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1690455293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5Vew3gv93sZeuVPW9h/If9SqB6vF7uze8gARGuyUYU4=;
        b=i6Xb9ODDP9V5rGcfOtRIoeAgf3VySpSP1MeAWFv4nMPAxJ7S6u72cwyyvOSY2ZXO8pGubD
        qDuss7Hjz3DfLNpE8Tm3ehrybXnVZ/CVHBe3SmzxvwCtc7DeMcUWs9Z++E27pOrHpRhdOL
        MVcAUpF9Jrv1r9Tl6SH+u/yaJf1H8/Q=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EQL-U382SWod; Thu, 27 Jul 2023 10:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1690455289; bh=5Vew3gv93sZeuVPW9h/If9SqB6vF7uze8gARGuyUYU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VJVl0iGb0d9aNkMJqPYIqvxuTl3sTiYfecnaO6Yge3Rs+G+k+LC7hIKGxz0yS+CTP
         pPWwG/xbf7++T9HXnI2N1LoaTQLtJ9isjdvcu4Ia1GGmy3HHoZZdnnwlCV1vdzfm3X
         O+nC06LVtTwYZR8HfxFYEYnT8CYvHnHi+bbNSCEsb5rHae9dRZZKA2Wl6J6RRINVUd
         CEAEZglpHoo3GqEDjN3E5/rb5kH8SDGUgHWkZk+bTKlf7vCdUcPWk/Go//Q0kGf9QN
         LH1pqAzjOuNBeF3VaBogkWxtgXo3Ucyb5d4yUqkLh2wyRQw4SsyTf+5KnTuOuwhWiH
         daez6+yzM25phZUQImZWruFN1ZqOURsi6at3TpuubSIg1KMyqQs2H8+4IpjfDf64xH
         DaWcU4+XFg3uHaG3493lyn3QEvH+kEi1xmnRrc3b5IYL+tq4D46tdd4DC0PEh1zb8J
         etcJKJbP3cLLhtu9KFoFBlme1rDh0k6t/pUBVmIN2M6dIhwPW7nVBoIzv58l7EjeNG
         W9ii1gGHxqZzsF88gUYPcuvWs+1MomgXGeNUrZSIzR4rQxoYVmI7uv1SxQ041CPL7l
         drLUdF4hNqFuQnDNd9QH67q5JOcxILIk6XA+G1zhvBFHR1etd5A436jdM3OxGczzTo
         nWAHBk6tj3ylCnOwqxlJSgVo=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AC6DB40E019D;
        Thu, 27 Jul 2023 10:54:43 +0000 (UTC)
Date:   Thu, 27 Jul 2023 12:54:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Niklas Cassel <nks@flawful.org>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: fix when to fetch sense data for successful commands
Message-ID: <20230727105439.GHZMJM77d44WK4fsgS@fat_crate.local>
References: <20230723130315.427513-1-nks@flawful.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230723130315.427513-1-nks@flawful.org>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Sun, Jul 23, 2023 at 03:03:14PM +0200, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> The condition to fetch sense data was supposed to be:
> ATA_SENSE set AND either
> 1) Command was NCQ and ATA_DFLAG_CDL_ENABLED flag set (flag
>    ATA_DFLAG_CDL_ENABLED will only be set if the Successful NCQ command
>    sense data supported bit is set); or
> 2) Command was non-NCQ and regular sense data reporting is enabled.
> 
> However the check in 2) accidentally had the negation at the wrong place,
> causing it to try to fetch sense data if it was a non-NCQ command _or_
> if regular sense data reporting was _not_ enabled.
> 
> Fix this by removing the extra parentheses that should not be there,
> such that only the correct return (ata_is_ncq()) is negated.
> 
> Fixes: 18bd7718b5c4 ("scsi: ata: libata: Handle completion of CDL commands using policy 0xD")
> Reported-by: Borislav Petkov <bp@alien8.de>
> Closes: https://lore.kernel.org/linux-ide/20230722155621.GIZLv8JbURKzHtKvQE@fat_crate.local/
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>  drivers/ata/libata-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Looks good, thanks!

Tested-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
