From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 0/6] ide: more core code housekeeping
Date: Mon, 19 Jan 2009 14:03:09 +0100
Message-ID: <20090119130309.24745.40877.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:46104 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759380AbZASNCr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2009 08:02:47 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org


SFF I/O code goes to ide-io-sff.c and error handling to ide-eh.c...

diffstat:
 drivers/ide/Makefile     |    5 
 drivers/ide/ide-atapi.c  |   15 +
 drivers/ide/ide-eh.c     |  427 +++++++++++++++++++++++++++++
 drivers/ide/ide-io-sff.c |  314 +++++++++++++++++++++
 drivers/ide/ide-io.c     |  129 --------
 drivers/ide/ide-iops.c   |  691 ++---------------------------------------------
 include/linux/ide.h      |   13 
 7 files changed, 801 insertions(+), 793 deletions(-)
