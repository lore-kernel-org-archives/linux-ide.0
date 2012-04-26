From: Gwendal Grignou <gwendal@google.com>
Subject: Re: Hotplug borked after suspend/resume in Linux-3.3 ?
Date: Thu, 26 Apr 2012 17:29:12 +0800
Message-ID: <CAMHSBOXFEEgL31K+OFOY9bXtbCvHBBeKN-VdznpA3UekaFqGdw@mail.gmail.com>
References: <4F8DD4DC.4050503@teksavvy.com>
	<4F8DD708.8050502@teksavvy.com>
	<4F8DD834.5070000@teksavvy.com>
	<4F8DDA53.206@teksavvy.com>
	<CAE5mzvjsfX34fod0KURNQN8Rmn0xOPCdP2iY2xnSTnnRXPAaEQ@mail.gmail.com>
	<4F8EF57E.4070603@fold.natur.cuni.cz>
	<4F8EF9F7.5040202@pobox.com>
	<4F8EFD89.2080603@fold.natur.cuni.cz>
	<4F8F08D7.6050809@fold.natur.cuni.cz>
	<CAF1ivSYqzjv10F+sdYkR_jdTZvzKP1=_ZwgNDj2njnmb6uaenA@mail.gmail.com>
	<1334823362.11188.172.camel@minggr>
	<CANEJEGuPG1yAwZ0xwQcbfnTghs7cnnJ2=NLpxMEVuFd0H7KStA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53185 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753Ab2DZJ3N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Apr 2012 05:29:13 -0400
Received: by iadi9 with SMTP id i9so1328838iad.19
        for <linux-ide@vger.kernel.org>; Thu, 26 Apr 2012 02:29:12 -0700 (PDT)
In-Reply-To: <CANEJEGuPG1yAwZ0xwQcbfnTghs7cnnJ2=NLpxMEVuFd0H7KStA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>, Jeff Garzik <jgarzik@pobox.com>, cwillu <cwillu@cwillu.com>, Mark Lord <kernel@teksavvy.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Grant Grundler <grundler@google.com>

Lin,

In the patch d9027470b88631d0956ac37cdadfdeb9cdcf2c99, I did limit the
amount of data cleaning in some of the ata objects.

If setting err_mask to 0 masks the regression I introduced in the
patch, I may have altered too much how ata_device object is
reinitialized when a device is found. I am digging deeper, I may have
change the code to try to preserve the ering as much as possible.

Concerning your patch, isn't adding a test (ent->eflags &
ATA_EFLAG_OLD_ER) in ata_count_probe_trials_cb() more in line with
speed_down_verdict_cb() code?

Gwendal.

