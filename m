From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
Date: Tue, 21 Mar 2006 21:12:03 -0500
Message-ID: <4420B273.9030405@garzik.org>
References: <441F4F95.4070203@garzik.org> <200603210000.36552.lkml@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:29628 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751878AbWCVCMF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Mar 2006 21:12:05 -0500
In-Reply-To: <200603210000.36552.lkml@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

Mark Lord wrote:
> This patch addresses a number of weird behaviours observed
> for the sata_mv driver, by fixing an "off by one" bug in processing
> of the EDMA response queue.
> 
> Basically, sata_mv was looking in the wrong place for
> command results, and this produced a lot of unpredictable behaviour.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>

applied


