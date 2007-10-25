From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream] libata: track SLEEP state and issue SRST to
 wake	it up
Date: Thu, 25 Oct 2007 05:38:36 -0400
Message-ID: <4720641C.6080806@garzik.org>
References: <20071025093036.GK11853@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49365 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754453AbXJYJii (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Oct 2007 05:38:38 -0400
In-Reply-To: <20071025093036.GK11853@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, andrew.m.paprocki@gmail.com, ballen@gravity.phys.uwm.edu

Tejun Heo wrote:
> ATA devices in SLEEP mode don't respond to any commands.  SRST is
> necessary to wake it up.  Till now, when a command is issued to a
> device in SLEEP mode, the command times out, which makes EH reset the
> device and retry the command after that, causing a long delay.
> 
> This patch makes libata track SLEEP state and issue SRST automatically
> if a command is about to be issued to a device in SLEEP.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Bruce Allen <ballen@gravity.phys.uwm.edu>
> Cc: Andrew Paprocki <andrew@ishiboo.com>
> ---
> This patch is against
> 
>  #upstream
>  + relocate-and-fix-post-command-processing patch
>    (http://article.gmane.org/gmane.linux.ide/24001)
> 
> The infinite loop with the previous patch wasn't caused by bug in
> sleep state tracking.  It was happening because post-command
> processing was being performed for commands which are being retried
> from EH, so what happened was.
> 
> 1. device is flagged SLEEPING
> 
> 2. SLEEP is issued, as device is sleeping, EH is rescheduled against
>    the qc for SLEEP.
> 
> 3. EH kicks in and wakes up the device and clears SLEEPING.
> 
> 4. EH finishes up failed qc which triggers post-command processing and
>    sets SLEEPING.
> 
> 5. SCSI command is retried, go back to #2.
> 
> relocate-and-fix-post-command-processing patch fixes the original bug
> in post-command processing and this patch doesn't cause infinite loop
> anymore.
> 
>  drivers/ata/libata-core.c |   12 ++++++++++++
>  drivers/ata/libata-eh.c   |    4 +++-
>  include/linux/ata.h       |    1 +
>  include/linux/libata.h    |    1 +
>  4 files changed, 17 insertions(+), 1 deletion(-)

applied, both of these changes were nice improvements, as well as fixing 
problems


