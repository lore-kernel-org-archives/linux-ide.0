From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/3] libata: flush is an IO command
Date: Tue, 30 Oct 2007 09:32:38 -0400
Message-ID: <47273276.3040204@garzik.org>
References: <20071026065359.GL11853@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46358 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751147AbXJ3Nck (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Oct 2007 09:32:40 -0400
In-Reply-To: <20071026065359.GL11853@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, ballen@gravity.phys.uwm.edu

Tejun Heo wrote:
> ATA_QCFLAG_IO is used to mark commands which are used to perform
> regluar IO transfers via block layer.  These commands are assumed to
> be valid and taken more seriously during error handling.  Cache flush
> is used by regular IO path and necessary for data integrity.  Mark it
> with ATA_QCFLAG_IO.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-scsi.c |    3 +++
>  1 file changed, 3 insertions(+)

patch series looks fine... ok for 2.6.24-rc?


