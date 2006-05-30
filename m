From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 10/13] ahci: convert to new probing mechanism and add
 hotplug support
Date: Tue, 30 May 2006 00:27:33 -0400
Message-ID: <447BC9B5.3040708@pobox.com>
References: <11488847362303-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46308 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751488AbWE3E1w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2006 00:27:52 -0400
In-Reply-To: <11488847362303-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Convert to new probing mechanism and add hotplug support by enabling
> PORT_IRQ_PHYRDY, marking ehi for hotplug and scheduling EH on
> CONNECT/PHYRDY interrupts.
> 
> Unfortunately, ahci cannot reliably wait for the first FIS34 after
> hotplug.  It sometimes succeeds but times out more often than not, so
> ATA_FLAG_CANT_WAIT_FIS34 is used.
> 
> This patch also fixes ahci_hardreset() such that D2H Register FIS RX
> area is cleared before issuing COMRESET.  Without this,
> ata_busy_sleep() after COMRESET might prematually finish if the
> previous TF contains DRDY && !BSY.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

NAK all mention of FIS34, ACK everything else


