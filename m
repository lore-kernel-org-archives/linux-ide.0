Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C3BEE7FF4
	for <linux-ide@archiver.kernel.org>; Mon, 11 Sep 2023 06:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjIKGMl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 11 Sep 2023 02:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbjIKGMk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Sep 2023 02:12:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F2411F
        for <linux-ide@vger.kernel.org>; Sun, 10 Sep 2023 23:12:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677A1C433C7;
        Mon, 11 Sep 2023 06:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694412754;
        bh=d0bX68z5EeOGvgA8sIRuK6ti+F6IWeOcQ4nWR8wVUyA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jlVJk5JVUQZ5N0/YW/tB4aFo26K99zkYtOG7XWecBNGqtd8HdX+XhnhhOgDX4Ubqx
         X/oAubzIw6S/rzzRXtw3QDW0AbMb5f8L3f/FgS5aWGc0uaYyEk+SRwtKgsmSRQClDT
         3wth9eVzULMqB2PVYT5RA+T1PBzNTjzmR7ZwRqHE7m1Lyw4Nj7QGCtI1m5GnMDouxy
         dLk410I/CaB2iJIqKrz26yH6wgi5UmgvC0AvPJ6m89W6RfdPu7XXkVxQPSHrAur7DB
         kJ5Ijg5TFnhdD6tCOJN5kG5dXA3ehNc0MCJzKN/dMztZ+LZOEceS1oAYYJveHw+NZd
         XGklY9aHPikUg==
Message-ID: <f4b2b1e2-5148-169a-0581-bb1a0d56f896@kernel.org>
Date:   Mon, 11 Sep 2023 15:12:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ata: libata: disallow dev-initiated LPM transitions to
 unsupported states
To:     Niklas Cassel <nks@flawful.org>
Cc:     Runa Guo-oc <RunaGuo-oc@zhaoxin.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        linux-ide@vger.kernel.org
References: <20230904204257.3296685-1-nks@flawful.org>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230904204257.3296685-1-nks@flawful.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/5/23 05:42, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> In AHCI 1.3.1, the register description for CAP.SSC:
> "When cleared to ‘0’, software must not allow the HBA to initiate
> transitions to the Slumber state via agressive link power management nor
> the PxCMD.ICC field in each port, and the PxSCTL.IPM field in each port
> must be programmed to disallow device initiated Slumber requests."
> 
> In AHCI 1.3.1, the register description for CAP.PSC:
> "When cleared to ‘0’, software must not allow the HBA to initiate
> transitions to the Partial state via agressive link power management nor
> the PxCMD.ICC field in each port, and the PxSCTL.IPM field in each port
> must be programmed to disallow device initiated Partial requests."
> 
> Ensure that we always set the corresponding bits in PxSCTL.IPM, such that
> a device is not allowed to initiate transitions to power states which are
> unsupported by the HBA.
> 
> DevSleep is always initiated by the HBA, however, for completeness, set the
> corresponding bit in PxSCTL.IPM such that agressive link power management
> cannot transition to DevSleep if DevSleep is not supported.
> 
> sata_link_scr_lpm() is used by libahci, ata_piix and libata-pmp.
> However, only libahci has the ability to read the CAP/CAP2 register to see
> if these features are supported. Therefore, in order to not introduce any
> regressions on ata_piix or libata-pmp, create flags that indicate that the
> respective feature is NOT supported. This way, the behavior for ata_piix
> and libata-pmp should remain unchanged.
> 
> This change is based on a patch originally submitted by Runa Guo-oc.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>

Applied to for-6.6-fixes. Thanks !


-- 
Damien Le Moal
Western Digital Research

