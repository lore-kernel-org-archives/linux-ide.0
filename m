From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/4] libata sata_qstor fix oops on rmmod
Date: Thu, 08 Nov 2007 11:30:45 +0900
Message-ID: <473274D5.9030705@gmail.com>
References: <4731DF06.3050202@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:26113 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753241AbXKHCay (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Nov 2007 21:30:54 -0500
Received: by rv-out-0910.google.com with SMTP id k20so18950rvb
        for <linux-ide@vger.kernel.org>; Wed, 07 Nov 2007 18:30:53 -0800 (PST)
In-Reply-To: <4731DF06.3050202@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> sata_qstor fix oops on rmmod.
> 
> sata_qstor likes to disable the chip on module unload,
> so it provides a libata "host_stop" method to do this.
> But in recent kernels, this routine is now called too late,
> after the PCI mmio resources have already been released.
> Which produces an oops.
> 
> This really needs to be fixed higher up.
> For an interim workaround, we disable this function for now.

Ah.. you're right.  port and host stop should be called before any host
resource is torn down.  I'll submit a patch soon.  Thanks.

-- 
tejun
