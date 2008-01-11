From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 08/21] ide-floppy: remove struct idefloppy_inquiry_result
Date: Fri, 11 Jan 2008 12:58:06 +0100
Message-ID: <1200052699-28420-9-git-send-email-bbpetkov@yahoo.de>
References: <1200052699-28420-1-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-2-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-3-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-4-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-5-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-6-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-7-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-8-git-send-email-bbpetkov@yahoo.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp113.plus.mail.re1.yahoo.com ([69.147.102.76]:39726 "HELO
	smtp113.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758757AbYAKMDg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jan 2008 07:03:36 -0500
In-Reply-To: <1200052699-28420-8-git-send-email-bbpetkov@yahoo.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej@gollum.tnic, Zolnierkiewicz@gollum.tnic, bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <bbpetkov@yahoo.de>

Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
---
 drivers/ide/ide-floppy.c |   41 -----------------------------------------
 1 files changed, 0 insertions(+), 41 deletions(-)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 5c85833..d98264e 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -232,47 +232,6 @@ struct idefloppy_id_gcw {
 };
 
 /*
- *	INQUIRY packet command - Data Format
- */
-typedef struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-	unsigned	device_type	:5;	/* Peripheral Device Type */
-	unsigned	reserved0_765	:3;	/* Peripheral Qualifier - Reserved */
-	unsigned	reserved1_6t0	:7;	/* Reserved */
-	unsigned	rmb		:1;	/* Removable Medium Bit */
-	unsigned	ansi_version	:3;	/* ANSI Version */
-	unsigned	ecma_version	:3;	/* ECMA Version */
-	unsigned	iso_version	:2;	/* ISO Version */
-	unsigned	response_format :4;	/* Response Data Format */
-	unsigned	reserved3_45	:2;	/* Reserved */
-	unsigned	reserved3_6	:1;	/* TrmIOP - Reserved */
-	unsigned	reserved3_7	:1;	/* AENC - Reserved */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-	unsigned	reserved0_765	:3;	/* Peripheral Qualifier - Reserved */
-	unsigned	device_type	:5;	/* Peripheral Device Type */
-	unsigned	rmb		:1;	/* Removable Medium Bit */
-	unsigned	reserved1_6t0	:7;	/* Reserved */
-	unsigned	iso_version	:2;	/* ISO Version */
-	unsigned	ecma_version	:3;	/* ECMA Version */
-	unsigned	ansi_version	:3;	/* ANSI Version */
-	unsigned	reserved3_7	:1;	/* AENC - Reserved */
-	unsigned	reserved3_6	:1;	/* TrmIOP - Reserved */
-	unsigned	reserved3_45	:2;	/* Reserved */
-	unsigned	response_format :4;	/* Response Data Format */
-#else
-#error "Bitfield endianness not defined! Check your byteorder.h"
-#endif
-	u8		additional_length;	/* Additional Length (total_length-4) */
-	u8		rsv5, rsv6, rsv7;	/* Reserved */
-	u8		vendor_id[8];		/* Vendor Identification */
-	u8		product_id[16];		/* Product Identification */
-	u8		revision_level[4];	/* Revision Level */
-	u8		vendor_specific[20];	/* Vendor Specific - Optional */
-	u8		reserved56t95[40];	/* Reserved - Optional */
-						/* Additional information may be returned */
-} idefloppy_inquiry_result_t;
-
-/*
  *	REQUEST SENSE packet command result - Data Format.
  */
 typedef struct {
-- 
1.5.3.7

