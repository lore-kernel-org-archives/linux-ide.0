From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFT] libata hpa support
Date: Wed, 21 Mar 2007 14:03:47 -0400
Message-ID: <46017383.2000107@garzik.org>
References: <20070223170625.GA29931@athena.road.mcmartin.ca>	<20070321130140.GA4328@athena.road.mcmartin.ca>	<20070321183455.00f4732b@lxorguk.ukuu.org.uk>	<46016E58.5010509@garzik.org> <20070321185024.31673dd3@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46658 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750872AbXCUSDt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Mar 2007 14:03:49 -0400
In-Reply-To: <20070321185024.31673dd3@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kyle McMartin <kyle@canonical.com>, linux-ide@vger.kernel.org, mjg59@ubuntu.com

Alan Cox wrote:
>> That reminds me, there have been suggestions in the past that we should 
>> do a security freeze after probing and configuring.
> 
> And as has been observed previously from a security perspective there is
> no point.
> 
> 	Break into box
> 	security freeze - annoying
> 	Patch boot block to load my disk destroyer
> 	Reboot
> 
> You need to the security freeze in the firmware at boot, or it is the
> same whether you do it in kernel or in the initrd or early boot, except
> that its pagable code, its configurable and its easier to work with when
> it is in user space.
> 
> Paranoid people get PCI boot roms that lock their disks.

Certainly.

But I argue that doing it late is better than not doing it at all.

	Jeff



