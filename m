From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] libata: Handle bay devices in dock stations
Date: Mon, 9 Jun 2008 02:48:18 +0100
Message-ID: <20080609014818.GA32083@srcf.ucam.org>
References: <20080528143857.GB5585@homac.suse.de> <4845886E.2010505@garzik.org> <20080603181346.GA5013@srcf.ucam.org> <484C8AE1.3010908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:60870 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754923AbYFIBsW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Jun 2008 21:48:22 -0400
Content-Disposition: inline
In-Reply-To: <484C8AE1.3010908@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org

On Mon, Jun 09, 2008 at 10:44:01AM +0900, Tejun Heo wrote:

> TF-based ATA controllers are very sensitive to how the registers are 
> accessed and sometimes lock up the whole machine when they are not happy 
> by indefinitely holding the PCI bus.  This could have been the case if 
> IOs were in flight when the dock event occurred.  Were they?

I'd stopped hal, so I can't imagine that userspace was causing any to be 
generated at that point.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
