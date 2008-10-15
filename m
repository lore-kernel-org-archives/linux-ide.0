From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH] libata: ahci enclosure management sync
Date: Wed, 15 Oct 2008 15:22:01 +0900
Message-ID: <48F58C09.6050905@kernel.org>
References: <20081015013916.GA5982@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33942 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860AbYJOGYC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Oct 2008 02:24:02 -0400
In-Reply-To: <20081015013916.GA5982@dhcp-210.hsv.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, kristen.c.accardi@intel.com

David Milburn wrote:
> Hello,
> 
> Shouldn't we synchronize ahci_sw_activity and ahci_sw_activity_blink?
> Isn't it possible that __run_timers has detached the timer so it is
> no longer pending and it is in the process of running the timer func
> on one cpu, and ahci_sw_activity is running on another cpu and may
> see no timer pending so both ahci_sw_activity and ahci_sw_activity_blink
> modify the timeout. Also, ahci_sw_activity is incrementing
> emp->activity and ahci_sw_activity_blink is reading this value.
> Since ap->lock is already being held when ahci_sw_activity runs
> shouldn't ahci_sw_activity_blink grab this lock to better sync
> between the two? 
> 
> Thanks,
> David
> 
>  drivers/ata/ahci.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 2e1a7cb..1573ce3 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1227,6 +1227,7 @@ static void ahci_sw_activity_blink(unsigned long arg)
>  	 * toggle state of LED and reset timer.  If not,
>  	 * turn LED to desired idle state.
>  	 */
> +	spin_lock(ap->lock);

You'll need to use spin_lock_irqsave and unlock_irqrestore.  Other than
that, nice catch.

Thanks.

-- 
tejun
