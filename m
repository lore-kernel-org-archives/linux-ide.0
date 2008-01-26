From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 10/14] sata_mv Use DMA memory pools for hardware memory
 tables
Date: Sat, 26 Jan 2008 10:20:02 -0500
Message-ID: <479B4FA2.3030503@rtr.ca>
References: <4798FB68.70400@rtr.ca> <4798FCE1.30702@rtr.ca> <479AB639.5020108@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4419 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751929AbYAZPUC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Jan 2008 10:20:02 -0500
In-Reply-To: <479AB639.5020108@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
..
> The amount of memory used in the pre-existing configuration is small, it 
> is already allocated on a per-device basis, and it is statically 
> allocated -- meaning no worry about allocations failing inside of 
> interrupts or similar nastiness.
..

Note that there's also "no worry about allocations failing inside of 
interrupts or similar nastiness" with the patch posted, either.

Cheers
