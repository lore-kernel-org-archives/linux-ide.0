From: Peter Missel <peter.missel@onlinehome.de>
Subject: Re: [PATCH] ata.h: Don't do a SATA check for 40wire_relaxed
Date: Sat, 8 Dec 2007 15:55:01 +0100
Message-ID: <200712081555.01520.peter.missel@onlinehome.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:52270 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbXLHOzF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Dec 2007 09:55:05 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>, jeff@garzik.org, linux-ide@vger.kernel.org

Hi all!

As the originator of this patch, please let me comment.

Jeff Garzik wrote:
>Alan Cox wrote:
>> Without the valid bits at least one set of TSScorp drives report 0 in
>> word 93 for PATA 40 wire, which we (and the specs) say actually means
>> SATA. (The SATA version seems to report 80 wire...)
>> 
>> Signed-off-by: Alan Cox <alan@redhat.com>

>SATA version on what controller?  Have you verified where the bridge is, 
>if it's not reporting word93==0 ?

>Is this for 2.6.24-rc, considering that we are late in -rc?

The offending drives are native IDE, but their word93 is broken, in that the 
validation bits are missing. Hence, if connected to a 40-wire cable, they 
return word93=0x0000 and make themselves look like a SATA drive.

This makes the 'relaxed' cable check do the exact wrong thing - allow fast 
UDMA modes.

The patch discussed here corrects the 'relaxed' cable check, so that it 
actually does what it's supposed to - look at nothing but the cable type bit 
in word93 and exactly NOT draw any other conclusions from word93. 

Due the dangerous behaviour of the unpatched code, I strongly vote for 
inclusion in 2.6.24.

regards,
Peter
