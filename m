From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 0/4] ide-tape: remove pipeline functionality-v2
Date: Sun,  9 Mar 2008 18:10:28 +0100
Message-ID: <1205082632-3418-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:59707 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755080AbYCIRKj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Mar 2008 13:10:39 -0400
Received: by ug-out-1314.google.com with SMTP id z38so4732681ugc.16
        for <linux-ide@vger.kernel.org>; Sun, 09 Mar 2008 10:10:38 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Hi Bart,

here are some patches removing the code for adding r/w requests to the pipeline.
Instead, they are being queued straight onto the device request queue now. In
addition, pipeline speed/control calculation has been removed since it becomes
also unused.

 drivers/ide/ide-tape.c |  334 +++++++-----------------------------------------
 1 files changed, 46 insertions(+), 288 deletions(-)