On Fri, Apr 20, 2012 at 10:37 AM, Grant Grundler <grundler@google.com> =
wrote:
> On Thu, Apr 19, 2012 at 1:16 AM, Lin Ming <ming.m.lin@intel.com> wrot=
e:
> ...
>> I did bisect and found that this is a really old regression introduc=
ed
>> in 2.6.37-rc1 with below commit.
>>
>> commit d9027470b88631d0956ac37cdadfdeb9cdcf2c99
>> Author: Gwendal Grignou <gwendal@google.com>
>> Date: =A0 Tue May 25 12:31:38 2010 -0700
>>
>> =A0 =A0[libata] Add ATA transport class
>>
>> =A0 =A0This is a scheleton for libata transport class.
>> =A0 =A0All information is read only, exporting information from liba=
ta:
>> =A0 =A0- ata_port class: one per ATA port
>> =A0 =A0- ata_link class: one per ATA port or 15 for SATA Port Multip=
lier
>> =A0 =A0- ata_device class: up to 2 for PATA link, usually one for SA=
TA.
>>
>> =A0 =A0Signed-off-by: Gwendal Grignou <gwendal@google.com>
>> =A0 =A0Reviewed-by: Grant Grundler <grundler@google.com>
>> =A0 =A0Signed-off-by: Jeff Garzik <jgarzik@redhat.com>
>>
>>
>> Here is the patch to fix it.
>>
>> Gwendal and Grant,
>>
>> Would you help to review it?
>>
>>
>> From f696daec7ff63e9b3697e8f7ef8f985152667965 Mon Sep 17 00:00:00 20=
01
>> From: Lin Ming <ming.m.lin@intel.com>
>> Date: Thu, 19 Apr 2012 15:45:51 +0800
>> Subject: [PATCH] libata: clear error mask of old error history
>>
>> The old error history was cleared in ata_ering_clear().
>> It only sets ATA_EFLAG_OLD_ER eflags, but the err_mask was not clear=
ed.
>> So ata_ering_map() still iterates the old error history.
>>
>> This causes problem, for example, wrong probe trials count were retu=
rned in
>> ata_eh_schedule_probe(), which in turn causes SATA link speed to be =
slowed down
>> to 1.5Gbps.
>>
>> Reported-by: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
>> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
>
> Reviewed-by: Grant Grundler <grundler@google.com>
>
> LGTM. Caveat is I have looked at libata code only once or twice since
> reviewing this patch for Gwendal.
>
> cheers,
> grant
>
>> ---
>> =A0drivers/ata/libata-eh.c | =A0 =A03 ++-
>> =A01 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>> index c61316e..4c6f49b 100644
>> --- a/drivers/ata/libata-eh.c
>> +++ b/drivers/ata/libata-eh.c
>> @@ -419,9 +419,10 @@ int ata_ering_map(struct ata_ering *ering,
>> =A0 =A0 =A0 =A0return rc;
>> =A0}
>>
>> -int ata_ering_clear_cb(struct ata_ering_entry *ent, void *void_arg)
>> +static int ata_ering_clear_cb(struct ata_ering_entry *ent, void *vo=
id_arg)
>> =A0{
>> =A0 =A0 =A0 =A0ent->eflags |=3D ATA_EFLAG_OLD_ER;
>> + =A0 =A0 =A0 ent->err_mask =3D 0;
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>>
>> --
>> 1.7.2.5
>>
>>
>>
>>>
>>> [ =A0146.876489] ata6: exception Emask 0x10 SAct 0x0 SErr 0x4050000=
 action 0xe frozen
>>> [ =A0146.876499] ata6: irq_stat 0x00400040, connection status chang=
ed
>>> [ =A0146.876508] ata6: SError: { PHYRdyChg CommWake DevExch }
>>> [ =A0146.876527] ata6: hard resetting link
>>> [ =A0147.619956] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl =
300)
>>> [ =A0147.869349] ata6.00: ATA-8: ST3000DM001-9YN166, CC4C, max UDMA=
/133
>>> [ =A0147.869360] ata6.00: 5860533168 sectors, multi 0: LBA48 NCQ (d=
epth 31/32), AA
>>> [ =A0147.870126] ata6.00: configured for UDMA/133
>>> [ =A0147.870131] ata6: EH complete
>>> [ =A0147.870220] scsi 5:0:0:0: Direct-Access =A0 =A0 ATA =A0 =A0 =A0=
ST3000DM001-9YN1 CC4C PQ: 0 ANSI: 5
>>> [ =A0147.870391] sd 5:0:0:0: [sdc] 5860533168 512-byte logical bloc=
ks: (3.00 TB/2.72 TiB)
>>> [ =A0147.870393] sd 5:0:0:0: [sdc] 4096-byte physical blocks
>>> [ =A0147.870396] sd 5:0:0:0: Attached scsi generic sg3 type 0
>>> [ =A0147.870434] sd 5:0:0:0: [sdc] Write Protect is off
>>> [ =A0147.870436] sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
>>> [ =A0147.870460] sd 5:0:0:0: [sdc] Write cache: enabled, read cache=
: enabled, doesn't support DPO or FUA
>>> [ =A0147.904848] =A0sdc: sdc1
>>> [ =A0147.905196] sd 5:0:0:0: [sdc] Attached SCSI disk
>>>
>>>
>>> Here is what happens on re-plug of the device. It is a 3.5" drive a=
nd the line
>>> [ =A0617.838013] ata6: hard resetting link
>>> happens too early. I can hear the drive is still spinning up, it ca=
n't be ready yet.
>>> I think the delay should be increased.
>>>
>>>
>>> [ =A0617.837966] ata6: exception Emask 0x10 SAct 0x0 SErr 0x4050002=
 action 0xe frozen
>>> [ =A0617.837976] ata6: irq_stat 0x00400040, connection status chang=
ed
>>> [ =A0617.837984] ata6: SError: { RecovComm PHYRdyChg CommWake DevEx=
ch }
>>> [ =A0617.838004] ata6: limiting SATA link speed to 1.5 Gbps
>>> [ =A0617.838013] ata6: hard resetting link
>>> [ =A0623.610941] ata6: link is slow to respond, please be patient (=
ready=3D0)
>>> [ =A0627.864604] ata6: COMRESET failed (errno=3D-16)
>>> [ =A0627.864615] ata6: hard resetting link
>>> [ =A0629.931538] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl =
310)
>>> [ =A0629.932355] ata6.00: ATA-8: ST3000DM001-9YN166, CC4C, max UDMA=
/133
>>> [ =A0629.932365] ata6.00: 5860533168 sectors, multi 0: LBA48 NCQ (d=
epth 31/32), AA
>>> [ =A0629.933170] ata6.00: configured for UDMA/133
>>> [ =A0629.951629] ata6: EH complete
>>> [ =A0629.951700] scsi 5:0:0:0: Direct-Access =A0 =A0 ATA =A0 =A0 =A0=
ST3000DM001-9YN1 CC4C PQ: 0 ANSI: 5
>>> [ =A0629.951816] sd 5:0:0:0: [sdc] 5860533168 512-byte logical bloc=
ks: (3.00 TB/2.72 TiB)
>>> [ =A0629.951819] sd 5:0:0:0: [sdc] 4096-byte physical blocks
>>> [ =A0629.951842] sd 5:0:0:0: Attached scsi generic sg3 type 0
>>> [ =A0629.951875] sd 5:0:0:0: [sdc] Write Protect is off
>>> [ =A0629.951877] sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
>>> [ =A0629.951901] sd 5:0:0:0: [sdc] Write cache: enabled, read cache=
: enabled, doesn't support DPO or FUA
>>> [ =A0629.995970] =A0sdc: sdc1
>>> [ =A0629.996359] sd 5:0:0:0: [sdc] Attached SCSI disk
>>>
>>>
>>> Martin
>>
>>
