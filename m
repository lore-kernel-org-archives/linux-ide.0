From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.6.22-rc4]: libata: PATA-mode fixes for sis_sata
Date: Mon, 16 Jul 2007 10:04:01 +0100
Message-ID: <20070716100401.7a0b850e@the-village.bc.nu>
References: <200706142340.44068.uwe.koziolek@gmx.net>
	<469AD93B.6090509@starsoftcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48595 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753000AbXGPI5k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 04:57:40 -0400
In-Reply-To: <469AD93B.6090509@starsoftcomm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: yulin <yulin@starsoftcomm.com>
Cc: Uwe Koziolek <uwe.koziolek@gmx.net>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, micha.biermann@gmx.de

> So one leader of our IT, who is a Windows expert, suggested we can use 
> int 13h and I/O in Linux. But int 13h just is used in real mode.
> 
> Can you give me some advice to persuade him? If it is feasible, can you 
> introduce me?

int13 is real mode only, runs polled and 16bit with one command at a
time. As far as I know even Windows no longer uses it for anything but
booting.

> Even can you give some good solutions to solve the compatibility problem?

For hardware where we have info the right answer is to report bugs and
get them fixed (or indeed send fixes). For the more general case the
ata_generic driver will drive anything that is SFF8038i compliant and you
can just add PCI identifiers to it for anything you hit.

I am working on a generic ACPI driver to go with it for such cases.

Alan
