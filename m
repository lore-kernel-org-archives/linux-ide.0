From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] sata_nv: reinstate nv_hardreset() for
 non generic controllers
Date: Mon, 29 Sep 2008 00:15:58 -0400
Message-ID: <48E0567E.4050605@garzik.org>
References: <48DEB605.6090504@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34461 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745AbYI2EQE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Sep 2008 00:16:04 -0400
In-Reply-To: <48DEB605.6090504@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org

Tejun Heo wrote:
> Commit 2fd673ecf0378ddeeeb87b3605e50212e0c0ddc6 which tried to remove
> hardreset for generic accidentally removed it for all flavors as all
> others were inheriting from nv_generic_ops.  This patch reinstates
> nv_hardreset() and puts it into nv_common_ops which all flavors
> inherit from.  nv_generic_ops now inherits from nv_common_ops and
> overrides .hardreset to ATA_OP_NULL.
> 
> While at it, explain why nv_hardreset and ATA_OP_NULL override are
> necessary.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> This fixes the following regression.
> 
>   http://bugzilla.kernel.org/show_bug.cgi?id=11615
> 
> Jeff, are you off for the vacation already?
> 
> Thanks.
> 
>  drivers/ata/sata_nv.c |   46 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 40 insertions(+), 6 deletions(-)

applied

Flight leaves in 12 hours! :)




