From: Todd and Margo Chester <ToddAndMargo@verizon.net>
Subject: Re: no hotplugging support (FIXME)
Date: Sat, 21 Feb 2009 20:40:47 -0800
Message-ID: <49A0D74F.1010009@verizon.net>
References: <Pine.LNX.4.10.10301040547120.421-100000@master.linux-ide.org>
 <499F171D.5020600@verizon.net> <499F52C8.90205@gmail.com>
 <49A0B1D8.10303@verizon.net> <49A0C8F5.30405@gmail.com>
 <49A0CFFF.3050806@verizon.net> <49A0D167.9060707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:47678 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655AbZBVElG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Feb 2009 23:41:06 -0500
Received: from rn1.rent-a-nerd.local ([71.125.120.146])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KFG00JFIABZQLDG@vms173007.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Sat, 21 Feb 2009 22:40:48 -0600 (CST)
In-reply-to: <49A0D167.9060707@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

Robert Hancock wrote:
>> p.s., just of curiosity, what would the ACHI module look
>> like in my modprobe.conf?
> 
> You would change:
> 
> alias scsi_hostadapter2 ata_piix
> 
> to
> 
> alias scsi_hostadapter2 ahci
> 
Thank you!

Question: would that be in addition to or a substitute
for?  (I am concerned that my SATA DVD/CD burner would
stop working.)

Also, I downloaded the recent manual for my motherboard.
The section has a new option not on my BIOS (1.2a)
called "SATA ACHI Mode: on|off".  The current BIOS is
2.1a -- I think it is time I ordered a new BIOS chip
(I don't flash.  I remove and replace the chip.  That way
I can go back if things go wrong, which has happened to
me before.)

Many thanks,
-T
