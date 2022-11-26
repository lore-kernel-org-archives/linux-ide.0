Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C03FC4321E
	for <linux-ide@archiver.kernel.org>; Sat, 26 Nov 2022 14:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiKZO1D (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 26 Nov 2022 09:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiKZO06 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 26 Nov 2022 09:26:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CE918E1F
        for <linux-ide@vger.kernel.org>; Sat, 26 Nov 2022 06:26:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3127604AD
        for <linux-ide@vger.kernel.org>; Sat, 26 Nov 2022 14:26:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFE7C433C1;
        Sat, 26 Nov 2022 14:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669472817;
        bh=zT2TGf0/VwVQ5gq9C2oz/vy1cdaH9LNK+6BZxFvxXTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZgZgY7KJH/WqwQVKa21Ul4UXTpp5lsOFNODsGCOKOmzVxdufEuPWXG9Bxy3yKRxzm
         4dPJFx0EpP6rO18VnJPO9VXV3caiVMq2d7yLpxHSaKxmYx3yVAwgpyQDAcHEbki0Xy
         jks7AefBvrkQr5LlQD3FtIpkDnIOSNFc2+8WTcMRhYG+rca9qyWF41XH9PxoiNoXNy
         VT798OZNaiwUEFH1gPl4pcaRJCi0OeIEg3NiafPxcCstK1LJ9E/WBnHa+SToOpoQxi
         aRljOTsVsAbGUpphT2ni+0g3lfCG98A1dKKhUrZd2b78MvWhi0/GGDgoxQLAysF4dd
         Nza8icVA23xvg==
Received: by pali.im (Postfix)
        id 214BF7B2; Sat, 26 Nov 2022 15:26:54 +0100 (CET)
Date:   Sat, 26 Nov 2022 15:26:53 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Dinu Marius <marius@psihoexpert.ro>
Cc:     damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org
Subject: Re: Bug report for ahci-mvebu driver
Message-ID: <20221126142653.j2y42a77hnd7e6ha@pali>
References: <ABCCF36A7F484055A8E63A8B739DC7B8@graph>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ABCCF36A7F484055A8E63A8B739DC7B8@graph>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tuesday 01 November 2022 21:21:37 Dinu Marius wrote:
> Hello.
> 
> I'm contacting you because your email is listed in www.kernel.org/doc/linux/MAINTAINERS
> I encountered a problem with the ahci-mvebu driver. I think it's a bug.
> 
> Hardware:
> Areca ARC-5040 RAID enclosure (DAS), eSATA port, 8 SATA drive bays with 1x 500GB HDD stand-alone and 7x 2TB HDDs in RAID5.
> Linksys WRT-1900ACS v2 router, Marvell Armada 385 (88F6820), one eSATAp using ahci-mvebu driver with port-multiplier support.
> The router runs OpenWrt with kernel version 5.15.
> 
> Problem encountered:
> Areca DAS is not detected properly. When I connect it, I get these repeating errors in kernel log:

Hello! Sorry for jumping into this discussion but I think it could be
useful for you to know that Armada 38x and 39x SoCs have HW errata
related to their SATA PHYs and SATA port replicators. Due to the wrong
Busy status returned, the GEN 1.0 Port Multiplier cannot establish a
link with the SATA 3.0 interface. As a workaround connect GEN 1.0 Port
Multiplier to a SATA 2.0 interface. Native A38x/A39x SATA IP is
controlled by ahci-mvebu linux kernel. I do not have any other details
if broken is SerDes / PHY block in that SoC or SATA block. But error
"cannot establish a link" may be related to that documented A38x/A39x
SATA HW errata. Note that older Marvell SoCs (Armada 375, 370) have also
some different SATA HW erratas related to link establishment, so in my
opinion there could be some common undocumented root cause with SATA in
all those 32-bit Marvell SoCs, as lot of HW blocks are shared, and not
only related to port replicators. I have never played/debugged SATA
issues on A38x but I observed similar issues with PCIe on A38x. And due
to nature of Common PHY HW blocks implementing same SerDes interface for
both PCIe and SATA PHYs on those SoCs, I would not be surprised if PHY
issues could be present on both PCIe and SATA functions.
