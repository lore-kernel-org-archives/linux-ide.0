Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314A1EB64DD
	for <linux-ide@archiver.kernel.org>; Thu, 27 Jul 2023 23:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjG0Xyn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Jul 2023 19:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjG0Xym (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Jul 2023 19:54:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23379E0
        for <linux-ide@vger.kernel.org>; Thu, 27 Jul 2023 16:54:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB55E61F24
        for <linux-ide@vger.kernel.org>; Thu, 27 Jul 2023 23:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F73BC433C8;
        Thu, 27 Jul 2023 23:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690502081;
        bh=4VcpDwLxvBGwD4UWZHNLM6w62eClU9YfLKmhZb9nE8c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dGUqJP1zNqog5TLfn9dSFAhWPf27GZlRNRsihq6BUte4aWbbgGxOmBiTHilPkfEDw
         7OvhGyOcrITIsz6/zPyL/U09u2MvfkhWZV1CdF4ZWmLuSIJLa7fjuiauYcVy8R8Jpq
         XC7HPjgP4nVIeKah3vuP7EMicR2rz44BlemsjZpukrfdeEXGy2IJ6hHb8dDxVQcGji
         tPvnj5bCXhJRK9LsQc5S8sbh57sv1CfIKzgzL4ufi5NtgvO6oD00wwNIAtSHDdfHBQ
         ItK4oKh+FowVnTQhMHtt9ksc9ibr3vTumjWVzoWhrhtUKny+PpdHMhL/8y1k4E32AG
         9zElEA4AMpm/g==
Message-ID: <fde085a6-b212-9b77-2a60-ca9cd5419532@kernel.org>
Date:   Fri, 28 Jul 2023 08:54:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ata: fix when to fetch sense data for successful commands
Content-Language: en-US
To:     Niklas Cassel <nks@flawful.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-ide@vger.kernel.org
References: <20230723130315.427513-1-nks@flawful.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230723130315.427513-1-nks@flawful.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 7/23/23 22:03, Niklas Cassel wrote:
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

Applied to for-6.5-fixes. Thanks !


-- 
Damien Le Moal
Western Digital Research

