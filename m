From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 0/15] ide: fixes/cleanups for IDE devices probing
Date: Fri, 04 Jan 2008 22:24:24 +0100
Message-ID: <20080104212424.6978.93646.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:37216 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719AbYADVMs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jan 2008 16:12:48 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2833655ugc.16
        for <linux-ide@vger.kernel.org>; Fri, 04 Jan 2008 13:12:47 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org


This is a preparation for a more sophisticated changes.

diffstat:

 drivers/ide/ide-iops.c            |    2
 drivers/ide/ide-probe.c           |  199 ++++++++++++++++----------------------
 drivers/ide/ide.c                 |  109 ++++++++++----------
 drivers/ide/legacy/ide_platform.c |   34 +-----
 drivers/ide/pci/ns87415.c         |    4
 include/linux/ide.h               |   15 --
 6 files changed, 157 insertions(+), 206 deletions(-)

Bart
