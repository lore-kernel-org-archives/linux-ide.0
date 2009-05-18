From: Joe Perches <joe@perches.com>
Subject: drivers/ide/ide-core: Convert printk's to pr_<foo> and dev_<foo>
Date: Mon, 18 May 2009 13:11:26 -0700
Message-ID: <cover.1242676752.git.joe@perches.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 136-022.dsl.LABridge.com ([206.117.136.22]:1932 "EHLO
	mail.perches.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbZERULc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 May 2009 16:11:32 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Krzysztof Halasa <khc@pm.waw.pl>, Borislav Petkov <petkovbb@gmail.com>

Standardize printk's by mostly mechanical conversions of
printk(KERN_<foo> to pr_<foo>(.  The KERN_DEBUG uses are
not done, deferred until a more standard mechanism exists

Standardize pr_<foo> logging uses of drive->name and hwif->name
to use dev_<foo>.

Signed-off-by: Joe Perches <joe@perches.com>

Joe Perches (2):
  drivers/ide/ide-core: Convert printk(KERN_<foo> to pr_<foo>( without KERN_DEBUG
  drivers/ide/ide-core: Convert pr_<foo> to dev_<foo>

 drivers/ide/ide-acpi.c      |   17 +++----
 drivers/ide/ide-atapi.c     |   67 +++++++++++++--------------
 drivers/ide/ide-dma-sff.c   |    6 +-
 drivers/ide/ide-dma.c       |   28 ++++++------
 drivers/ide/ide-eh.c        |   25 +++++-----
 drivers/ide/ide-io.c        |   16 +++----
 drivers/ide/ide-ioctls.c    |    4 +-
 drivers/ide/ide-iops.c      |    9 ++--
 drivers/ide/ide-legacy.c    |    8 ++--
 drivers/ide/ide-lib.c       |   68 +++++++++++++-------------
 drivers/ide/ide-pm.c        |   11 ++--
 drivers/ide/ide-probe.c     |  108 ++++++++++++++++++++++---------------------
 drivers/ide/ide-proc.c      |   16 +++----
 drivers/ide/ide-scan-pci.c  |    4 +-
 drivers/ide/ide-taskfile.c  |   23 ++++-----
 drivers/ide/ide-xfer-mode.c |    6 +-
 drivers/ide/ide.c           |   25 ++++------
 drivers/ide/setup-pci.c     |   87 +++++++++++++++++-----------------
 18 files changed, 258 insertions(+), 270 deletions(-)

