From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Regression: commit "ide: constify struct ide_port_info" causes breakage
Date: Fri, 26 Oct 2007 20:18:14 +0200
Message-ID: <200710262018.14815.bzolnier@gmail.com>
References: <20071026155648.GB4321@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:62969 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754978AbXJZSNE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Oct 2007 14:13:04 -0400
Received: by nf-out-0910.google.com with SMTP id g13so854649nfb
        for <linux-ide@vger.kernel.org>; Fri, 26 Oct 2007 11:13:02 -0700 (PDT)
In-Reply-To: <20071026155648.GB4321@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Friday 26 October 2007, Russell King wrote:
> commit 8562043606430185cad26d085d46adcc7ad67fd1 is broken, causing:
> 
>   CC      drivers/ide/pci/cmd64x.o
>   CC      drivers/ide/pci/hpt366.o
> drivers/ide/pci/hpt366.c:1428: error: hpt366_chipsets causes a section type conflict
> 
> and therefore should be reverted.

Fixed 3 days ago, patch was posted to LKML.

http://lkml.org/lkml/2007/10/23/411

[ Will be pushed to Linus together with few other fixes soon. ]

> The problem arises because hpt366 has other data marked with __devinitdata,
> so the compiler tries to define the initdata section with read-write
> attributes at one point, and read-only attributes when encountering the
> const-but-devinitdata declaration:
> 
> static struct hpt_info hpt36x __devinitdata = {
> static struct hpt_info hpt370 __devinitdata = {
> static struct hpt_info hpt370a __devinitdata = {
> ...
> static const struct ide_port_info hpt366_chipsets[] __devinitdata = {
> 
> If we want ide_port_info to be read-only initdata, then we need
> __devroinitdata and __roinitdata tags.

http://lkml.org/lkml/2007/10/23/412

Thanks,
Bart
