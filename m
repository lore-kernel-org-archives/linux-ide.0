From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH] ata: disable port while unloading ATA controller driver
Date: Tue, 29 Nov 2016 20:54:11 +0200
Message-ID: <09c7866c-ecd4-f48a-5112-6cf3c6786cd9@mleia.com>
References: <20161127231856.11466-1-vz@mleia.com>
 <20161128183425.GA19096@htj.duckdns.org>
 <a498fb9f-822e-45aa-aac1-c7afae7a44e3@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:57342 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751979AbcK2SyP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 29 Nov 2016 13:54:15 -0500
In-Reply-To: <a498fb9f-822e-45aa-aac1-c7afae7a44e3@mleia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org

Hello Tejun,

On 11/29/2016 01:51 AM, Vladimir Zapolskiy wrote:
> Hello Tejun,
> 
> On 11/28/2016 08:34 PM, Tejun Heo wrote:
>> Hello, Vladimir.
>>
>> On Mon, Nov 28, 2016 at 01:18:56AM +0200, Vladimir Zapolskiy wrote:
>>> While removing ATA controller driver ata_port_detach() sets 
>>> ATA_PFLAG_UNLOADING flag and charges the error handler, however
>>> actual port disabling does not happen due to unset
>>> ATA_PFLAG_EH_PENDING flag.
>>>
>>> To take care about clean port removal and ATA_PFLAG_EH_PENDING
>>> flag setting it is sufficient to replace ata_port_schedule_eh()
>>> call with ata_port_freeze().
>>
>> Hmm... this explanation doesn't really make sense to me. 
>> ATA_PFLAG_EH_PENDING is set by at_eh_set_pending() which is the same 
>> for both ata_port_schedule_eh() and ata_port_freeze().
> 
> correct, ATA_PFLAG_EH_PENDING is set by ata_eh_set_pending(),
> you caused me doubt, and my analysis is crap...
> 
>> There gotta me something else going on here.  Any chance you can
>> track down why EH isn't running?
>>
> 
> I've tested the unmodified master branch with a different kernel config
> and on another but similar board (SabreSD) powered by the same iMX6Q
> SoC, and I can not reproduce this problem, but I still experience it
> on the SabreAuto board, I'll trace the kernel on it over JTAG tomorrow.
> 

tracing on the board shows a race between driver initialization and
deinitialization, when async_port_probe() is scheduled after driver
removal, this causes the reported problem.

Since it is a race, it should be possible to fuzz the kernel by
introducing a delay (e.g. in ata_port_probe()) to get enough time
to reproduce the problem reliably and to verify a fix.

imx_ahci_probe()
  ahci_platform_init_host()
    ata_host_alloc_pinfo()
      ata_host_alloc()
        ata_port_alloc()    ---> sets ATA_PFLAG_INITIALIZING flag
          ata_link_init()
          ....
    ahci_host_activate()
      ata_host_activate()
        ata_host_start()
          ata_eh_freeze_port()
        ata_port_desc()
        ata_host_register() ---> schedules async_port_probe()
  ....

*** at this point the driver probe is completed, thus it can be removed ***

ata_platform_remove_one()    ==  imx_ahci_driver.remove()
  ata_port_detach()
    ata_port_schedule_eh()
      ata_std_sched_eh()    ---> return, ATA_PFLAG_EH_PENDING flag is not set
    ata_port_wait_eh()      ---> return, port cleanup work is not done

*** warning is printed out ***

async_port_probe()          ---- scheduled too late
  ata_port_probe()
    __ata_port_probe()      ---> now ATA_PFLAG_INITIALIZING flag unset
      ata_port_schedule_eh()
        ata_std_sched_eh()


It also explains why ata_port_schedule_eh() inside ata_port_detach()
replaced by ata_port_abort() with unconditional ATA_PFLAG_EH_PENDING
flag setting does not produce the warning, but still I'm not sure
that resource and state clean-ups are done correctly under the race.

If you buy this analysis sketch, it may take another day or two for
me to prepare a proper fix, or, if you have enough time and desire,
you may implement the fix on your own.

--
With best wishes,
Vladimir

