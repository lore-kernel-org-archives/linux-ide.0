From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: implement and use ata_wait_idle_quiet()
Date: Sat, 3 Mar 2007 00:48:01 +0000
Message-ID: <20070303004801.30fc7fed@lxorguk.ukuu.org.uk>
References: <20070227142606.GI20322@htj.dyndns.org>
	<45E8AA64.9080207@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46134 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S2992763AbXCBXn5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Mar 2007 18:43:57 -0500
In-Reply-To: <45E8AA64.9080207@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

> > This makes spurious abnormal status messages seen in many sff
> > controllers.
> > 
> > Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> My feeling is that this will also hide bugs, such as in the AHCI case

I think its the right thing to do in the end at least for the SFF cases
(can't comment on AHCI). Perhaps we should make that version printk to a
different printk level for now or if ATA_DEBUG is enabled ?
