From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 0/5] libata-dev: irq-pio minor fixes
Date: Sat, 11 Mar 2006 19:27:48 -0500
Message-ID: <44136B04.4090203@pobox.com>
References: <44119BC9.8080502@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:52407 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751340AbWCLA1w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Mar 2006 19:27:52 -0500
In-Reply-To: <44119BC9.8080502@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: IDE Linux <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Albert Lee wrote:
> Minor fixes for irq-pio to catch up with upstream.
> 
> Changes:
> 1/5: Add back missing dev->cdb_len = 16
> 2/5: Make dev->id dynamically allocated
> 3/5: Remove ata_dev_identify(), ata_dev_config() and ata_bus_probe().
> 4/5: Add back ata_dev_configure(), ata_bus_probe(), ata_dev_same_device() and ata_dev_revalidate().
> 5/5: Add back irq-pio patches, etc.
> 
> Patch against the irq-pio branch (c2956a3b0d1c17b38da369811a6ce93eb7a01a04). 

I pulled the current #upstream into the irq-pio, and then fixed the 
merge problems.

Would you be kind enough to resync against this, and resend what's 
needed?  I would rather not have these remove-and-add-back patches.

Also, I never received patch #3 in this series.

	Jeff



