From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH/RFC 0/5] libata-dev: integrate polling pio with irq-pio
Date: Sat, 11 Mar 2006 19:37:53 -0500
Message-ID: <44136D61.4020007@pobox.com>
References: <440FEA4B.10500@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:8376 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751377AbWCLAh6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Mar 2006 19:37:58 -0500
In-Reply-To: <440FEA4B.10500@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

Albert Lee wrote:
> This patch set integrates polling pio with irq-pio.
> 
> Changes:
> 1/5: Move out the HSM code from ata_host_intr() to the new ata_hsm_move() function.
> 2/5: Minor fix for ata_hsm_move() to work with ata_host_intr()
> 3/5: Let ata_hsm_move() work with both irq-pio and polling pio
> 4/5: Convert ata_pio_task() to use the new ata_hsm_move()
> 5/5: Cleanup unused enums/functions.
> 
> Patch against irq-pio branch (c2956a3b0d1c17b38da369811a6ce93eb7a01a04). 
> Minimally tested ok on x86. 

What can I say?  :)

I agree with this patchset, once its revised with (a) Tejun's comments 
and (b) the newly merged-with-upstream irq-pio branch.

So I'll wait for your resend of any irq-pio patches.

	Jeff



