From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: [PATCH 0/6] IDE: new series of Coding Style Fixes
Date: Sat, 23 Feb 2008 18:38:12 +0100
Message-ID: <20080223183812.5af6d36d@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:60686 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244AbYBWRiS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Feb 2008 12:38:18 -0500
Received: by fg-out-1718.google.com with SMTP id e21so632002fga.17
        for <linux-ide@vger.kernel.org>; Sat, 23 Feb 2008 09:38:16 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

Bart,
here is a new series of patches that remove some errors
and warnings reported by checkpatch.pl from the IDE subsystem.

All the patches have been compile tested and are against this morning (CET time :-)
linux-next

Paolo Ciarrocchi (6):
      IDE: Coding Style fixes to drivers/ide/pci/opti621.c
      IDE: Coding Style fixes to drivers/ide/legacy/hd.c
      IDE: Coding Style fixes to drivers/ide/legacy/ali14xx.c
      IDE: Coding Style fixes to drivers/ide/pci/it8213.c
      IDE: Coding Style fixes to drivers/ide/ide-floppy.c
      IDE: Coding Style fixes to drivers/ide/pci/cmd640.c

 drivers/ide/ide-floppy.c     |    4 +-
 drivers/ide/legacy/ali14xx.c |   11 +++--
 drivers/ide/legacy/hd.c      |   79 ++++++++++++++++++------------------
 drivers/ide/pci/cmd640.c     |   90 +++++++++++++++++++++---------------------
 drivers/ide/pci/it8213.c     |    9 ++--
 drivers/ide/pci/opti621.c    |   50 ++++++++++++------------
 6 files changed, 122 insertions(+), 121 deletions(-)

Ciao,
                Paolo
