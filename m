From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: IRQ re-disabled when SATAPI via CONFIG_BLK_DEV_IDE_SATA
Date: Wed, 18 Aug 2004 01:38:45 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4122EB65.9020009@pobox.com>
References: <1092774469.4599.4.camel@patlinux.iomegacorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65202 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268633AbUHRFi7
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Aug 2004 01:38:59 -0400
In-Reply-To: <1092774469.4599.4.camel@patlinux.iomegacorp.com>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Pat LaVarre wrote:
> Jeff G:
> 
> By the way,
> 
> I see the following dmesg repeat often, like once per open of the
> device, if I connect SATAPI in 2.6.8.1 via CONFIG_BLK_DEV_IDE_SATA.
> 
> kernel: irq 18: nobody cared!
> kernel:  [<c010822b>] __report_bad_irq+0x2a/0x8b
> kernel:  [<c0108315>] note_interrupt+0x6f/0x9f
> kernel:  [<c01086a8>] do_IRQ+0x1d4/0x226
> kernel:  [<c0103cbe>] default_idle+0x0/0x2d
> kernel:  [<c0106800>] common_interrupt+0x18/0x20
> kernel:  [<c0103cbe>] default_idle+0x0/0x2d
> kernel:  [<c0103ce8>] default_idle+0x2a/0x2d
> kernel:  [<c0103d5c>] cpu_idle+0x37/0x40
> kernel:  [<c0451885>] start_kernel+0x1b0/0x201
> kernel:  [<c045130a>] unknown_bootoption+0x0/0x16f
> kernel: handlers:
> kernel: [<c0249b12>] (ide_intr+0x0/0x1d1)
> kernel: Disabling IRQ #18
> 
> I recognise this "disabling IRQ" message from the history of libata.ko
> development, where I more often saw it once and then immediately a
> kernel crash.

See 'ide_intr' in there?  we need to teach the IDE driver about the 
ICH5's weird interrupt acknowledgment stuff.

Alternative is to get ATAPI working in libata, then we can do PATA under 
libata as well, which resolves this problem.

	Jeff



