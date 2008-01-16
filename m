From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 00/22] ide: even more IDE probing code rework
Date: Thu, 17 Jan 2008 00:25:56 +0100
Message-ID: <20080116232556.9166.13457.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:10411 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbYAPXNR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jan 2008 18:13:17 -0500
Received: by ug-out-1314.google.com with SMTP id z38so275985ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 16 Jan 2008 15:13:16 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org


Just another bunch of small fixes/cleanups...

diffstat:

 drivers/ide/arm/bast-ide.c        |   22 +++-
 drivers/ide/arm/rapide.c          |    4
 drivers/ide/ide-acpi.c            |   60 +++--------
 drivers/ide/ide-pnp.c             |    9 -
 drivers/ide/ide-probe.c           |  204 +++++++++++++++++++++-----------------
 drivers/ide/ide-proc.c            |    7 -
 drivers/ide/ide.c                 |   66 +++++++-----
 drivers/ide/legacy/dtc2278.c      |   10 -
 drivers/ide/legacy/ht6560b.c      |   26 ++--
 drivers/ide/legacy/ide-cs.c       |   31 +++++
 drivers/ide/legacy/ide_platform.c |    4
 drivers/ide/legacy/qd65xx.c       |   44 ++++++--
 drivers/ide/mips/au1xxx-ide.c     |    7 -
 drivers/ide/pci/delkin_cb.c       |   40 +++++--
 drivers/ide/pci/opti621.c         |   10 +
 drivers/ide/pci/rz1000.c          |    3
 drivers/ide/pci/scc_pata.c        |    4
 drivers/macintosh/mediabay.c      |    2
 include/linux/ide.h               |   22 ++--
 19 files changed, 340 insertions(+), 235 deletions(-)
