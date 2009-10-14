From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_sc1200: Fix crash on boot
Date: Wed, 14 Oct 2009 13:25:18 +0100
Message-ID: <20091014132518.5dce81be@lxorguk.ukuu.org.uk>
References: <20091006150737.9610.81541.stgit@localhost.localdomain>
	<20091013185637.870369c8.akpm@linux-foundation.org>
	<20091014130046.0aa13166@lxorguk.ukuu.org.uk>
	<200910141412.29467.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760075AbZJNM0U@vger.kernel.org>
In-Reply-To: <200910141412.29467.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@linux.intel.com>, jeff@garzik.org, linux-kernel@vger.kernel.org, stable@kernel.org, "Alexandros C. Couloumbis" <alex@ozo.com>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> BTW do you happen to know who is the current maintainer of this driver
> (ditto for other PATA drivers)?
> 
> MAINTAINERS lists only:
> 
> 	SERIAL ATA (SATA) SUBSYSTEM
> 	P:      Jeff Garzik
> 	M:      jgarzik@pobox.com
> 	L:      linux-ide@vger.kernel.org
> 	T:      git git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> 	S:      Supported
> 	F:      drivers/ata/
> 	F:      include/linux/ata.h
> 	F:      include/linux/libata.h
> 
> but this driver surely ain't SATA.

The subsystem wants renaming. Patches go to Jeff who though he rarely
appears on listy and stuff keeps the tree and is doing all the submission
stuff.

Alan
