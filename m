From: Anton Starikov <antst@ifm.liu.se>
Subject: Re: new tool:  blktool
Date: Mon, 16 Aug 2004 00:22:45 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040816002245.3f73e75a@hantst.kabel.utwente.nl>
References: <411FD744.2090308@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from utep.el.utwente.nl ([130.89.16.10]:4574 "EHLO
	utep.el.utwente.nl") by vger.kernel.org with ESMTP id S267185AbUHOWWu
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Aug 2004 18:22:50 -0400
In-Reply-To: <411FD744.2090308@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hm..probably I'm stupid guy, but BTW I wont to ask stupid question which
I have already for a long time.

I use promise driver from libata. So, drive connected to promise
controller is /dev/sdX. hdparm doesn't want to manage parameters of a
such drive. I've checked blktool - the same result.
So, is it problem of driver (something not implemented yet) or I have to
use something different? 

Anton Starikov.

On Sun, 15 Aug 2004 17:36:04 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> 
> I just posted "blktool" on my SF page,
> 	http://sourceforge.net/projects/gkernel/
> and in BitKeeper at
> 	bk://gkernel.bkbits.net/blktool
> 
> 
> blktool aims to be an easier to use, and more generic version of the 
> existing utility 'hdparm'.  For example,
> 
> 	$ hdparm -c1 /dev/hda
> 		becomes
> 	$ blktool /dev/hda pio-data 32-bit
> 
> 	and
> 
> 	$ hdparm -L0 /dev/hda
> 		becomes
> 	$ blktool /dev/hda media unlock
> 
> The utility is currently still fairly specific to IDE devices (as
> hdparm is), but that will change in the coming weeks as SCSI, I2O, and
> possibly some bits of hardware RAID control are added.
> 
> The audience for this application, like hdparm, is fairly narrow, 
> specific to people who tweak their storage devices and _know what they
> are doing_.  Improper use of this tool, like hdparm, can turn your
> disk into a doorstop.
> 
> 	Jeff
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
