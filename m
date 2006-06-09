From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [RFC] AHCI Command Completion Coalescing(CCC) proposal
Date: Fri, 09 Jun 2006 10:27:22 +0800
Message-ID: <1149820043.5721.7.camel@forrest26.sh.intel.com>
References: <1149751860.29552.79.camel@forrest26.sh.intel.com>
	 <44883BAE.7070406@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2167 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751356AbWFICu4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Jun 2006 22:50:56 -0400
In-Reply-To: <44883BAE.7070406@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: htejun@gmail.com, linux-ide@vger.kernel.org

On Thu, 2006-06-08 at 11:01 -0400, Jeff Garzik wrote: 
> >>From my understanding, the measurement of "IRQ numbers per second"
> > should be based on per-port instead of all ports of a SATA controller.
> 
> No, it should be all ports of a SATA controller.

Maybe I didn't state my ideas clearly. Let me explain it by an example.

1 Assume there are 2 active ports(P0 and P1) on a system, they all run
under non-NCQ mode
2 During a certain period, P0 is heavily loaded, which generates >1000
interrupts per second; P1 is idle, which generates no interrupt
3
3.1 If the measurement of "IRQ numbers per second" is based on all
active ports of a SATA controller, CCC is activated by CCC_PORTS being
set to 0x3, CCC_CTL.CC being set to 64(32*2). Then the problem comes:
the CCC interrupt will be raised only when the timeout expires, this is
because P1 is in idle, thus hCccComplete can never be greater than or
equal to 64, the maximum of hCccComplete is 32.
3.2 If the measurement of "IRQ numbers per second" is based on per-port,
we can know that P0 is heavily-loaded, then CCC is activated by
CCC_PORTS being set to 0x1, CCC_CTL.CC being set to 32. Then CCC can
take effect as we have expected :)
NOTE: hCccComplete is the term used in section 11 of AHCI spec1.1

> > 4 What should the software specified timeout be?
> > I don't have the strong reasoning of a specific timeout value. 500ms? or
> > 1000ms? We should trade-off between the delay and overhead.
> 
> 500ms is a lot of latency.

I'll use 100ms as timeout value in the code.

Thanks,
Forrest
