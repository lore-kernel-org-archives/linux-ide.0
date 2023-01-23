Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665C0C05027
	for <linux-ide@archiver.kernel.org>; Mon, 23 Jan 2023 09:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjAWJe0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 23 Jan 2023 04:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjAWJe0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jan 2023 04:34:26 -0500
X-Greylist: delayed 1407 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 01:34:25 PST
Received: from mx.bauer-kirch.de (mx.bauer-kirch.de [87.230.111.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C30515C8F
        for <linux-ide@vger.kernel.org>; Mon, 23 Jan 2023 01:34:25 -0800 (PST)
Received: by mail.bauer-kirch.de with ESMTPSA id 1pJsqu-000051-LB
        authenticated id <420001312>
        (TLS1.2:ECDHE_RSA_SECP256R1__AES_128_GCM:128); Mon, 23 Jan 2023 10:10:56 +0100
Message-ID: <70a4c391-925d-a4af-2e6e-793b75e5cd0b@noerenberg.de>
Date:   Mon, 23 Jan 2023 10:10:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Hajo Noerenberg <hajo-linux-ide@noerenberg.de>
Subject: Re: Bug report for ahci-mvebu driver
To:     linux-ide@vger.kernel.org
In-Reply-To: <ABCCF36A7F484055A8E63A8B739DC7B8@graph>
Cc:     damien.lemoal@opensource.wdc.com, marius@psihoexpert.ro,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

> The same router works perfectly when I connect a laptop HDD.
> The same DAS, including the same eSATA cable, works perfectly when connected to an older 
> Linksys WRT-1900AC v1 with Marvell Armada XP (MV78230), using sata-mv driver. 
> This is the kernel log from the older router:
> 

Sorry to interfering in from the side, but I have observed very similar behavior with a Marvel 88SE6121 controller (AHCI kernel module): Very old SATA-1 HDDs (mostly laptop HDDs in my tests) work flawlessly, SATA-2/3 HDDs consistently fail. Limiting SATA speed (libata.force=1.5G ...) does not help.

Interestingly, SATA-2/3 HDDs do work with U-Boot and 'ancient' 3.x kernels. There was a suspicion that it was the PCI subsystem (the change in kernel 3.16 from kirkwood/pci.c to mvebu-pci). Pali Rohár did a great job to investigate this problem very persistently, but in the end we did not find a solution.

Without knowing anything about this area, there was the assumption that the problem must be at one of the lower levels close to the hardware.

You can find all the details and a lot of protocols in Bug https://bugzilla.kernel.org/show_bug.cgi?id=216094

I've been trying to revive my NAS440 for over 10 years with all the components (https://github.com/hn/seagate-blackarmor-nas), so I have the hardware available and am happy to persevere to try things or otherwise help.

Hajo

