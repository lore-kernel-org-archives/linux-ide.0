From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/5] sil24: use SRST for phy_reset
Date: Wed, 16 Nov 2005 10:03:34 -0500
Message-ID: <437B4A46.4070501@pobox.com>
References: <20051116080505.GC22807@htj.dyndns.org> <437B462F.80205@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:41140 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030357AbVKPPDl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Nov 2005 10:03:41 -0500
In-Reply-To: <437B462F.80205@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Tejun Heo wrote:
> 
>> There seems to be no way to obtain device signature from sil24 after
>> SATA phy reset and SRST is needed anyway for later port multiplier
>> suppport.  This patch converts sil24_phy_reset to use SRST instaed.
> 
> 
> Mmm.. I doubt that sil24 is the only SATA controller with
> this issue.  The sata_qstor device, for example, requires PHY reset
> *followed* by SRST if one wants to reliably detect a port multiplier.
> 
> Maybe the chipset drivers should simply do PHY / SRST as they're told,
> and have libata-core ensure PHY + SRST before doing PM detection?

Well, there is a hardware-dependent component, and a PM-dependent component.

Hardware:  some controller hardware cannot reliably provide the 
signature from the post-COMRESET D2H Register FIS to the OS driver, so 
an SRST is required in any case.

PM:  The SATA PM docs clearly state in two places, that SRST should be 
used to obtain the port multiplier signature, and from there proceed 
with probing.

Thus, if we take the docs at face value, it sounds like sata reset 
should look like

	take iface active (write 0x300 to scontrol)
	poll sstatus for device detection
	clear serror
	issue srst
	get signature
	do useful stuff with signature

That's also a bit nicer to the hardware too, for two reasons:
* COMRESET in general is a hard reset
* often, advanced host controllers issue COMRESET anyway, so we're 
likely doing it twice

Patches welcome ;-)  I am a bit nervous about making this change 
globally, since some early phys may need a COMRESET kick (0x301 to 
SControl)...  so maybe we could phase this in on the advanced 
controllers first (libata's API permits this), and then roll it out to 
the dumber controllers if nothing breaks.

	Jeff

