From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata dev_config call order wrong.
Date: Mon, 30 Aug 2004 14:22:55 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1093872174.30146.15.camel@localhost.localdomain>
References: <41320DAF.2060306@wasp.net.au> <41321288.4090403@pobox.com>
	 <413216CC.5080100@wasp.net.au> <4132198B.8000504@pobox.com>
	 <41321F7F.7050300@pobox.com>
	 <1093805994.28289.4.camel@localhost.localdomain>
	 <4132EF78.9000200@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from the-village.bc.nu ([81.2.110.252]:47489 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267619AbUH3OZG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Aug 2004 10:25:06 -0400
In-Reply-To: <4132EF78.9000200@wasp.net.au>
List-Id: linux-ide@vger.kernel.org
To: Brad Campbell <brad@wasp.net.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Llu, 2004-08-30 at 10:12, Brad Campbell wrote:
> Given that the SATA->PATA bridge boards support 80 pin detection, then bit 13 of word 93 must be 
> high on any drive that supports lba48, and given the *current* sata spec states that word 93 must be 
> zero, we should be able to use this detection method.

Word 53 is the important one and essentially tells you what else to
believe later on in the configuration.

