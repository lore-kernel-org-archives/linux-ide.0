Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF7CEE57DF
	for <linux-ide@archiver.kernel.org>; Mon, 11 Sep 2023 06:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjIKG1O (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 11 Sep 2023 02:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjIKG1O (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Sep 2023 02:27:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D940EC
        for <linux-ide@vger.kernel.org>; Sun, 10 Sep 2023 23:27:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5133EC433C8;
        Mon, 11 Sep 2023 06:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694413629;
        bh=xZiOoxVpkbuEAvqVOqky+geLerxYaZdf9+yFVS+nBdA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hvDhjcoBEvGk0RaJntrHa3Q9+m52irD/aSSDIpZJoru/2AwEToGLUp6F0sT5qbpvE
         ZVdjuyFwn4YsJ6a9McrTh3lFjyJLCQaCffQ+wtGVtCCOxKyn/Vfb5rQL8BVAp6tvn5
         G8QVzWUQPXs7YdT/aimTLgchmLdNBmjmVH4AZ1HG0VQVlwQuOsQi/5sKyUVVALtKDB
         cqApRWcjFD0qm3QebkvyJXtFPNRsqypPEkxltzeGrKsF/+uPvKjq0t3DlGRKZB09he
         qt8Xfei7MhIS5T2YxGj9EiqRUVXtxOAcKXMD6f6hBpxEyomd4WuD5DUU5iwQ6Kokm9
         Z/i453X10t7NA==
Message-ID: <955fa865-894e-01bd-ea95-36ece6042528@kernel.org>
Date:   Mon, 11 Sep 2023 15:27:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] ata: ahci: print the lpm policy on boot
Content-Language: en-US
To:     Niklas Cassel <nks@flawful.org>
Cc:     linux-ide@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>
References: <20230906092232.3396200-1-nks@flawful.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230906092232.3396200-1-nks@flawful.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/6/23 18:22, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> The target LPM policy can be set using either a Kconfig or a kernel module
> parameter.
> 
> However, if the board type is set to anything but board_ahci_low_power,
> then the LPM policy will overridden and set to ATA_LPM_UNKNOWN.
> 
> Additionally, if the default suspend is suspend to idle, depending on the
> hardware capabilities of the HBA, ahci_update_initial_lpm_policy() might
> override the LPM policy to either ATA_LPM_MIN_POWER_WITH_PARTIAL or
> ATA_LPM_MIN_POWER.
> 
> All this means that it is very hard to know which LPM policy a user will
> actually be using on a given system.
> 
> In order to make it easier to debug LPM related issues, print the LPM
> policy on boot.
> 
> One common LPM related issue is that the device fails to link up.
> Because of that, we cannot add this print to ata_dev_configure(), as that
> function is only called after a successful link up. Instead, add the info
> using ata_port_desc(), with the help of a new ata_port_desc_misc() helper.
> The port description is printed once per port during boot.
> 
> Before changes:
> ata1: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780100 irq 170
> ata2: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780180 irq 170
> 
> After changes:
> ata1: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780100 irq 170 lpm-pol 4
> ata2: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780180 irq 170 lpm-pol 4
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>

Applied to for-6.7. Thanks !


-- 
Damien Le Moal
Western Digital Research

