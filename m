From: Lin Mac <mkl0301@gmail.com>
Subject: Re: Cannot detect SATA disks w/ CONFIG_SATA_PMP w/o actually using
 SATA multiplier
Date: Wed, 1 Dec 2010 01:46:46 +0800
Message-ID: <AANLkTi=0gBcfrAyJNb0+=obH2QDsqhGM5a9xxwHAoh88@mail.gmail.com>
References: <AANLkTi=kbTcq3hYBiDzGcAb02Ppwb1QEcs12-1W_T=LG@mail.gmail.com>
	<4CF50574.6000706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35738 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941Ab0K3Rqs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Nov 2010 12:46:48 -0500
Received: by fxm8 with SMTP id 8so1394220fxm.19
        for <linux-ide@vger.kernel.org>; Tue, 30 Nov 2010 09:46:46 -0800 (PST)
In-Reply-To: <4CF50574.6000706@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: cbouatmailru@gmail.com, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

2010/11/30 Tejun Heo <htejun@gmail.com>:
> On 11/30/2010 05:02 AM, Lin Mac wrote:
>> Hi,
>>
>> I found that if I enabled CONFIG_SATA_PMP while not using multiplier
>> and connect the disks directly to the board, the disk cannot be foun=
d
>> due to software reset always failed.
>>
>> With arm/cns3xxx
>> linux-2.6.37-rc3
>> ahci-platform driver
>>
>> # modprobe ahci-platform
>> [ =A0 12.790000] ahci ahci.0: forcing PORTS_IMPL to 0x3
>> [ =A0 12.800000] ahci ahci.0: AHCI 0001.0100 32 slots 2 ports 3 Gbps=
 0x3
>> impl platform mode
>> [ =A0 12.810000] ahci ahci.0: flags: ncq sntf pm led clo only pmp pi=
o
>> slum part ccc
>> [ =A0 12.850000] scsi0 : ahci_platform
>> [ =A0 12.860000] scsi1 : ahci_platform
>> [ =A0 12.870000] ata1: SATA max UDMA/133 irq_stat 0x00400040, connec=
tion
>> status changed irq 65
>> [ =A0 12.880000] ata2: SATA max UDMA/133 mmio [mem
>> 0x83000000-0x83ffffff] port 0x180 irq 65
>> [ =A0 13.240000] ata2: SATA link down (SStatus 0 SControl 300)
>> [ =A0 18.900000] ata1: link is slow to respond, please be patient (r=
eady=3D0)
>> [ =A0 22.930000] ata1: softreset failed (device not ready)
>> [ =A0 28.940000] ata1: link is slow to respond, please be patient (r=
eady=3D0)
>> [ =A0 32.970000] ata1: softreset failed (device not ready)
>> [ =A0 38.980000] ata1: link is slow to respond, please be patient (r=
eady=3D0)
>> [ =A0 68.030000] ata1: softreset failed (device not ready)
>> [ =A0 68.040000] ata1: limiting SATA link speed to 1.5 Gbps
>> [ =A0 70.280000] ata1: SATA link down (SStatus 1 SControl 310)
>>
>> With some debug, ahci_check_ready always get PORT_TFDATA(20)=3D0x1d0
>>
>> While using multiplier with CONFIG_SATA_PMP enabled, or using disks
>> directly without CONFIG_SATA_PMP have no issue.
>> After some googling, it seems common and the only fix is to disable
>> CONFIG_SATA_PMP.
>> So, before I keep on going, I would like to know whether this is a
>> limitation, or a bug?
> Most likely a quirk in the controller. =A0Maybe we should disable PMP
> support for it?
Could be,  but disabling it is the last option. And it's anoying to
have 2 different modules for different uses.

I'd prefer some clues/checkpoint if possible.
I supposed the behavior of detecting and resetting disks (without
using port multiplier) should be the same for both with and without
CONFIG_SATA_PMP. All I know about port multiplier is when it is used
(not much too), but is there any register configuration or behavior is
required for multiplier to work properly and take effect even when no
multiplier is used?

Best Regards,
Mac Lin
