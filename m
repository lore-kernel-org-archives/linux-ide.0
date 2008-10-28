From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes 1/4 UPDATED] libata: fix device iteration
 bugs
Date: Mon, 27 Oct 2008 23:57:43 -0400
Message-ID: <49068DB7.2040303@garzik.org>
References: <49041323.9020309@kernel.org> <49044ABA.7050104@ru.mvista.com> <490584EF.8040700@kernel.org> <49059F0B.3000508@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54357 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379AbYJ1D5w (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Oct 2008 23:57:52 -0400
In-Reply-To: <49059F0B.3000508@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> There were several places where only enabled devices should be
> iterated over but device enabledness wasn't checked.
> 
> * IDENTIFY data 40 wire check in cable_is_40wire()
> * xfer_mode/ncq_enabled saving in ata_scsi_error()
> * DUBIOUS_XFER handling in ata_set_mode()
> 
> While at it, reformat comments in cable_is_40wire().
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> Comments reformatted as per Sergei's comment.
> 
>  drivers/ata/libata-core.c |   32 ++++++++++++++++++--------------
>  drivers/ata/libata-eh.c   |    9 +++++++++
>  2 files changed, 27 insertions(+), 14 deletions(-)

applied


