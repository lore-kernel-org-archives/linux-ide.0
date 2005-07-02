From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata and hotplug status
Date: Sat, 02 Jul 2005 11:24:00 +0900
Message-ID: <42C5FAC0.6070608@gmail.com>
References: <4789af9e050628135547fa5e14@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.197]:16932 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261678AbVGBCYH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Jul 2005 22:24:07 -0400
Received: by rproxy.gmail.com with SMTP id i8so329786rne
        for <linux-ide@vger.kernel.org>; Fri, 01 Jul 2005 19:24:06 -0700 (PDT)
In-Reply-To: <4789af9e050628135547fa5e14@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Ramsay <jim.ramsay@gmail.com>, Jeff Garzik <jgarzik@pobox.com>
Cc: Linux-ide <linux-ide@vger.kernel.org>

Jim Ramsay wrote:
> I read at http://linux.yyz.us/sata/software-status.html that "libata
> does not support hotplug... yet", implying that it eventually would.
> 
> I am very interested in the current state and progress of SATA hotplug
> support for libata-based drivers (specifically the 'sata_promise'
> driver for the Promise TX4 card).  Has there been any preliminary work
> or discussion on this feature?
> 
> How would it best be implemented?  How much of a pain would it be to
> do?  Are there any half-baked patches out there I can take a peek at
> or help with?  Who can I prod to bump this up on the priority list for
> libata?  What should I prod with?
> 

  Hi, Jim.
  Hi, Jeff.

  First of all, AFAIK, there's no previous work in implementing SATA 
hotplug.  I used to be pretty interested in implementing hot-plug for 
libata.  The problems are...

  * libata runs under SCSI emulation, yet it tries to remain separate 
from SCSI midlayer as much as possible (maybe for possible departure 
from SCSI emulation someday).  So, the probing procedure is done inside 
libata layer when attaching a HBA and later SCSI discover commands are 
just simulated making using SCSI midlayer's hot-plug support a little 
bit difficult.

  * SCSI midlayer's hotplug support is pretty brittle.  The device state 
model/host state model are broken in several aspects.  (eg. multiple 
entities may attempt to change a device's state but there's no 
synchronization.  You can mess it up pretty easily.)  Also, there's no 
generic hot-plug helpers in the SCSI midlayer which each specific 
drivers can use with ease.

  Well, I tried to fix SCSI midlayer and implement new device state 
model but my patches haven't made it into SCSI devel tree (haven't given 
up yet ;-), and I'm not really sure how Jeff thinks about changing SATA 
probing such that it's more integrated with/tied to SCSI midlayer. 
Maybe it's possible to implement hot plugging w/o strictly following 
SCSI midlayer's probing model but, IMHO, it's gonna be messy.

  Jeff, what do you think about this?

-- 
tejun
