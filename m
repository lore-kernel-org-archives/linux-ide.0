From: Chris Hann <chann94501@yahoo.com>
Subject: hdregs.h puts csfo at word 129 - wrong, that's vendor specific
Date: Thu, 24 Mar 2005 17:28:31 -0800
Message-ID: <4243693F.9090008@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from [65.115.69.195] ([65.115.69.195]:35254 "EHLO mx.sj.symbol.com")
	by vger.kernel.org with ESMTP id S261378AbVCYB2q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Mar 2005 20:28:46 -0500
Received: from gwianameserver.sj.symbol.com (gwianameserver.sj.symbol.com [157.235.95.252])
	by mx.sj.symbol.com (8.12.10/8.12.10) with ESMTP id j2P1JvDq019156
	for <linux-ide@vger.kernel.org>; Thu, 24 Mar 2005 17:19:57 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide list <linux-ide@vger.kernel.org>

ide-disk.c checks csfo bit 0 to see if the cache is available on a device
hdregs.h maps csfo to word 129 of the Identify Device information
the latest ATA documentation, e00159r3 Mandatory IDENTIFY DEVICE 
information, says words 129-159 are Vendor specific.

Why is the driver switching on cache operations based on a word that has 
nothing to do with cache?

My previous attempt was obviously too long?

Chris



