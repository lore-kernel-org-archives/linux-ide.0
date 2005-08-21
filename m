From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-dev-2.6:upstream 01/02] libata: implement ata_poll_qc_complete
 and use it in polling functions
Date: Sun, 21 Aug 2005 15:53:58 -0400
Message-ID: <4308DBD6.80208@pobox.com>
References: <20050820141408.62050C34@htj.dyndns.org> <20050820141408.5788A466@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:52936 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751097AbVHUVE4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Aug 2005 17:04:56 -0400
Received: from mail.dvmed.net (mail.dvmed.net [216.237.124.58])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7LJs5D3000666
	for <linux-ide@vger.kernel.org>; Sun, 21 Aug 2005 12:54:05 -0700
In-Reply-To: <20050820141408.5788A466@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> 01_libata_add-ata_poll_qc_complete.patch
> 
> 	Previously, libata polling functions turned irq back on and
> 	completed qc commands without holding host lock.  This creates
> 	a race condition between the polling task and interrupts from
> 	other ports on the same host set or spurious interrupt from
> 	itself.
> 
> 	This patch implements ata_poll_qc_complete which enables irq
> 	and completes qc atomically and convert all polling functions.
> 
> 	Note: Unlike other functions, atapi_packet_task() didn't use
> 	to turn irq back on on error exits.  This patch makes it use
> 	ata_poll_qc_complete, so irq is now turned back on on error
> 	exits.
> 
> 	Note: With this change, ALL invocations of ata_qc_complete()
> 	are now done under host_set lock.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

This one looks OK to me.  Given that I rejected the other three, would 
you still like me to apply just this one?

	Jeff



