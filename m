From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: update atapi disable handling
Date: Thu, 31 Jul 2008 01:50:54 -0400
Message-ID: <489152BE.8030309@garzik.org>
References: <4890F0B8.90009@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42440 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752342AbYGaFu7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jul 2008 01:50:59 -0400
In-Reply-To: <4890F0B8.90009@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, chunbo.luo@windriver.com, Andrew Morton <akpm@linux-foundation.org>

Tejun Heo wrote:
> Global and per-LLD ATAPI disable checks were done in the command issue
> path probably because it was left out during EH conversion.  On
> affected machines, this can cause lots of warning messages.  Move them
> to where they belong - the probing path.
> 
> Reported by Chunbo Luo.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Chunbo Luo <chunbo.luo@windriver.com>
> ---
>  drivers/ata/libata-core.c |   12 +++++++++++-
>  drivers/ata/libata-scsi.c |   34 ++--------------------------------
>  drivers/ata/libata.h      |    1 -
>  3 files changed, 13 insertions(+), 34 deletions(-)

applied


