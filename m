From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 00/03] ide misc leftovers
Date: Thu, 20 Nov 2008 06:41:20 +0100
Message-ID: <1227159683-2487-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:46733 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754075AbYKTFlX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Nov 2008 00:41:23 -0500
Received: by fk-out-0910.google.com with SMTP id 18so315254fkq.5
        for <linux-ide@vger.kernel.org>; Wed, 19 Nov 2008 21:41:21 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Bart,

here is Linus' reworked ide-floppy reduce-stack-usage patch. It has been tested
here on current pata tree with your latest 3 patches adding the per-device
request queue locks. Along with that are 2 small cleanups.


 drivers/ide/ide-cd.c           |    8 +++++
 drivers/ide/ide-cd.h           |    8 -----
 drivers/ide/ide-floppy.c       |   26 +++++++++---------
 drivers/ide/ide-floppy_ioctl.c |   58 +++++++++++++++++++--------------------
 include/linux/ide.h            |   48 ++++++++++++++++----------------
 5 files changed, 73 insertions(+), 75 deletions(-)
