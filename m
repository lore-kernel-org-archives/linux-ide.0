From: "Andrew Chew" <achew@nvidia.com>
Subject: RE: [PATCH 2.6.8-rc2] sata_nv.c
Date: Tue, 27 Jul 2004 13:26:20 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B03F95F5@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate00.nvidia.com ([216.228.112.144]:37905 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S266613AbUG0U07 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Jul 2004 16:26:59 -0400
Content-class: urn:content-classes:message
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> 7) don't use host->scr_addr as a sly way to obtain your base address. 
> Use host_set->mmio_base directly (casting from unsigned long 
> if it's PIO 
> rather than MMIO).

I noticed in libata-core.c's ata_pci_remove_one(), that the
host_set->mmio_base gets unmapped before calling
host_set->ops->host_stop(host_set).  The problem is that I want to
access the registers mapped to host_set->mmio_base in my host_stop
routine (it's in my host_stop routine that I disable hotplug event
interrupts).

It looks safe to just swap the two calls, so we call
host_set->ops->host_stop(host_set) before we iounmap
host_set->mmio_base.  That way, my host_stop routine can still access
host_set->mmio_base.

However, I don't want to break any architectural model you may have in
mind.  Can you advise me on the proper approach I should take with this?
