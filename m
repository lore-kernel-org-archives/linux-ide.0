Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B633C4332F
	for <linux-ide@archiver.kernel.org>; Thu,  8 Dec 2022 21:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiLHV0Z (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 8 Dec 2022 16:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLHV0Y (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 8 Dec 2022 16:26:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E63786AD
        for <linux-ide@vger.kernel.org>; Thu,  8 Dec 2022 13:26:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2529B8263F
        for <linux-ide@vger.kernel.org>; Thu,  8 Dec 2022 21:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEFCC433EF;
        Thu,  8 Dec 2022 21:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670534779;
        bh=pA17v1+QRC2YNg4V6+riMyxf5LM+FJLXdqz+PTlbqA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=afiDU+djCQQIt1gtBhePEuhLA1wQaVuMsRn9yBajOUYdowYX8HPqiXvWT3DQj64+/
         NizkyVJgofe4O+XXcSpLg8a9C8BjRMv6oaCGnwx0UlQMoqJA+UdXdEctwk838kfajF
         PV7KQaS/c+vxkAWThgXv8U3EHG0q4ct3l4s3CCVcEVmP+WHCyt7jJpQ6AYk9/bnBKO
         ukd36qNCHP6M20BIIG9A1mXN0OBZmMiKH9nIdTuTdPj30+wiMo2cTxTp1NPiSAqfo5
         kfNytHeBWMCNb8y1HwTgm5ZlvBvzS8un6Le14GFDLJ0aaZ9U0ojrVdNYZLqbNeC4PI
         2OePoX3FONbAw==
Received: by pali.im (Postfix)
        id 4FFEC97E; Thu,  8 Dec 2022 22:26:16 +0100 (CET)
Date:   Thu, 8 Dec 2022 22:26:16 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     marius@psihoexpert.ro, linux-ide@vger.kernel.org
Subject: Re: Bug report for ahci-mvebu driver
Message-ID: <20221208212616.ghplickz23h3iv3y@pali>
References: <ABCCF36A7F484055A8E63A8B739DC7B8@graph>
 <3c94c10243fa1cd2b0128db846298a11@psihoexpert.ro>
 <13f7138c46c4c486a29322baa4cc414b@psihoexpert.ro>
 <40f4ae2000164863253c67d405e4f875@psihoexpert.ro>
 <29aff79be06b7dacb97c13cbff07fabb@psihoexpert.ro>
 <97af1ef9ed605800e6ad43b7b3518800@psihoexpert.ro>
 <aa61bc53-34e2-4f19-962f-888e9daabbb4@opensource.wdc.com>
 <C9DCFF5E79814EAB9E9BE94B81A1CD7F@graph>
 <889ee9c9e77106b17ceac456e327d480@psihoexpert.ro>
 <c403c1dd-6478-09a3-f8b4-98026eb16c99@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c403c1dd-6478-09a3-f8b4-98026eb16c99@opensource.wdc.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tuesday 06 December 2022 15:08:33 Damien Le Moal wrote:
> This essentially disables the use of ahci_mvebu_stop_engine() function for
> your adapter, that is, it assumes that your newer adapter is not subject
> to errata Ref#226.

Just to make it clear, errata Ref#226 is for Armada 3720. Armada 385 is
32-bit and is _older_ product than 64-bit Armada 3720. Marvell naming
convention is... well unintuitive.

In my opinion Marvell tried to fix A385 errata Ref#FE-8889968 in its new
A3720 product but broke something different which introduced a new HW
errata Ref#226.
