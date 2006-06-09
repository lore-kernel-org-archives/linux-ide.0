From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC] AHCI Command Completion Coalescing(CCC) proposal
Date: Thu, 08 Jun 2006 23:30:18 -0400
Message-ID: <4488EB4A.4050501@pobox.com>
References: <1149751860.29552.79.camel@forrest26.sh.intel.com>	 <44883BAE.7070406@pobox.com> <1149820043.5721.7.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37604 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751327AbWFIDaX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Jun 2006 23:30:23 -0400
In-Reply-To: <1149820043.5721.7.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: htejun@gmail.com, linux-ide@vger.kernel.org

zhao, forrest wrote:
> On Thu, 2006-06-08 at 11:01 -0400, Jeff Garzik wrote: 
>>> >From my understanding, the measurement of "IRQ numbers per second"
>>> should be based on per-port instead of all ports of a SATA controller.
>> No, it should be all ports of a SATA controller.
> 
> Maybe I didn't state my ideas clearly. Let me explain it by an example.
> 
> 1 Assume there are 2 active ports(P0 and P1) on a system, they all run
> under non-NCQ mode
> 2 During a certain period, P0 is heavily loaded, which generates >1000
> interrupts per second; P1 is idle, which generates no interrupt
> 3
> 3.1 If the measurement of "IRQ numbers per second" is based on all
> active ports of a SATA controller, CCC is activated by CCC_PORTS being
> set to 0x3, CCC_CTL.CC being set to 64(32*2). Then the problem comes:
> the CCC interrupt will be raised only when the timeout expires, this is
> because P1 is in idle, thus hCccComplete can never be greater than or
> equal to 64, the maximum of hCccComplete is 32.
> 3.2 If the measurement of "IRQ numbers per second" is based on per-port,
> we can know that P0 is heavily-loaded, then CCC is activated by
> CCC_PORTS being set to 0x1, CCC_CTL.CC being set to 32. Then CCC can
> take effect as we have expected :)
> NOTE: hCccComplete is the term used in section 11 of AHCI spec1.1

I'm still not sure I follow you?

When AHCI runs out of commands to execute, it transitions from H:Idle to 
Ccc:SetIS.

IMPORTANT NOTE:  In order for CCC to be effective on AHCI, ahci.c and 
libata (and sata_sil24) must be updated to support queuing a list of 
non-NCQ commands onto the controller, and recovering from errors in the 
case where a command list full of non-NCQ commands is present.

Also, you should scale up CCC_CTL.CC really based on "commands in 
flight" across all ports.

	Jeff



