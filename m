From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] RESEND: libata: check cdb len per dev instead of per
 host
Date: Fri, 02 Mar 2007 19:26:33 -0500
Message-ID: <45E8C0B9.4050402@garzik.org>
References: <45C37699.7000306@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55112 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992796AbXCCA0f (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Mar 2007 19:26:35 -0500
In-Reply-To: <45C37699.7000306@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Mark Lord wrote:
> Resending, with s/printk/DPRINTK/ as pointed out by Alan.
> 
> Fix libata to perform CDB len validation per device
> rather than per host.  This way, validation still works
> when we have a mix of 12-byte and 16-byte devices on
> a common host interface.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>

applied, though I am disappointed that we had to add this check (as well 
as another one in an unrelated Tejun patch) to the fast path


