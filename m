From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-dev-2.6:upstream 00/02] atapi: packet task vs.
 intr race fix
Date: Sun, 21 Aug 2005 16:25:40 -0400
Message-ID: <4308E344.3010405@pobox.com>
References: <20050820091651.486821E0@htj.dyndns.org> <4308DA57.9000303@pobox.com> <4308E13E.6070104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:9416 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751089AbVHUU6X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Aug 2005 16:58:23 -0400
Received: from mail.dvmed.net (mail.dvmed.net [216.237.124.58])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7LKPj0B011590
	for <linux-ide@vger.kernel.org>; Sun, 21 Aug 2005 13:25:45 -0700
In-Reply-To: <4308E13E.6070104@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
>  Have you received patches in the reverse order?  #1 changes 
> ata_irq_on() and #2 adds ata_qc_set_polling().
> 
>  Hmmm, only a call to ata_chk_status() is added to ata_irq_on(), which I 
> think is needed regardless of other changes, and ata_wait_idle() is 
> removed.  Does that make the function heavy?


You're also adding a call to ->irq_clear() in there.

The overall meaning/effect of the patch is heavy:  "I don't know why 
these interrupts are popping up, so I'll whack it with a hammer every 
chance I get, to make them go away."  ;-) ;-)

That's taking the easy way out ;-)  It's a bandaid over whatever the 
-real- problem is.

	Jeff


