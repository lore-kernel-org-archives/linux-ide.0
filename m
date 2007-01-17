From: Brian King <brking@linux.vnet.ibm.com>
Subject: [PATCH 3/3] libata: Initialize qc->pad_len
Date: Wed, 17 Jan 2007 12:32:28 -0600
Message-ID: <200701171832.l0HIWSWv010933@d03av03.boulder.ibm.com>
References: <11690587311891-patch-mail.ibm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:53662 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932623AbXAQSca (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Jan 2007 13:32:30 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0HIWUDx001056
	for <linux-ide@vger.kernel.org>; Wed, 17 Jan 2007 13:32:30 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l0HIWT81540154
	for <linux-ide@vger.kernel.org>; Wed, 17 Jan 2007 11:32:29 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l0HIWTWT010984
	for <linux-ide@vger.kernel.org>; Wed, 17 Jan 2007 11:32:29 -0700
In-Reply-To: <11690587311891-patch-mail.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, htejun@gmail.com, brking@linux.vnet.ibm.com


Initialize qc->pad_len for each new command. This ensures
that pad_len is not set to a stale value for zero data
length commands.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 linux-2.6-bjking1/include/linux/libata.h |    1 +
 1 files changed, 1 insertion(+)

diff -puN include/linux/libata.h~libata_init_pad_len include/linux/libata.h
--- linux-2.6/include/linux/libata.h~libata_init_pad_len	2007-01-17 11:15:30.000000000 -0600
+++ linux-2.6-bjking1/include/linux/libata.h	2007-01-17 11:15:30.000000000 -0600
@@ -1151,6 +1151,7 @@ static inline void ata_qc_reinit(struct 
 	qc->nbytes = qc->curbytes = 0;
 	qc->n_elem = 0;
 	qc->err_mask = 0;
+	qc->pad_len = 0;
 
 	ata_tf_init(qc->dev, &qc->tf);
 
_
