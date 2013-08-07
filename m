From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 2/2] ide: sgiioc4: Staticize ioc4_ide_attach_one()
Date: Wed, 07 Aug 2013 14:17:55 +0900
Message-ID: <002c01ce932d$791b80a0$6b5281e0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:41010 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293Ab3HGFR5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Aug 2013 01:17:57 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MR50074PAPMM770@mailout4.samsung.com> for
 linux-ide@vger.kernel.org; Wed, 07 Aug 2013 14:17:55 +0900 (KST)
Content-language: ko
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "'David S. Miller'" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>

ioc4_ide_attach_one() is used only in this file.
Fix the following sparse warnings:

drivers/ide/sgiioc4.c:603:5: warning: symbol 'ioc4_ide_attach_one' was not declared. Should it be static?

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/ide/sgiioc4.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/sgiioc4.c b/drivers/ide/sgiioc4.c
index a5ca179a..63761db 100644
--- a/drivers/ide/sgiioc4.c
+++ b/drivers/ide/sgiioc4.c
@@ -600,7 +600,7 @@ out:
 	return ret;
 }
 
-int ioc4_ide_attach_one(struct ioc4_driver_data *idd)
+static int ioc4_ide_attach_one(struct ioc4_driver_data *idd)
 {
 	/*
 	 * PCI-RT does not bring out IDE connection.
-- 
1.7.10.4


