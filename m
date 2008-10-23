From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: set device class to NONE if phys_offline
Date: Wed, 22 Oct 2008 20:42:58 -0400
Message-ID: <48FFC892.3020608@garzik.org>
References: <48FDF5D6.20707@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50737 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752767AbYJWAnB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Oct 2008 20:43:01 -0400
In-Reply-To: <48FDF5D6.20707@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Reset methods don't have access to phys link status for slave links
> and may incorrectly indicate device presence causing unnecessary probe
> failures for unoccupied links.  This patch clears device class to NONE
> during post-reset processing if phys link is offline.
> 
> As on/offliness semantics is strictly defined and used in multiple
> places by the core layer, this won't change behavior for drivers which
> don't use slave links.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> vt8251 incorrectly reports the same signature for unoccupied device if
> the other device on the channel is present.  This patch fixes the
> problem.
> 
> I integrated this patch into separate-sff-bmdma git tree.
> 
>  drivers/ata/libata-eh.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

applied


