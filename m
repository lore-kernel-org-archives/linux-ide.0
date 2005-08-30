From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Promise SATAII150 TX4: strange disk ordering
Date: Tue, 30 Aug 2005 00:44:35 -0400
Message-ID: <4313E433.1080602@pobox.com>
References: <430E4AB0.2060600@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:6596 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932123AbVH3Eom (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Aug 2005 00:44:42 -0400
In-Reply-To: <430E4AB0.2060600@eyal.emu.id.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: linux-ide@vger.kernel.org

Eyal Lebedinsky wrote:
> I needed a 4-port SATA controller and this was was picked. It seems
> to work OK, however I find that Linux (2.6.12.5 and .13-rc7) see
> the disks in a different order than the labelled sockets (which do
> match what the BIOS detection lists at bootup).
> 
> It is not even the reverse order:
> 	TX4 socket	sata_promise ata*
> 	1		4
> 	2		2
> 	3		1
> 	4		3
> This order looks stable - I connected a different number of disks
> on some ports and this ordering was maintained.

sata_promise driver just presents the devices in the order that the 
board maker has wired each port to the chip.  What may be labelled "port 
3" on the board might be wired to the chip's port-0.  sata_promise just 
presents what it is given.

	Jeff



