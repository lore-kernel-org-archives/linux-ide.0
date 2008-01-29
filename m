From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 09/13] sata_mv ncq Use DMA memory pools for hardware memory
 tables
Date: Tue, 29 Jan 2008 12:10:55 -0500
Message-ID: <479F5E1F.8030508@pobox.com>
References: <479BC217.60709@rtr.ca> <479BC31D.1050206@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45468 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760192AbYA2RK5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Jan 2008 12:10:57 -0500
In-Reply-To: <479BC31D.1050206@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Create host-owned DMA memory pools, for use in allocating/freeing per-port
> command/response queues and SG tables.  This gives us a way to guarantee we
> meet the hardware address alignment requirements, and also reduces 
> memory that
> might otherwise be wasted on alignment gaps.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>

ACK patches 1-13

applied patches 1-9 to #upstream.  patch #10 failed, with git-am 
reporting it as a corrupt patch.


