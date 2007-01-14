From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.20-rc4-mm1
Date: Sun, 14 Jan 2007 11:46:57 +0100
Message-ID: <1168771617.2941.59.camel@localhost.localdomain>
References: <20070111222627.66bb75ab.akpm@osdl.org>
	 <1168768104.2941.53.camel@localhost.localdomain>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:34240 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751210AbXANKku (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 14 Jan 2007 05:40:50 -0500
In-Reply-To: <1168768104.2941.53.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, axboe@kernel.dk

On Sun, 2007-01-14 at 10:48 +0100, Thomas Gleixner wrote:
> ata_scsi_rbuf_get requests KM_IRQ0 type memory and calls kmap_atomic
> with interrupts enabled.
> 
> Boot proceeds, but gets stuck hard at:
> "Remounting root filesystem in read-write mode:"
> 
> No SysRq-T, nothing.
> 
> The above BUG seems unrelated to that. Investigating further.

Bisect identified: git-block.patch

	tglx


