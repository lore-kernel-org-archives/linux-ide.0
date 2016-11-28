From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH] ata: disable port while unloading ATA controller driver
Date: Tue, 29 Nov 2016 01:51:40 +0200
Message-ID: <a498fb9f-822e-45aa-aac1-c7afae7a44e3@mleia.com>
References: <20161127231856.11466-1-vz@mleia.com>
 <20161128183425.GA19096@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:54224 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932414AbcK1Xvp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 28 Nov 2016 18:51:45 -0500
In-Reply-To: <20161128183425.GA19096@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org

Hello Tejun,

On 11/28/2016 08:34 PM, Tejun Heo wrote:
> Hello, Vladimir.
> 
> On Mon, Nov 28, 2016 at 01:18:56AM +0200, Vladimir Zapolskiy wrote:
>> While removing ATA controller driver ata_port_detach() sets 
>> ATA_PFLAG_UNLOADING flag and charges the error handler, however
>> actual port disabling does not happen due to unset
>> ATA_PFLAG_EH_PENDING flag.
>> 
>> To take care about clean port removal and ATA_PFLAG_EH_PENDING
>> flag setting it is sufficient to replace ata_port_schedule_eh()
>> call with ata_port_freeze().
> 
> Hmm... this explanation doesn't really make sense to me. 
> ATA_PFLAG_EH_PENDING is set by at_eh_set_pending() which is the same 
> for both ata_port_schedule_eh() and ata_port_freeze().

correct, ATA_PFLAG_EH_PENDING is set by ata_eh_set_pending(),
you caused me doubt, and my analysis is crap...

> There gotta me something else going on here.  Any chance you can
> track down why EH isn't running?
> 

I've tested the unmodified master branch with a different kernel config
and on another but similar board (SabreSD) powered by the same iMX6Q
SoC, and I can not reproduce this problem, but I still experience it
on the SabreAuto board, I'll trace the kernel on it over JTAG tomorrow.

Sorry for the noise, the reported problem is unlikely related to ATA
subsystem, because in parallel there are some other funny reported
issues like:

  Unable to handle kernel paging request at virtual address 70732f34
  pgd = e5c04000
  [70732f34] *pgd=00000000
  Internal error: Oops: 5 [#1] SMP ARM
  CPU: 3 PID: 218 Comm: udevd Not tainted 4.9.0-rc7 #5
  Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
  task: e6a48c40 task.stack: e5c02000
  PC is at __lock_acquire+0xd8/0x1ba0
  LR is at 0x1

--
With best wishes,
Vladimir
