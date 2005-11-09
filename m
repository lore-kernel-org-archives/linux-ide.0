From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: libata PATA patches
Date: Wed, 09 Nov 2005 15:52:17 +0000
Message-ID: <1131551537.6540.21.camel@localhost.localdomain>
References: <1131460386.25192.45.camel@localhost.localdomain>
	 <4371FA47.1070806@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:61633 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750706AbVKIPVV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Nov 2005 10:21:21 -0500
In-Reply-To: <4371FA47.1070806@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mer, 2005-11-09 at 16:31 +0300, Sergei Shtylylov wrote:
>     I found somewhat strange that you check for 0xABCDExxx signature in 32-bit 
> PCI config. reg. 0x78 while HighPoint's own drivers read BM reg. 0x90 (i.e. 
> PCI config. 0x70) for that. PCI reg. 0x7A is DPLL precision adjust reg. and 
> 0x7B is the input clock select and IRQ reg., so it'd be quite strange if the 
> BIOS used them for any kind of signature...

Yeah thats a bug. What I get for reading the comments in the old driver
and not double checking against the HPT reference code. Thanks

Alan

