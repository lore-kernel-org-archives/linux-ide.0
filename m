From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 0/3] libata-dev: pdc2027x fixes
Date: Fri, 12 Aug 2005 15:09:42 +0800
Message-ID: <42FC4B36.9080805@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:5117 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S932204AbVHLHLe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Aug 2005 03:11:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Jeff,

pdc2027x driver fix:

1/3 pdc1.diff:
     - Convert pdc2027x from PIO to MMIO.

2/3 pdc2.diff:
    - use "long" for the counter data type instead of "unsigned long"

3/3 pdc3.diff:
    - pdc2027x ATAPI DMA irq lost problem workaround

(diff'ed against libata-dev tree, pdc2027x branch
   b59bb64eca815cab0b21c9761d42c4c78f7ff467)
Tested ok on x86 and ppc64.

For your review, thanks.

Albert




