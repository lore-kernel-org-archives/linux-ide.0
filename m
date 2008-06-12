From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 07/18] ide-cd: mv ide_do_rw_cdrom ide_cd_do_request
Date: Thu, 12 Jun 2008 08:40:59 +0200
Message-ID: <1213252870-20474-8-git-send-email-petkovbb@gmail.com>
References: <1213252870-20474-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:9230 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753589AbYFLGlH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jun 2008 02:41:07 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2381819fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2008 23:41:06 -0700 (PDT)
In-Reply-To: <1213252870-20474-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

There should be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-cd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 40dab2b..e9d9363 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1211,7 +1211,7 @@ static ide_startstop_t cdrom_do_block_pc(ide_drive_t *drive, struct request *rq)
 /*
  * cdrom driver request routine.
  */
-static ide_startstop_t ide_do_rw_cdrom(ide_drive_t *drive, struct request *rq,
+static ide_startstop_t ide_cd_do_request(ide_drive_t *drive, struct request *rq,
 					sector_t block)
 {
 	ide_startstop_t action;
@@ -1949,7 +1949,7 @@ static ide_driver_t ide_cdrom_driver = {
 	.version		= IDECD_VERSION,
 	.media			= ide_cdrom,
 	.supports_dsc_overlap	= 1,
-	.do_request		= ide_do_rw_cdrom,
+	.do_request		= ide_cd_do_request,
 	.end_request		= ide_end_request,
 	.error			= __ide_error,
 	.abort			= __ide_abort,
-- 
1.5.5.1

