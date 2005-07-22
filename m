From: "Roger Heflin" <rheflin@atipa.com>
Subject: RE: Silicon Image 3114 and Seagate disks
Date: Fri, 22 Jul 2005 08:42:04 -0500
Message-ID: <EXCHG2003pDS7hx27kB00000473@EXCHG2003.microtech-ks.com>
References: <20050722115501.GA15870@cs.ualberta.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host27-37.discord.birch.net ([65.16.27.37]:307 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S262084AbVGVNjV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Jul 2005 09:39:21 -0400
In-Reply-To: <20050722115501.GA15870@cs.ualberta.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Steve Sutphen' <steve@cs.ualberta.ca>, 'Jeff Garzik' <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

 
Hi Steve,

I saw the same thing with a tyan mb and a different Seagate disk,
removing from the blacklist sped things up a lot, and fixed some
bad kernel response issues (bad response was only with SMP,
not with single cpu).     I send an email about it several
weeks ago to this list detailing what I found.

                    Roger 

> -----Original Message-----
> From: linux-ide-owner@vger.kernel.org 
> [mailto:linux-ide-owner@vger.kernel.org] On Behalf Of Steve Sutphen
> Sent: Friday, July 22, 2005 6:55 AM
> To: Jeff Garzik
> Cc: linux-ide@vger.kernel.org
> Subject: Silicon Image 3114 and Seagate disks
> 
> 
> I have a system with a Tyan S2882 mother board that has a 
> Silicon Image
> Si3114 SATA controller that I would like to use one of the 
> "blacklisted"
> Seagate drives on.  As has been discussed in this mailing 
> list, when one uses the current driver performance is poor on 
> this combination (I see around 14MB/s using hdparm's buffered 
> read test--Bonnie++ confirms that).  
> 
> I was hunting around to see if there might be a better 
> driver, and came across this note in the Release notes for the:
> 
> SiI SATARaid Linux device driver ver 1.0.0.20 Release
> 
> Both the Tyan support download driver and the one from 
> SiliconImage have the following "Limitation" listed:
> 
> 3. Mod15Write fix for Seagate Drives (for chip-set versions 
> 3112 1.21 or older)
> 
> It seems that this driver may treat the 3114 and the 3112 the 
> same way, and that at least in the 3112 code the Seagate 
> problem may not exist on newer versions of the SI chip.  
> Lspci thinks that I have a Rev.2 chip/firmware:
> 04:05.0 Unknown mass storage controller: Silicon Image, Inc. 
> SiI 3114 [SATALink/SATARaid] Serial ATA Controller (rev 02)
> 
> The SI firmware version that my SI chip is running is 5.0.48.
> 
> My question is--is it possible that my ST3120026AS Seagate 
> drive might work without the "blacklisting"?  Should I try 
> it?  If so, what is a good test--will it lock up, or corrupt data?
> 
> If not with the current driver, then is there a new driver 
> that is coming down the pipe that will fix this in the 
> reasonably near term?
> 
> Thank you,
> 	steve@cs.ualberta.ca
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-ide" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> 

