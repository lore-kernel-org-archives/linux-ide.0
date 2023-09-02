Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2256ACA0FF6
	for <linux-ide@archiver.kernel.org>; Sat,  2 Sep 2023 03:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjIBDJ6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 1 Sep 2023 23:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjIBDJ5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 1 Sep 2023 23:09:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A4410FF
        for <linux-ide@vger.kernel.org>; Fri,  1 Sep 2023 20:09:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE43FB826C3
        for <linux-ide@vger.kernel.org>; Sat,  2 Sep 2023 03:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6BBC433C8;
        Sat,  2 Sep 2023 03:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693624191;
        bh=i1PWj03a5yiyLSNJB03YBgjwficd9HTWzOZklfPNjVE=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=inDZf77mqyQYZSuPIF/f/Mss2qZ5HXH1dxtbf0xHKHAl2iZXrfpNWO8ZPWDBiGRr+
         UykTc1RDp6aKITdYlceFGOoSI8bzmQbtkiz0CSU+eHLZBSMhjfMPRn0h3AqC1a6lq/
         DPyNmvzuHAaJUcBEoifkxoxblqHlp8X3Me3z5Y6bZtnijBMtyzJsX6UKCKqHybR4X0
         JkG2iK6rPFCx3u9ahWDhB2eZfb6X5TeP1Tp4AoEzDaC26ajHzzqGgNu53YZnmPb0mP
         d98UuEwTf8NJz83mbUYsEL9Wm+OiphTTYWhilveD34RXiTKtABQYRoFOTezQz/9FLl
         lIZ51pC3uKvGQ==
Message-ID: <a8b37277-9c20-d9c2-5e9a-4374f9222cd0@kernel.org>
Date:   Sat, 2 Sep 2023 12:09:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] ata: ahci: Add Elkhart Lake AHCI controller
Content-Language: en-US
To:     Werner Fischer <devlists@wefi.net>, linux-ide@vger.kernel.org
References: <4cbde7d33f5b73b33f798b56b6e3cd3ce3764647.camel@wefi.net>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <4cbde7d33f5b73b33f798b56b6e3cd3ce3764647.camel@wefi.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/29/23 20:33, Werner Fischer wrote:
> Elkhart Lake is the successor of Apollo Lake and Gemini Lake. These
> CPUs and their PCHs are used in mobile and embedded environments.
> 
> With this patch I suggest that Elkhart Lake SATA controllers [1] should
> use the default LPM policy for mobile chipsets.
> The disadvantage of missing hot-plug support with this setting should
> not be an issue, as those CPUs are used in embedded environments and
> not in servers with hot-plug backplanes.
> 
> We discovered that the Elkhart Lake SATA controllers have been missing
> in ahci.c after a customer reported the throttling of his SATA SSD
> after a short period of higher I/O. We determined the high temperature
> of the SSD controller in idle mode as the root cause for that.
> 
> Depending on the used SSD, we have seen up to 1.8 Watt lower system
> idle power usage and up to 30°C lower SSD controller temperatures in
> our tests, when we set med_power_with_dipm manually. I have provided a
> table showing seven different SATA SSDs from ATP, Intel/Solidigm and
> Samsung [2].
> 
> Intel lists a total of 3 SATA controller IDs (4B60, 4B62, 4B63) in [1]
> for those mobile PCHs.
> This commit just adds 0x4b63 as I do not have test systems with 0x4b60
> and 0x4b62 SATA controllers.
> I have tested this patch with a system which uses 0x4b63 as SATA
> controller.
> 
> [1] https://sata-io.org/product/8803
> [2] https://www.thomas-krenn.com/en/wiki/SATA_Link_Power_Management#Example_LES_v4
> 
> Signed-off-by: Werner Fischer <devlists@wefi.net>
> Cc: stable@vger.kernel.org

Applied to for-6.6. Thanks !

Note: when sending patches, please also add the maintainer(s) to your email
"to:" list.

-- 
Damien Le Moal
Western Digital Research

