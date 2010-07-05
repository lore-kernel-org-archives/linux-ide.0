From: Heiko Schocher <hs@denx.de>
Subject: Re: ata, pcmcia: problem with irq and ata_dev_read_id()
Date: Mon, 05 Jul 2010 11:25:45 +0200
Message-ID: <4C31A519.7030806@denx.de>
References: <4C034FAE.9090605@denx.de> <4C044C8F.8050406@gmail.com>
 <4C2833B2.3040209@denx.de> <4C2DFF43.6050502@gmail.com>
 <4C319741.3060602@denx.de> <4C319D31.60705@gmail.com>
Reply-To: hs@denx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a.relay.invitel.net ([62.77.203.3]:42644 "EHLO
	a.relay.invitel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831Ab0GEJZu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jul 2010 05:25:50 -0400
In-reply-to: <4C319D31.60705@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello Tejun,

Tejun Heo wrote:
> On 07/05/2010 10:26 AM, Heiko Schocher wrote:
>> IRQ 26: too many spurious IRQs, disabling and polling for 10k 10msec intervals.
>> IRQ 26: system performance may be affected
>> handlers:
>> [<c0198d00>] (ata_sff_interrupt+0x0/0x204)
> 
> Yeah, that's the new polling code kicking in.  If the IRQ problem
> doesn't persiste (which should be the case here), polling will step
> down after a while and everything will return to normal.  If you keep
> the system running more than ten minutes and use the CF device, does
> the kernel complain anymore?

No, I can use the CF while kernel is in polling mode, also if the
kernel switched back to irq mode:

Log, direct after kernel is up:

[...]
Freeing unused kernel memory: 132k init
-bash-3.2# mount -t vfat /dev/sdb1 /home/hs/mnt
-bash-3.2# cat /proc/uptime
62.08 14.08
-bash-3.2# cat /proc/interrupts
           CPU0
 17:          0   CPM PIC          Level        error
 18:          0   MPC8XX SIU       Level        tbint
 19:        308   CPM PIC          Level        cpm_uart
 21:          4   CPM PIC          Level        mpc8xxx_spi
 22:          0   MPC8XX SIU       Edge         ads7846
 23:      20043   MPC8XX SIU       Level        fs_enet-mac
 24:          0   MPC8XX SIU       Level        m8xx-pcmcia
 25:          9   MPC8XX SIU       Level        pata_pcmcia
 26:      10000   MPC8XX SIU       Level        pata_pcmcia
 27:        129   CPM PIC          Level        cpm_i2c
LOC:       6408   Local timer interrupts
SPU:          0   Spurious interrupts
CNT:          0   Performance monitoring interrupts
MCE:          0   Machine check exceptions
-bash-3.2#

No irq is used.

-bash-3.2# dmesg
[...]
Freeing unused kernel memory: 132k init
IRQ 26: spurious polling finished, reenabling IRQ
-bash-3.2#

Now it is back in irq mode:

-bash-3.2# cat /proc/uptime
419.65 370.56
-bash-3.2#

-bash-3.2# mount -t vfat /dev/sdb1 /home/hs/mnt
-bash-3.2# cat /proc/interrupts
           CPU0
 17:          0   CPM PIC          Level        error
 18:          0   MPC8XX SIU       Level        tbint
 19:        956   CPM PIC          Level        cpm_uart
 21:          4   CPM PIC          Level        mpc8xxx_spi
 22:          0   MPC8XX SIU       Edge         ads7846
 23:      20414   MPC8XX SIU       Level        fs_enet-mac
 24:          0   MPC8XX SIU       Level        m8xx-pcmcia
 25:          9   MPC8XX SIU       Level        pata_pcmcia
 26:      10033   MPC8XX SIU       Level        pata_pcmcia
 27:        129   CPM PIC          Level        cpm_i2c
LOC:      10880   Local timer interrupts
SPU:          0   Spurious interrupts
CNT:          0   Performance monitoring interrupts
MCE:          0   Machine check exceptions
-bash-3.2#

Now it uses the irq ...

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
