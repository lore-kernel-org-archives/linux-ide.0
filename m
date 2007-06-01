From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.22 libata spindown
Date: Fri, 01 Jun 2007 16:39:57 -0400
Message-ID: <4660841D.5050003@garzik.org>
References: <4ac8254d0706011314g5468f02m3cf5a5281bd30018@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55739 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762503AbXFAUj7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Jun 2007 16:39:59 -0400
In-Reply-To: <4ac8254d0706011314g5468f02m3cf5a5281bd30018@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Cc: linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Tuncer Ayaz wrote:
> I'm still seeing the libata warning that disks were not spun down
> properly on the following two setups and am wondering whether I need
> a new shutdown binary or the changeset mentioned below is not meant
> to fix what I'm triggering by halt'ing.
> 
> If it's not a bug I will try to update my shutdown utility and if
> that does not work I promise not to bother lkml about a problem
> caused by my userland. If it is a bug I hope it will be of interest
> for 2.6.22 bug tracking.
> 
> Setup 1:
> SATA 1 Disks
> AMD64 3200+
> nVidia nForce 3 250 (Ultra?)
> Debian i386 Unstable
> 
> Setup 2:
> SATA 2 disks
> Core 2 Duo E6600
> Intel 975X
> Debian x86_64 Unstable
> 
> Just to be clear what warning I'm talking about:
> DISK MIGHT NOT BE SPUN DOWN PROPERLY. UPDATE SHUTDOWN UTILITY
> For more info, visit http://linux-ata.org/shutdown.html


IIRC, Debian was the one OS that really did need a shutdown utility 
update, as the message says :)

	Jeff


