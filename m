From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFT] major libata update
Date: Mon, 15 May 2006 18:19:27 +0100
Message-ID: <1147713568.26686.79.camel@localhost.localdomain>
References: <20060515170006.GA29555@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60066 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964983AbWEORHN
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 May 2006 13:07:13 -0400
In-Reply-To: <20060515170006.GA29555@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org

On Llu, 2006-05-15 at 13:00 -0400, Jeff Garzik wrote:
> * PIO-based I/O is now IRQ-driven by default, rather than polled
>   in a kernel thread.  The polling path will continue to exist for
>   controllers that need it, and other special cases. (Albert Lee)

How will this be selected ? Passing ->irq = 0 ?

For ata_piix given you've destabilized it a bit would now be a good time
to submit the patches to fix the timing, register scribble and incorrect
ATAPI caching ?
