From: Shan Hai <shan.hai@windriver.com>
Subject: [PATCH 0/2] -- Fix block layer hang on writing DVD
Date: Mon, 18 Mar 2013 10:30:42 +0800
Message-ID: <1363573844-12729-1-git-send-email-shan.hai@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:55986 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941Ab3CRCbB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Mar 2013 22:31:01 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org


In this patch set:
Fix a bug which erroneously changed return type of a function in
include/linux/ata.h: 
Introduce a workaround for Slimtype DVD A  DS8A8SH drive lock up problem.

drivers/ata/libata-core.c |    4 ++++
 include/linux/ata.h       |    2 +-
 include/linux/libata.h    |    1 +
 3 files changed, 6 insertions(+), 1 deletions(-)

Thanks
Shan Hai

