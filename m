From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git pull] IDE fixes
Date: Thu, 5 Mar 2009 17:27:47 +0100
Message-ID: <200903051727.47877.bzolnier@gmail.com>
References: <200903051630.32792.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f168.google.com ([209.85.220.168]:35602 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488AbZCEQ0X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Mar 2009 11:26:23 -0500
In-Reply-To: <200903051630.32792.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 05 March 2009, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> Two bug fixes (for odd-length ATAPI PIO transfers from Sergei Shtylyov
> and for insanely long DMA timeouts from Roel Kluin), some sparse fixes
> (from Hannes Eder) and a new driver for AT91 Static Memory Controller
> with Compact Flash True IDE Mode logic (from Stanislaw Gruszka, arch
> specific part has been acked by a platform maintainer).

Now with <linux/ata.h> change (add CFA identify words for the future use)
from Sergei & Jeff.

> Linus, please pull from:
> 
> master.kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git/
> 
> to receive the following updates:

 arch/arm/mach-at91/at91sam9263_devices.c |  105 +++++++
 arch/arm/mach-at91/include/mach/board.h  |    3 +
 drivers/ide/Kconfig                      |    5 +
 drivers/ide/Makefile                     |    1 +
 drivers/ide/at91_ide.c                   |  467 ++++++++++++++++++++++++++++++
 drivers/ide/ide-disk_proc.c              |    2 +-
 drivers/ide/ide-floppy_proc.c            |    2 +-
 drivers/ide/ide-io.c                     |    3 +-
 drivers/ide/ide-iops.c                   |    2 +
 drivers/ide/ide-probe.c                  |    7 +-
 drivers/ide/ide-proc.c                   |    2 +-
 drivers/ide/ide-tape.c                   |    2 +-
 include/linux/ata.h                      |    2 +
 include/linux/hdreg.h                    |    1 -
 include/linux/ide.h                      |    1 +
 15 files changed, 598 insertions(+), 7 deletions(-)
 create mode 100644 drivers/ide/at91_ide.c


Bartlomiej Zolnierkiewicz (1):
      remove stale comment from <linux/hdreg.h>

Hannes Eder (1):
      ide: NULL noise: drivers/ide/ide-*.c

Roel Kluin (1):
      ide: expiry() returns int, negative expiry() return values won't be noticed

Sergei Shtylyov (2):
      ide-iops: fix odd-length ATAPI PIO transfers
      ata: add CFA specific identify data words

Stanislaw Gruszka (3):
      ide: allow to wrap interrupt handler
      ide: add at91_ide driver
      AT91: initialize Compact Flash on AT91SAM9263 cpu

[...]

diff --git a/include/linux/ata.h b/include/linux/ata.h
index 08a86d5..9a061ac 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -89,6 +89,8 @@ enum {
 	ATA_ID_DLF		= 128,
 	ATA_ID_CSFO		= 129,
 	ATA_ID_CFA_POWER	= 160,
+	ATA_ID_CFA_KEY_MGMT	= 162,
+	ATA_ID_CFA_MODES	= 163,
 	ATA_ID_ROT_SPEED	= 217,
 	ATA_ID_PIO4		= (1 << 1),
 
