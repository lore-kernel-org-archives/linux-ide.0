From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 0/4] libata-dev-2.6: pdc2027x PLL input clock detection fix,
 etc.
Date: Mon, 11 Apr 2005 17:57:10 +0800
Message-ID: <425A49F6.3040904@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:13795 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261753AbVDKJ6e (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Apr 2005 05:58:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

Hi Jeff,

    pdc2027x PLL input clock detection fix, etc. for your review.

Desc:
- Patch 1/4 and 2/4 are minor fixes.
- Patch 3/4 move the PLL counter reading code to a separate function.
- Patch 4/4 fix the PLL input clock detection problem.

Albert


