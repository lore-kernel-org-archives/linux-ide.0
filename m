From: Gary Poppitz <poppitzg@iomega.com>
Subject: Sata_promise.c queries
Date: Wed, 9 Feb 2005 08:51:47 -0700
Message-ID: <8142CBF3-7AB2-11D9-A80A-000A95D2AC6A@iomega.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Received: from email-mx1.iomega.com ([147.178.1.72]:16547 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S261836AbVBIPtw
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Feb 2005 10:49:52 -0500
Received: from emailmx0.iomega.com (hubble [147.178.1.70])
	by email.iomega.com (Postfix) with ESMTP id F0B0C2092
	for <linux-ide@vger.kernel.org>; Wed,  9 Feb 2005 08:49:51 -0700 (MST)
Received: from royntex01.iomegacorp.com (unknown [147.178.90.120])
	by emailmx0.iomega.com (Postfix) with ESMTP id E650F6D8
	for <linux-ide@vger.kernel.org>; Wed,  9 Feb 2005 15:49:51 +0000 (UTC)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

First off, I have the libdata-2.6 pull.

The version of sata_promise.c is 1.58 .

Is this the latest one available?


Next question, in function pdc_qc_issue_prot, there is a BUG() call in 
the case of
ATA_PROT_ATAPI_DMA.

Is this one of those "fixme"s that will be addressed Real Soon Now, or 
is this an actual error that I am hitting. Naturally, the device I am 
using wants to do ATAPI DMA.


Gary Poppitz
Iomega

