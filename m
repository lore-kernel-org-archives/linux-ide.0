From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 11/12] (updated) libata-hp-prep: add prereset() method
 and implement ata_std_prereset()
Date: Tue, 30 May 2006 00:12:00 -0400
Message-ID: <447BC610.2000404@pobox.com>
References: <11488839571850-git-send-email-htejun@gmail.com> <11488839581576-git-send-email-htejun@gmail.com> <20060529111213.GB30639@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45539 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751469AbWE3EML (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2006 00:12:11 -0400
In-Reply-To: <20060529111213.GB30639@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> With hotplug, every reset might be a probing reset and thus something
> similar to probe_init() is needed.  prereset() method is called before
> a series of resets to a port and is the counterpart of postreset().
> prereset() can tell EH to use different type of reset or skip reset by
> modifying ehc->i.action.
> 
> This patch also implements ata_std_prereset().  Most controllers
> should be able to use this function directly or with some wrapping.
> After hotplug, different controllers need different actions to resume
> the PHY and detect the newly attached device.  Controllers can be
> categorized as follows.
> 
> * Controllers which can wait for the first FIS34 after hotplug.  Note
>   that if the waiting is implemented by polling TF status, there needs
>   to be a way to set BSY on PHY status change.  It can be implemented
>   by hardware or with the help of the driver.
> 
> * Controllers which can wait for the first FIS34 after sending
>   COMRESET.  These controllers need to issue COMRESET to wait for the
>   first FIS.  Note that the received FIS34 could be the first FIS34
>   after POR (power-on-reset) or FIS34 in response to the COMRESET.
>   Some controllers use COMRESET as TF status synchronization point and
>   clear TF automatically (sata_sil).
> 
> * Controllers which cannot wait for the first FIS34 reliably.  Blindly
>   issuing SRST to spinning-up device often results in command issue
>   failure or timeout, causing extended delay.  For these controllers,
>   ata_std_prereset() explicitly waits ATA_SPINUP_WAIT (currently 8s)
>   to give newly attached device time to spin up, then issues reset.
>   Note that failing to getting ready in ATA_SPINUP_WAIT is not
>   critical.  libata will retry.  So, the timeout needs to be long
>   enough to spin up most devices.
> 
> LLDDs can tell ata_std_prereset() which of above action is needed with
> ATA_FLAG_HRST_TO_RESUME and ATA_FLAG_CANT_WAIT_FIS34 flags.  These
> flags are PHY-specific property and will be moved to ata_link later.
> 
> While at it, this patch unifies function typedef's such that they all
> have named arguments.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK, provided that you banish all mentions of "FIS34" from the patch 
description.

"D2H FIS" is far more understandable to the average human.

	Jeff



