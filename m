From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 0/3] libata-dev: pdc2027x fixes
Date: Fri, 05 Aug 2005 01:17:50 +0800
Message-ID: <42F24DBE.0@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:35309 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261487AbVHDRUJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 4 Aug 2005 13:20:09 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Jeff,

pdc2027x driver fix:

1/3 pdc1.diff:
     - Convert pdc2027x from PIO to MMIO.

2/3 pdc2.diff:
    - fix the mdelay() problem for IBM power5 micro-partitioning

3/3 pdc3.diff:
    - fix the ATAPI DMA irq lost problem (again)

(diff'ed against libata-dev tree, pdc2027x branch
   b59bb64eca815cab0b21c9761d42c4c78f7ff467)
Tested ok on x86 and ppc64.

For your review, thanks.

Albert


