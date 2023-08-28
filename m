Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E59C83F17
	for <linux-ide@archiver.kernel.org>; Mon, 28 Aug 2023 10:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjH1KRz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 28 Aug 2023 06:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjH1KRd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 28 Aug 2023 06:17:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C72318B;
        Mon, 28 Aug 2023 03:17:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADB9A6374C;
        Mon, 28 Aug 2023 10:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7E1C433C8;
        Mon, 28 Aug 2023 10:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693217842;
        bh=JSl5gprFI2dDGPsYTRgF1TEMjAU65qHdia3VbYx/PR4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oy9kjmn4sBfpATiYFJpWFZUuX1benSYyB4y94lkzc8FX3qB6XEah9W6zBWSMOylmd
         fjYFvRAfwO3WMmP+XqQnXbDyQ4+bNnQH6+w8fly0zjQAZoQB2MuuAaTUewRZ6h+bJ3
         1joW/waDKeli6w48BlIFGU/gKNJk2/QzOZLXxL3ZRY+tru+Ln+2dYRTdEvyLsoh2h8
         UhmJ+6r+qIgiQWPbABaYFaJq7wdNGzPZmEwfq+UJJLDZ6rwV6llLxgDthbJMfR8DFu
         6HqYlnqpfvnKaJgWcRY6sadPgz5rkF8G+nf7UgP2qOn1tjMAzNBaVUngHB1yXXQLQO
         ZwGYVgz29SE5g==
Message-ID: <9438885c-8e35-2387-5fc4-eff20a3977c1@kernel.org>
Date:   Mon, 28 Aug 2023 19:17:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 0/2] Q40 IDE fixes
Content-Language: en-US
To:     Michael Schmitz <schmitzmic@gmail.com>, s.shtylyov@omp.ru,
        linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org
References: <20230827041348.18887-1-schmitzmic@gmail.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230827041348.18887-1-schmitzmic@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/27/23 13:13, Michael Schmitz wrote:
> Version 6 of the pata_falcon bugfix patch for Q40 support,
> addressing the latest comments by Geert and Damien.
> 
> No logic changes from v5 which was tested by William.

Applied to fo-6.6. Thanks !

> 
> Cheers,
> 
>    Michael
> 
> 

-- 
Damien Le Moal
Western Digital Research

