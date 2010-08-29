From: amruth pattanada <amruth.vamadev@gmail.com>
Subject: silicon image 3114 DMA polling
Date: Sun, 29 Aug 2010 10:44:02 +0530
Message-ID: <AANLkTikvUF7dk2z6Sd-uD8zXxd-Bm-K9gx2=mSKwq4Fx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41319 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860Ab0H2FOE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Aug 2010 01:14:04 -0400
Received: by iwn5 with SMTP id 5so3860113iwn.19
        for <linux-ide@vger.kernel.org>; Sat, 28 Aug 2010 22:14:02 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi
I am currently using 2.6.35.3 linux kernel for porting silicon image
3114 driver to new hardware. I see that the current code uses
interrupt  to check for dma complete. I don't have any interrupt
mechanism in the current framework. Do we have any other mechanism to
check whether DMA is complete via polling. I also see that after
issuing Read DMA command, 0x52 is returned as command status and
according to ATA spec bit 1 set is NA. Is there any mandatory
requirement that DRQ bit needs to be enabled(0x58) before starting DMA
operation.
Any inputs will be appreciated.
Thanks
Amruth p.v
