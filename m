From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 0/4] libata: CHS follow-up patches (revise #6)
Date: Wed, 12 Oct 2005 14:39:10 +0800
Message-ID: <434CAF8E.5040607@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:32974 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932129AbVJLGjU
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Oct 2005 02:39:20 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id j9C6a6U4005663
	for <linux-ide@vger.kernel.org>; Wed, 12 Oct 2005 02:36:06 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j9C6dwtu537078
	for <linux-ide@vger.kernel.org>; Wed, 12 Oct 2005 00:39:58 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j9C6d9Ft013746
	for <linux-ide@vger.kernel.org>; Wed, 12 Oct 2005 00:39:10 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Dear all,

CHS follow-up patches. (Keep sync with the scsi error handling patch. Also added patch 3/4.)

patch 1/4: move the initialization of ATA_TFLAG_LBA and ATA_TFLAG_LBA48 flags to the SCSI translation functions

patch 2/4: calculate read/write commands and protocols on the fly

patch 3/4: reread device identify info after initializing device CHS settings

patch 4/4: LBA28/LBA48 optimization
          (revised to check ending block number per Mark's advice)

Patch against libata-dev upstream branch
(edea3ab58f8edd5f72d31f891ab4f34382e97e3a).

For your review, thanks.

Albert



