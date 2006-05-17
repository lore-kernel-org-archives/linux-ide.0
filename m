From: John Rowe <rowe@excc.ex.ac.uk>
Subject: Warm swap?
Date: Wed, 17 May 2006 11:11:03 +0100
Message-ID: <1147860663.4547.122.camel@kenny>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dot.ex.ac.uk ([144.173.6.11]:24762 "EHLO dot.ex.ac.uk")
	by vger.kernel.org with ESMTP id S1750772AbWEQKLF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 May 2006 06:11:05 -0400
Received: from phobos.ex.ac.uk ([144.173.228.5] helo=phobos)
	by dot.ex.ac.uk with esmtp (Exim 4.62/mail)
	id 1FgIzg-0003hv-8E
	for linux-ide@vger.kernel.org; Wed, 17 May 2006 11:11:04 +0100
Received: from kenny ([144.173.228.126])
	by phobos with esmtp (Exim 4.24)
	id 1FgIzg-00019h-5D
	for linux-ide@vger.kernel.org; Wed, 17 May 2006 11:11:04 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I played around with RAID1 removeable sata drives on a 2.6.9 kernel
recently (RH Enterprise clone) and basically found that hot-swap killed
the system but warm-swap (remove the disk from all md devices, then pull
it out) worked most of the time. But on one occasion the system froze
when I plugged the disk back in. 

What (if any) is the status of warm swap? I don't see it mentioned much
but in terms of its usefulness to a systems manager the difference
between cold-swap and warm-swap is huge, the difference between warm-
swap and hot-swap is tiny. I would MUCH rather have warm-swap now and
hot-swap later than both later if that were possible.

Thanks for all your work on libata.

John


