From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes UPDATED] libata: fix last_reset timestamp
 handling
Date: Tue, 11 Nov 2008 03:02:07 -0500
Message-ID: <49193BFF.2000401@garzik.org>
References: <490FFA89.1030002@kernel.org> <49100308.90207@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:32899 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754521AbYKKICL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Nov 2008 03:02:11 -0500
In-Reply-To: <49100308.90207@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Shane Huang <Shane.Huang@amd.com>, stable@kernel.org

Tejun Heo wrote:
> ehc->last_reset is used to ensure that resets are not issued too close
> to each other.  It's initialized to jiffies minus one minute on EH
> entry.  However, when new links are initialized after PMP is probed,
> new links have zero for this timestamp resulting in long wait
> depending on the current jiffies.
> 
> This patch makes last_set considered iff ATA_EHI_DID_RESET is set, in
> which case last_reset is always initialized.  As an added precaution,
> WARN_ON() is added so that warning is printed if last_reset is in
> future.
> 
> This problem is spotted and debugged by Shane Huang.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Shane Huang <Shane.Huang@amd.com>
> ---
> This one also should go into 2.6.27-x.  Thanks.
> 
> Minor update.  Kill ehc->last_reset update right after
> ata_eh_about_to_do().  This does no harm but is unnecessary with the
> patch applied.
> 
>  drivers/ata/libata-eh.c |   21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)

applied

