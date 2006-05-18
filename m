From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFT] major libata update
Date: Thu, 18 May 2006 02:48:48 +0100
Message-ID: <1147916929.10470.140.camel@localhost.localdomain>
References: <20060515170006.GA29555@havoc.gtf.org>
	 <3aa654a40605151630j53822ba1nbb1a2e3847a78025@mail.gmail.com>
	 <446914C7.1030702@garzik.org>
	 <3aa654a40605152036h40fa1cd0x8edd81431c1bd22d@mail.gmail.com>
	 <44694C4F.3000008@garzik.org>
	 <3aa654a40605152133x516581f9w62c7cb7709864fb0@mail.gmail.com>
	 <Pine.LNX.4.64.0605160755170.3866@g5.osdl.org>
	 <87ves44qrs.fsf@duaron.myhome.or.jp>
	 <Pine.LNX.4.64.0605171632340.10823@g5.osdl.org>
	 <446BB64E.1060509@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:10382 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751082AbWERBge (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 May 2006 21:36:34 -0400
In-Reply-To: <446BB64E.1060509@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@osdl.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Avuton Olrich <avuton@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org

On Mer, 2006-05-17 at 19:48 -0400, Jeff Garzik wrote:
> Many BIOS ACPI tables from years ago simply _assumed_ that you have 
> hardcoded irq 14/15, even...  Their irq descriptors for 14/15 would be 
> absent or completely non-functional.

For $PIR this is correct the IRQ 14/15 from the IDE controllers in
legacy mode is an ISA IRQ not a PCI one. Welcome to the happy fun
compatibility factory.

