From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC] IDE/ATA/SATA controller hotplug
Date: Tue, 27 Jul 2004 11:31:15 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41067543.3090003@pobox.com>
References: <200407191947.i6JJldK1024910@falcon10.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42881 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266427AbUG0Pbd
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Jul 2004 11:31:33 -0400
In-Reply-To: <200407191947.i6JJldK1024910@falcon10.austin.ibm.com>
List-Id: linux-ide@vger.kernel.org
To: Doug Maxey <dwm@austin.ibm.com>
Cc: Linux IDE Mailing List <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Doug Maxey wrote:
> Howdy!
> 
>   This note went out originally to a semi-internal list, but after
>   several comments, posting it here...
> 
>   As we chug along here in PPC64 land, we (meaning IBM internal) have
>   been given a requirement to make all devices on our new DLPAR
>   (POWER5 and later) systems be hotplug capable.  This includes ALL
>   PCI devices on the system, even those that are soldered on the
>   motherboard.
> 
>   This raises some interesting issues when dealing with IDE devices.
> 
>   I realize there is considerable work under way (hi Bart :) to clean
>   up the 2.6 trees.  This hotplug work would be another delta on top
>   of that work.
>   The changes could also possibly affect the libata work, as that
>   could also be touched by work on the attached devices themselves.

Why do you think libata is not already hotplug capable, WRT controllers?


>   What I would like is input on the general strategy that should be
>   taken to modify the controller/adapter and device stack to:
> 
>   1) be first class modules, where all controllers/adapters are
>      capable of being loaded and unloaded.  This is directed mostly at
>      IDE/Southbridge controller/adapter devices.

this is already the case in IDE and libata


>   2) extend that support to all child devices; disk, optical,
>      and tape.

this is already the case in IDE and SCSI


>   3) be part of mainline.

this is already the case


>   The items I perceive at the top of the issue list are:
> 
>   - The primary platforms for IDE/ATA devices are x86 based, and
>     certainly do not care about having this capability.

incorrect


>   - Assuming the capability is added, what rework would be acceptable
>     for block devices?

none


>   - Where should this capability go?  Fork a subset of IDE
>     controllers, and put them under the arch specific dir?
>     Or include all devices?

there is nothing arch-specific about this


>   - should we work to the goal of having the capability for all
>     platforms, and all IDE devices?

of course

	Jeff


