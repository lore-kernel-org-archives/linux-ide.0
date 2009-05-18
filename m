From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/6] drivers/ide Convert printk(KERN_<foo> to pr_<foo>(
Date: Mon, 18 May 2009 16:12:43 +0200
Message-ID: <200905181612.43632.bzolnier@gmail.com>
References: <cover.1242609803.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:3740 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbZEROIl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 May 2009 10:08:41 -0400
In-Reply-To: <cover.1242609803.git.joe@perches.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Monday 18 May 2009 04:21:08 Joe Perches wrote:
> Mostly mechanical conversion of printk's

[...]

Hmm.. less mechanical conversion using also dev_*() macros where suitable
would be much better...

> Joe Perches (6):
>   drivers/ide: Convert printk(KERN_DEBUG to pr_debug(

How's about fixing pr_devel() which currently doesn't seem to be used
by anything inside kernel to not depend on DEBUG in separate pre-patch
and then using it instead of pr_debug()?

>   drivers/ide: Convert printk(KERN_INFO to pr_info(
>   drivers/ide: Convert printk(KERN_ERR to pr_err(
>   drivers/ide: Convert printk(KERN_WARNING to pr_warning(
>   drivers/ide: Convert printk(KERN_CONT to pr_cont(
>   drivers/ide: Convert printk(KERN_NOTICE to pr_notice(

Please re-do it so we have per-file patches instead of per-pr_.

Preferably with some files grouped together so we have only three patches:

* core code: ide-acpi.c, ide-atapi.c, ide.c, ide-devsets.c, ide-dma*.c,
  ide-eh.c, ide-io*.c, ide-legacy.c, ide-lib.c, ide-park.c, ide-pio*.c,
  ide-pm.c, ide-probe.c, ide-proc.c, ide-scan-pci.c, ide-sysfs.c,
  ide-taskfile.c, ide-timings.c, ide-xfer-mode.c and setup-pci.c

* device drivers: ide-cd*, ide-disk*, ide-gd*, ide-floppy* and ide-tape.c

* host drivers: all the rest

It would make patches easier to review and would greatly help when it
comes to merging them (i.e. I could apply changes to host drivers right
know but I don't want to interfere too much with the on-going work on
device drivers).

Thanks.
Bart
