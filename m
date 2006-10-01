From: Jon Wilson <jon@phuq.co.uk>
Subject: VT8251 sata via controller config in 2.6.18
Date: Sun, 01 Oct 2006 13:09:59 +1000
Message-ID: <451F3187.9060108@phuq.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.adl2.internode.on.net ([203.16.214.181]:3603 "EHLO
	smtp1.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S1750712AbWJADKR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Sep 2006 23:10:17 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Rajahuroman@netscape.net

Thanks for including support for the Via VT8251 SATA controller in 
2.6.18. It seems to be working fine for me.

It apears that all 3 of the following config lines are required:

CONFIG_SCSI_SATA=y
CONFIG_SCSI_SATA_AHCI=y
CONFIG_SCSI_SATA_VIA=y

The controller was only detected if CONFIG_SCSI_SATA_AHCI was selected. 
Perhaps there should be a dependency in the kernel build?

Thanks,

Jon

-- 
Jon Wilson, Sydney, Australia
Mob: +61 4 0549 9490, Yahoo: phuq_eu, Skype: jonwilson


