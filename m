From: Mourad De Clerck <mourad@aquazul.com>
Subject: nVidia MCP55 SATA hotplug support?
Date: Tue, 11 Mar 2008 15:35:52 +0100
Message-ID: <47D698C8.2020206@aquazul.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gretel.risen.be ([88.198.7.132]:33220 "EHLO gretel.risen.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753539AbYCKOfz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Mar 2008 10:35:55 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I was wondering what the status was of MCP55 hotplug support. To be more
specific, I'm interested in support for this device:

00:05.0 IDE interface [0101]: nVidia Corporation MCP55 SATA Controller
[10de:037f] (rev a3)

I was led to believe by the driver feature matrix (on
http://linux-ata.org/driver-status.html#matrix) that the sata_nv driver
had working hotplug support. After a bit of googling, I found out that
there was at one point a "hotplug polling" patchset by Tejun Heo to
support it - but that was quite a long while ago.

Will we see this appearing in mainline in the (near) future?

Thank you,

-- Mourad DC
