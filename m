From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC] AHCI Command Completion Coalescing(CCC) proposal
Date: Thu, 08 Jun 2006 11:01:02 -0400
Message-ID: <44883BAE.7070406@pobox.com>
References: <1149751860.29552.79.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41164 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964857AbWFHPBK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Jun 2006 11:01:10 -0400
In-Reply-To: <1149751860.29552.79.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: htejun@gmail.com, linux-ide@vger.kernel.org

zhao, forrest wrote:
> Hello, all
> 
> 0 Why this RFC?
> Although AHCI spec 1.1 provides a detailed explanation about how to play
> with CCC-related registers to enable CCC, several CCC-policy-related
> parameters need to be defined(or the consensus need to be achieved)
> before we start to write the code.

To brag a bit, I pushed Intel heavily for this feature, in the 
pre-AHCI-1.0 development days.


>>From my understanding, the measurement of "IRQ numbers per second"
> should be based on per-port instead of all ports of a SATA controller.

No, it should be all ports of a SATA controller.

If an interrupt arrives while CCC is active, we should take the 
opportunity to check all ports for activity -- as the standard code does 
now.


> 4 What should the software specified timeout be?
> I don't have the strong reasoning of a specific timeout value. 500ms? or
> 1000ms? We should trade-off between the delay and overhead.

500ms is a lot of latency.

	Jeff


