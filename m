From: Gwendal Grignou <gwendal@google.com>
Subject: [PATCH] libata: Fix display of sata speed
Date: Fri, 25 Oct 2013 16:28:56 -0700
Message-ID: <1382743737-3516-1-git-send-email-gwendal@google.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yh0-f74.google.com ([209.85.213.74]:55291 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683Ab3JYX27 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Oct 2013 19:28:59 -0400
Received: by mail-yh0-f74.google.com with SMTP id a41so414590yho.1
        for <linux-ide@vger.kernel.org>; Fri, 25 Oct 2013 16:28:59 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, Gwendal Grignou <gwendal@google.com>

I already submitted this patch 2 years ago, but I did not
follow up at that time. [http://www.spinics.net/lists/linux-ide/msg41900.html]
Resend, after cleaning header and fixing a lint error.

Gwendal Grignou (1):
  libata: Fix display of sata speed

 drivers/ata/libata-transport.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

-- 
1.8.4.1

