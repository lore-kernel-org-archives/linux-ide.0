From: Kevin Hilman <khilman@mvista.com>
Subject: PCI SATA controllers on embedded, no-BIOS targets
Date: Tue, 22 Aug 2006 09:37:56 -0700
Message-ID: <44EB32E4.8080706@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:59635 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1750980AbWHVQh5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Aug 2006 12:37:57 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Deepak Saxena <dsaxena@mvista.com>

I have a Silicon Images 3112 PCI card on an XScale IXP425 platform.  The 
card works well in a PC, but I haven't got it to work in on the ARM 
platform.  On the PC, I see the cards BIOS executed and am guessing that 
since this can't happen on the ARM, that's why things aren't working.

The card is at least detected on the ARM, and the driver tries to probe 
for devices, but times out an moves on.

Before I debug this too deeply, I want to make sure this should work on 
embedded boards, even without the BIOS execution.

Thanks,
Kevin
