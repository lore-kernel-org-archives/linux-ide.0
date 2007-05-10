From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_nv: fix ADMA freeze/thaw/irq_clear issues
Date: Wed, 09 May 2007 20:17:28 -0400
Message-ID: <46426498.5050205@garzik.org>
References: <463CF8E4.6000902@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50605 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755447AbXEJARa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 May 2007 20:17:30 -0400
In-Reply-To: <463CF8E4.6000902@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, web01@danzon.com

Robert Hancock wrote:
> This patch fixes some problems with ADMA-capable controllers with regard 
> to freeze,
> thaw and irq_clear libata callbacks. Freeze and thaw didn't switch the 
> ADMA-specific
> interrupts on or off, and more critically the irq_clear function didn't 
> respect
> the restriction that the notifier clear registers for both ports have to 
> be written
> at the same time even when only one port is being cleared. This could 
> result in
> timeouts on one port when error handling (i.e. as a result of hotplug)
> occurred on the other port.
> 
> As well, this fixes some issues in the interrupt handler: we shouldn't 
> check any
> ADMA status if the port has ADMA switched off because of an ATAPI 
> device, and
> it also checks to see if any ADMA interrupt has been raised even when we 
> are in
> port-register mode.
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>

applied

please properly word-wrap your patch descriptions in the future


