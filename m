From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Assorted bugs in the PIIX drivers
Date: Mon, 15 May 2006 16:59:43 +0100
Message-ID: <1147708783.26686.69.camel@localhost.localdomain>
References: <1132929808.3298.18.camel@localhost.localdomain>
	 <44689A54.4020307@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52158 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751500AbWEOPrE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 May 2006 11:47:04 -0400
In-Reply-To: <44689A54.4020307@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Llu, 2006-05-15 at 19:12 +0400, Sergei Shtylyov wrote:
>     For PIO2+ actually, according to Intel's PRM (29860004.pdf), and it's said
> to have no effect in the lower modes. This is actually not very correct since
> when one issues Set Transfer Mode ATA command with the value (8 + PIOn), this
> means select PIO _flow control_ mode n, so -IORDY is assumed to be in use.

PIO2 depends on the drive (there is a drive parameter telling you the
highest timing clock you can do with/without IORDY

> > I'm also not clear if the "no MWDMA0" list has been updated correctly
> > for the newer chipsets.
> 
>     What is/was the point for keeping MW DMA 0 support anyway? On PIIX, it's
> greatly slowed down (600 vs 480 ns cycle) and was never "offically" supported
> by Intel.

Some old old drives only do MWDMA0. The Intel docs I have here don't
describe it in any way as "unsupported", merely broken on some ICH
variants.

Alan

