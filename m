From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 0/4] ide: remove ide-scsi remnants
Date: Sun,  7 Dec 2008 18:21:07 +0100
Message-ID: <1228670471-3435-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:63853 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbYLGRVR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Dec 2008 12:21:17 -0500
Received: by mu-out-0910.google.com with SMTP id g7so781709muf.1
        for <linux-ide@vger.kernel.org>; Sun, 07 Dec 2008 09:21:15 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Hi Bart,

here are the patches removing bits and pieces belonging to the late ide-scsi :).

 drivers/ide/ide-atapi.c  |   97 +++++++++++++++++++++++++++++++++++++---------
 drivers/ide/ide-io.c     |    3 +
 drivers/ide/ide-ioctls.c |    3 +-
 drivers/ide/ide-probe.c  |    2 +
 include/linux/ide.h      |   34 ++++++++++------
 5 files changed, 106 insertions(+), 33 deletions(-)
