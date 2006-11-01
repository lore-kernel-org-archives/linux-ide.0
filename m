From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [git patches] libata fixes
Date: Wed, 01 Nov 2006 14:30:35 +0000
Message-ID: <1162391435.11965.128.camel@localhost.localdomain>
References: <20061101021301.GA21568@havoc.gtf.org>
	 <17736.43507.649685.484648@smtp.charter.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:65468 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S2992514AbWKAOiU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Nov 2006 09:38:20 -0500
In-Reply-To: <17736.43507.649685.484648@smtp.charter.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: John Stoffel <john@stoffel.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Ar Mer, 2006-11-01 am 09:06 -0500, ysgrifennodd John Stoffel:
> Jeff> +	{ 0x8086, 0x7110, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_33 },
> Jeff>  	{ 0x8086, 0x7111, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_33 },
> 
> Umm, according to lspci -nn on my 440GX box, isn't the 0x8086/0x7110
> an ISA bridge, not a PIIX? controller?  

Correct - the 7110 doesn't belong on that list.


