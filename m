From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE class driver with SATA controllers
Date: Wed, 01 Sep 2004 13:01:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1094040111.2476.43.camel@localhost.localdomain>
References: <DBFABB80F7FD3143A911F9E6CFD477B03F969B@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S266425AbUIANE3@vger.kernel.org>
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B03F969B@hqemmail02.nvidia.com>
To: Andrew Chew <achew@nvidia.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, jgarzik@pobox.com, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org

On Maw, 2004-08-31 at 22:03, Andrew Chew wrote:
> In my perusal of the kernel code, I noticed that the IDE subsystem
> handles IDE controllers at legacy IO ports if no other driver claims
> them (albeit without DMA support).  I was wondering if it could be
> extended to support SATA controllers 
> that aren't mapped to legacy I/O ports.

Generally no. It depends how the SATA controller provides interfaces.
If it provides the standards based interface with BIOS configured DMA
and timings but has no other support then add it to pci/generic.c. If it
doesn't then it'll need a driver anyway.

Alan
