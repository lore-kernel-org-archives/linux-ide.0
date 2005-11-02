From: "Timothy Thelin" <Timothy.Thelin@wdc.com>
Subject: RE: [usb-storage] [Merging ATA passthru] on integrating SMART/ATA-Security in usb-storage driver
Date: Wed, 2 Nov 2005 12:33:09 -0800
Message-ID: <CA45571DE57E1C45BF3552118BA92C9D69BF37@WDSCEXBECL03.sc.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wdscexfe02.sc.wdc.com ([129.253.170.52]:28861 "EHLO
	wdscexfe02.sc.wdc.com") by vger.kernel.org with ESMTP
	id S965227AbVKBUdP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Nov 2005 15:33:15 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, thomas schorpp <t.schorpp@gmx.de>
Cc: usb-storage@lists.one-eyed-alien.net, linux-ide@vger.kernel.org


> They aren't ATA read/write commands; they are SCSI commands.  
> If there is 
> a version of SMART that runs over SCSI, you might be able to use it.
> 
> > and sata is short of smart support. both use scsi-emu(?).
> > 
> > i dont think theres a hardware problem.
> 
> Yes there is.  The USB interface on the drive won't recognize 
> an ATA SMART
> command and won't pass it on to the drive controller.
> 

To expand on this, its really the USB device firmware which needs
the passthru mechanism implmented, since (as stated) it expects
to be getting scsi commands.  Now there are many vendor specific
ways to embed ATA commands inside of scsi cdbs, and then there are
two public methods that I'm aware of: SAT and the At2lp (cypress
bridge board, docs on their website).

And to send these commands, user-space already has SG_IO.

So I'm not sure usb-storage can do much, since it can't force a usb
device to accept passthru cdbs, and SG_IO already allows cdbs
to be sent to usb devices.

Regards,
Tim Thelin
