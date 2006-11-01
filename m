From: Mark Lord <lkml@rtr.ca>
Subject: Re: AHCI should try to claim all AHCI controllers
Date: Wed, 01 Nov 2006 09:37:49 -0500
Message-ID: <4548B13D.6070501@rtr.ca>
References: <FFECF24D2A7F6D418B9511AF6F358602F2CE9E@shacnexch2.atitech.com>	 <45482BA7.6070904@pobox.com>	 <Pine.LNX.4.64.0610312120200.25218@g5.osdl.org> <1162383783.11965.116.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:23310 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S2992512AbWKAOhv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Nov 2006 09:37:51 -0500
In-Reply-To: <1162383783.11965.116.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>, Conke Hu <conke.hu@amd.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Alan Cox wrote:
> Ar Maw, 2006-10-31 am 21:22 -0800, ysgrifennodd Linus Torvalds:
>> (We had the same issue with "PCI IDE controller". Some PCI IDE controllers 
>> are clearly exactly that from a programming interface standpoint, but 
>> because they support RAID in hardware, they claim to be RAID controllers, 
>> since that is more "glamorous". Gaah ;^).
> 
> Actually its far uglier than that. With one exception they don't support
> hardware raid mode, they use the RAID class tag to stop other OS drivers
> grabbing the interface or seeing it directly as un-raided software raid.

Note that a lot of the software raid controllers actually have full
hardware RAID acceleration in the chipset (single block command is automatically
remapped across several drives of a RAID 0/1/10 configuration, reducing bus
transactions and bandwidth requirements.

But they still require a driver do perform the RAID management,
and are thus not true "hardware" RAID.  But they are higher on the
food chain than total "pretend" RAID devices.

Cheers
