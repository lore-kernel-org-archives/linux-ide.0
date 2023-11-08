Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B446C4332F
	for <linux-ide@archiver.kernel.org>; Wed,  8 Nov 2023 01:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbjKHBLm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 7 Nov 2023 20:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjKHBLm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 7 Nov 2023 20:11:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEBC120
        for <linux-ide@vger.kernel.org>; Tue,  7 Nov 2023 17:11:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B297C433C7;
        Wed,  8 Nov 2023 01:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699405899;
        bh=86meF/+FTaOtDyg5eU8jAXB4g7Sr2SRGd4Dck6SZpnk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=G/d2G0akycYsAYTNdoWrfiGhEVKgKuLZw4qnYII6wTZTViPOLO2f6arK+6q+YPZsX
         a5IKQlIe9gVcAYIfRLS5OZ9jtyEv4JvpqKAp72YuNHk/fzSCCz/MjDHSOAU+XI+Fyr
         PLmM9sH4CsmGXvQTIAdivQCv4zk9W0JIpiLuHeMsfm3yzMT6b8DU5jz+htqcC3bYSA
         epsvXkKoObusPLWA3EKgp29RK4QcIpvtu7j8uf6T7QIPJWCrnkcs35F/Qhi4+XU9a9
         voxizTpZS/Ji+Tl1VRwo4cghP3SRETnp5DupnGauvt8AsEINKrrQ51dXjrXW9pLBKj
         tN55fVTRUHP9Q==
Message-ID: <64d1081d-7a95-44dd-97c5-c861409a1c4b@kernel.org>
Date:   Wed, 8 Nov 2023 10:11:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Fix ata_pci_shutdown_one()
Content-Language: en-US
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <20231106041658.85522-1-dlemoal@kernel.org>
 <07854fac-f626-785f-2af6-41d85ce53c39@omp.ru>
 <2350d653-24cb-4199-a000-ac3ce151cc3a@kernel.org>
 <ZUoMJ0eSxh7eXnzt@x1-carbon>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZUoMJ0eSxh7eXnzt@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/7/23 19:06, Niklas Cassel wrote:
> Personally, I think I prefer having the full SHA1 as the first line,
> as you directly see that it is a revert (without needing the read to
> the end).
> 
> But I think it is fine either way:
> Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>

I tweaked the commit message to keep the full commit ID, making clear it is a
"git revert". Thanks.

-- 
Damien Le Moal
Western Digital Research

