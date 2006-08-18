From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Merging libata PATA support into the base kernel
Date: Fri, 18 Aug 2006 21:50:54 +0100
Message-ID: <1155934254.31543.1.camel@localhost.localdomain>
References: <1155144599.5729.226.camel@localhost.localdomain>
	 <20060810122056.GP11829@suse.de> <20060810190222.GA12818@knob.reflex>
	 <200608102140.36733.rjw@sisk.pl> <44E3E1E6.9090908@PicturesInMotion.net>
	 <20060817091842.GC17899@elf.ucw.cz>
	 <1155808348.15195.55.camel@localhost.localdomain>
	 <20060817094512.GD17899@elf.ucw.cz>
	 <1155815491.15195.75.camel@localhost.localdomain>
	 <44E53635.3080702@PicturesInMotion.net>
	 <44E53A9B.6080701@PicturesInMotion.net>
	 <1155916869.28764.20.camel@localhost.localdomain>
	 <44E6137B.9090103@PicturesInMotion.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:19335 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932519AbWHRUa4
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Aug 2006 16:30:56 -0400
In-Reply-To: <44E6137B.9090103@PicturesInMotion.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lee Trager <Lee@PicturesInMotion.net>
Cc: Pavel Machek <pavel@suse.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, Jason Lunz <lunz@falooley.org>, Jens Axboe <axboe@suse.de>, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Stefan Seyfried <seife@suse.de>

Ar Gwe, 2006-08-18 am 15:22 -0400, ysgrifennodd Lee Trager:
> Well where in the kernel is the code that disabled HPA on startup? Im
> new to kernel hacking so if you could point me in the right direction I
> could try to patch it myself.

drivers/ide/ide-disk.c

Particularly:
	idedisk_check_hpa()

which if you call at the end of the resume sequence for disks ought to
do the right thing for you

