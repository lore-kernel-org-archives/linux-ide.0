From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: [PATCH 0/3] Various IDE coding style fixes
Date: Sun, 24 Feb 2008 22:09:32 +0100
Message-ID: <20080224220932.4098443e@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:28624 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895AbYBXVJk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Feb 2008 16:09:40 -0500
Received: by ug-out-1314.google.com with SMTP id z38so542741ugc.16
        for <linux-ide@vger.kernel.org>; Sun, 24 Feb 2008 13:09:38 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

Hi Bart,
three more patches, all are compile tested and against yesterday linux-next

"IDE: Replace __FUNCTION__ with __func__" depends 
on "IDE: Coding Style fixes to drivers/ide/ide-cd.c"


Paolo Ciarrocchi (3):
      IDE: Coding Style fixes to drivers/ide/ide-cd.c
      IDE: Replace __FUNCTION__ with __func__
      IDE: Coding Style fixes to drivers/ide/pci/cy82c693.c

 drivers/ide/ide-cd.c       |  259 +++++++++++++++++++++++---------------------
 drivers/ide/pci/cy82c693.c |   74 +++++++-------
 2 files changed, 171 insertions(+), 162 deletions(-)

Ciao,
              Paolo
