From: "linux" <linux@highpoint-tech.com>
Subject: Question about HighPoint RocketRAID 642L SCSI driver conflict with Linux AHCI driver
Date: Thu, 4 Jun 2015 13:05:49 +0800
Message-ID: <002a01d09e84$22be8f90$683baeb0$@highpoint-tech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp89.ord1c.emailsrvr.com ([108.166.43.89]:54010 "EHLO
	smtp89.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750761AbbFDFFr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Jun 2015 01:05:47 -0400
Content-Language: zh-cn
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Dear Tejun Heo,

  This is HighPoint Linux Team. We found Linux AHCI driver since kernel 3.16
has added ID (0x06421103) to support RocketRAID 642L which is not what we
expected. If we want to load HighPoint RR642L RAID version Linux SCSI
driver, it becomes conflict each other. This affects our customers who need
to use our RAID version driver stack.
  
  Hence,  this is to ask Linux how to solve this conflict with AHCI driver?
and why Linux wants to add RR642L ID (0x06421103) into AHCI driver? Is there
any way to prevent this in the future?

Best Regards,
HighPoint Linux Team

