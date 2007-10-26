From: Russell King <rmk@arm.linux.org.uk>
Subject: Regression: commit "ide: constify struct ide_port_info" causes breakage
Date: Fri, 26 Oct 2007 16:56:48 +0100
Message-ID: <20071026155648.GB4321@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35449 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763808AbXJZQCX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Oct 2007 12:02:23 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

commit 8562043606430185cad26d085d46adcc7ad67fd1 is broken, causing:

  CC      drivers/ide/pci/cmd64x.o
  CC      drivers/ide/pci/hpt366.o
drivers/ide/pci/hpt366.c:1428: error: hpt366_chipsets causes a section type conflict

and therefore should be reverted.

The problem arises because hpt366 has other data marked with __devinitdata,
so the compiler tries to define the initdata section with read-write
attributes at one point, and read-only attributes when encountering the
const-but-devinitdata declaration:

static struct hpt_info hpt36x __devinitdata = {
static struct hpt_info hpt370 __devinitdata = {
static struct hpt_info hpt370a __devinitdata = {
...
static const struct ide_port_info hpt366_chipsets[] __devinitdata = {

If we want ide_port_info to be read-only initdata, then we need
__devroinitdata and __roinitdata tags.

Note: it doesn't show up in cmd64x.c because that file contains no other
data marked as initdata or devinitdata.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
