From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Port Multiplier Patch 2.6.22.1 on Alpha
Date: Thu, 30 Aug 2007 00:07:44 -0400
Message-ID: <46D64290.2010306@garzik.org>
References: <46D638A3.2030704@23palmer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45423 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751030AbXH3EHs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Aug 2007 00:07:48 -0400
In-Reply-To: <46D638A3.2030704@23palmer.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom Evans <tom@23palmer.net>
Cc: htejun@gmail.com, linux-ide@vger.kernel.org

Tom Evans wrote:
> Have you heard of such and issue with the 3124-2/4276 combination?
> Is anyone else trying this driver on an Alpha?

Alpha should not be operationally much different from other little 
endian 64-bit platforms.

The PCI swizzle might be weird (what is your Alpha platform?), is the 
only Alpha-specific thing that comes to mind.


> I have similar such behavior before when using drivers that generate 
> many unaligned accesses - I only have seen 2 places they occur in 
> sata_sil24 and have fixed them myself, but that made no difference.

We definitely want to fix all these you find.  Please post more info...

Also, if you are highly motivated, I would love to see if other SATA 
cards have similar problems on Alpha...

	Jeff



