From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 11/13] sata_sil24: convert to new probing mechanism and
 add hotplug support
Date: Tue, 30 May 2006 00:28:02 -0400
Message-ID: <447BC9D2.3050908@pobox.com>
References: <11488847362278-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50148 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751490AbWE3E2R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2006 00:28:17 -0400
In-Reply-To: <11488847362278-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Convert to new probing mechanism and add hotplug support by enabling
> PORT_IRQ_PHYRDY_CHG, marking ehi for hotplug and scheduling EH on
> PORT_IRQ_PHYRDY_CHG or PORT_IRQ_DEV_XCHG.
> 
> Sil3124/32 family of controllers don't have any mechanism to wait for
> the first FIS34 after hotplug, so ATA_FLAG_CANT_WAIT_FIS34 is used.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

same comment as before.  "FIS34" string must die :)


