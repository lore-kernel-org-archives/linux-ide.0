From: Ric Wheeler <ric@emc.com>
Subject: error handling - DMA to PIO step down sequence
Date: Wed, 20 Sep 2006 15:03:27 -0400
Message-ID: <4511907F.1010104@emc.com>
Reply-To: ric@emc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([128.222.32.20]:54895 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S932267AbWITTFo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Sep 2006 15:05:44 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Mark Lord <mlord@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Now that Tejun has put in the enhanced error handling (which is a big 
jump forward), I have been trying to test and validate the code and the 
assumptions.

Having spent far too much time on planes recently, broken only by 
spending the other part of my time helping do root cause failure 
analysis of drives, I have been questioning the validity of the way we 
currently derate our p-ata and s-ata connected drives from DMA to slower 
DMA to PIO and then spiral on down.

All of this is a long winded way of asking if this step down is ever 
valid for either S-ATA (or even modern P-ATA) drives.

 From what I see and what I hear from the way my colleagues handle drive 
errors in non-linux code, this seems to be very aggressive and most 
likely not justified with modern drives and hba's.

Derating should probably never happen on normal drive errors - even 
those that might take 10's of seconds.  Often, drives will try really, 
really hard to recover and might eventually respond after internally 
giving up after up to 30 seconds.

Also, NACK's from unsupported commands or any type of media errors 
should not kick off this sequence.

Would this be a reasonable thing for a config option? Better to add yet 
another blacklist for devices that might have a justified need for this 
derating?




