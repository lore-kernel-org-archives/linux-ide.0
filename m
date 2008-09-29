From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 0/3] ide-cd: debug log enhancements
Date: Mon, 29 Sep 2008 08:29:56 +0200
Message-ID: <1222669799-6565-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:55784 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbYI2GaF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Sep 2008 02:30:05 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1325407fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 28 Sep 2008 23:30:03 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Hi Bart,

here are some trivial enhancements to ide-cd which resulted from the debugging
sessions lately.

 drivers/ide/ide-cd.c |   44 ++++++++++++++++++++++++++------------------
 1 files changed, 26 insertions(+), 18 deletions(-)
