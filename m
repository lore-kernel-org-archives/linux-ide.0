From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 0/3] libata: misc fixes
Date: Wed, 09 Nov 2005 12:57:57 +0800
Message-ID: <437181D5.8070903@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:19085 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965146AbVKIE6V
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 Nov 2005 23:58:21 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jA94wCbF004781
	for <linux-ide@vger.kernel.org>; Tue, 8 Nov 2005 23:58:12 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jA94w8uN059916
	for <linux-ide@vger.kernel.org>; Tue, 8 Nov 2005 21:58:08 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jA94wBYw015877
	for <linux-ide@vger.kernel.org>; Tue, 8 Nov 2005 21:58:11 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>

Dear all,

Misc fixes for libata:

1/3: if condition fix for ata_dev_identify(). 
2/3: move err_mask to ata_queued_cmd
3/3: check qc->err_mask for the internal commands

Patch against the mainline tree 
(0b154bb7d0cce80e9c0bcf11d4f9e71b59409d26).

For your review and advice, thanks.

Albert

