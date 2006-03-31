From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 09/15] libata: implement ata_down_xfermask_limit()
Date: Fri, 31 Mar 2006 23:31:32 +0100
Message-ID: <1143844292.15646.4.camel@localhost.localdomain>
References: <11438230983159-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:3003 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751452AbWCaWYS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 31 Mar 2006 17:24:18 -0500
In-Reply-To: <11438230983159-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

On Sad, 2006-04-01 at 01:38 +0900, Tejun Heo wrote:
> Implement ata_down_xfermask_limit().  This function manipulates
> @dev->pio/mwdma/udma_mask such that the next lower transfer mode is
> selected.  This will be used by ata_bus_probe() rewrite and later by
> EH speeding down.

This will need care. If it is called during a transfer mode change on
error we should document that this function will only be called after
the host_set has been quiesced, otherwise drivers that peek a lot at
their ap-> mode settings at runtime (eg on an IRQ occuring during a
speed change down) are going to burned badly.

It would be nice to see a description of the locking model for a
changedown at this point.

Alan

