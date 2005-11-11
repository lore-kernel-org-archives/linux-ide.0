From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Marvell MV88SX6041 SATA Driver PIO4 Mode Not DMA
Date: Fri, 11 Nov 2005 05:26:24 -0500
Message-ID: <437471D0.3090404@pobox.com>
References: <1131648518.26701.247242836@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:2183 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751270AbVKKK0r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Nov 2005 05:26:47 -0500
In-Reply-To: <1131648518.26701.247242836@webmail.messagingengine.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Spencer Tuttle <rodeojones@fastmail.fm>
Cc: linux-ide@vger.kernel.org

Spencer Tuttle wrote:
> I have just compiled the new 2.6.14 kernel from the gentoo-sources tree.
> 
> I can access the drives just fine, but it seems really slow.  Here is
> the dmesg output when I load the kernel module

That's expected, since the driver in 2.6.14 only does PIO mode.

Try 2.6.14-gitN which supports EDMA.

	Jeff



