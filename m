From: "Pierre Tardy" <tardyp@gmail.com>
Subject: [PATCH 2.6.19.1 1/1] ata_piix: ICH6M MAP typo
Date: Thu, 28 Dec 2006 19:20:35 +0100
Message-ID: <826a2b270612281020i1f42dfe7w917cfd5b249692db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.239]:8927 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754914AbWL1SUg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Dec 2006 13:20:36 -0500
Received: by nz-out-0506.google.com with SMTP id s1so2079929nze
        for <linux-ide@vger.kernel.org>; Thu, 28 Dec 2006 10:20:35 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

The map for ich6m chip had a typo, which caused to output a  harmless
error at boot.

Signed-off-by: Pierre Tardy <tardyp@gmail.com>

--- linux-2.6.19.1/drivers/ata/ata_piix.c       2006-12-11
20:32:53.000000000 +0100
+++ linux-2.6.19.1.patched/drivers/ata/ata_piix.c       2006-12-28
00:06:44.000000000 +0100
@@ -405,7 +405,7 @@
         */
        .map = {
                /* PM   PS   SM   SS       MAP */
-               {  P0,  P2,  RV,  RV }, /* 00b */
+               {  P0,  P2,  NA,  NA }, /* 00b */
                { IDE, IDE,  P1,  P3 }, /* 01b */
                {  P0,  P2, IDE, IDE }, /* 10b */
                {  RV,  RV,  RV,  RV },
