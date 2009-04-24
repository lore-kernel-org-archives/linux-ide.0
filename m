From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch] Enable parallel scan on ata_piix
Date: Fri, 24 Apr 2009 06:29:37 -0400
Message-ID: <49F19491.2030901@garzik.org>
References: <20090423214411.515310df@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52901 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752654AbZDXK3m (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Apr 2009 06:29:42 -0400
In-Reply-To: <20090423214411.515310df@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Arjan van de Ven wrote:
> Hi,
> 
> This patch turns on parallel scanning for the ata_piix driver.
> This driver is used on most netbooks (no AHCI for cheap storage it seems).
> The scan is the dominating time factor in the kernel boot for these
> devices; with this flag it gets cut in half for the device I used
> for testing (eeepc).
> Alan took a look at the driver source and concluded that it ought to be safe
> to do for this driver.
> 
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

I tend to doubt "safe", given the complicated and buggy silicon state 
machine that recreates the legacy IDE interface on SATA...

	Jeff




