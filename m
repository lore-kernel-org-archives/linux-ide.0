From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] amd74xx: don't configure udma mode higher than BIOS did
Date: Mon, 05 Feb 2007 21:16:18 +0900
Message-ID: <45C72012.7050605@gmail.com>
References: <20070205075836.GG1625@htj.dyndns.org> <20070205112410.5a3c3182@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.232]:19767 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932268AbXBEMQ1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 07:16:27 -0500
Received: by wr-out-0506.google.com with SMTP id i22so1204921wra
        for <linux-ide@vger.kernel.org>; Mon, 05 Feb 2007 04:16:26 -0800 (PST)
In-Reply-To: <20070205112410.5a3c3182@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

Alan wrote:
>> This patch makes amd74xx not configure udma mode higher than BIOS did.
>> If BIOS configured the device <= udma44, udma33 is the maximum speed.
> 
> NAK
> 
> The boot firmware for AMD/Nvidia chips is only run on PC, and the data is
> only valid on some of them, in some cases, and not after a suspend/resume
> cycle. You cannot rely on the BIOS (if any) loaded register values. Since
> you've posted patches to clean up the drive side detect (when tweaked
> with a couple of fixes), this hack won't be neccessary.

If BIOS hasn't run, UDMA timing wouldn't have been programmed and as
such the speed won't be limited.  So, there should be no harm done in
that case.  Even if something goes really wrong, the worst happens is
capping speed to udma33.

The reason why I posted both drive side wire detection and this was that
both are often wrong on my test machine.  It's one of the popular NF4
boards from ASUS, probably one of the most sold.  I've tested with one
fairly recent samsung drive and two old drives from maxtor and wd.  All
of them support > udma33.  In many valid configurations using 40c, both
the host and drive reported 80c (I verified register values multiple
times) and configured accordingly by both pata_amd and amd74xx and then
of course cause a lot of transfer errors.

In all those cases, BIOS configured transfer mode correctly.  So,
without this patch, amd74xx will drop out of dma mode as soon as it gets
detected in many configurations.

So, I think the benefit (correct configuration on most machines) easily
outweighs the danger (incorrectly capping speed to working udma33 on
non-PC).

-- 
tejun
