From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 0/9] ide-atapi: remove ide_atapi_pc from the irq handler
Date: Tue, 16 Dec 2008 08:36:00 +0100
Message-ID: <1229412969-3552-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:42466 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920AbYLPHgP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Dec 2008 02:36:15 -0500
Received: by bwz14 with SMTP id 14so3324978bwz.13
        for <linux-ide@vger.kernel.org>; Mon, 15 Dec 2008 23:36:13 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Hi Bart,

here's a first attempt at removing all references to ide_atapi_pc in the ATAPI
IRQ handler. I've moved some of the members to the drive struct and will deal
with them later :). The next step is to add an ide_atapi_queue_pc() routine
similar to ide_cd_queue_pc() and then rewrite all functions in the drivers to
use struct requests and local buffers instead of pc->buf and then, after that
works reliably, finally get rid of ide_atapi_pc completely.

This has been tested with ide-floppy.

 drivers/ide/ide-atapi.c        |  123 ++++++++++++++++-------------
 drivers/ide/ide-floppy.c       |   56 +++++++-------
 drivers/ide/ide-floppy.h       |    4 +-
 drivers/ide/ide-floppy_ioctl.c |   19 +++--
 drivers/ide/ide-tape.c         |  173 ++++++++++++++++++++++------------------
 include/linux/ide.h            |   20 +++--
 6 files changed, 214 insertions(+), 181 deletions(-)
