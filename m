From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
Date: Sat, 19 Dec 2015 16:39:54 +0000
Message-ID: <yw1x1tai9yud.fsf@unicorn.mansr.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	<567302E8.5050303@candw.ms> <yw1x7fkcdi2a.fsf@unicorn.mansr.com>
	<5673061A.4070700@candw.ms> <yw1x37v0df86.fsf@unicorn.mansr.com>
	<56732C04.9040100@candw.ms> <yw1xvb7wbowu.fsf@unicorn.mansr.com>
	<5673F277.2050607@candw.ms> <yw1xegekarp9.fsf@unicorn.mansr.com>
	<1450441395.30729.203.camel@linux.intel.com>
	<yw1x37uzc45t.fsf@unicorn.mansr.com> <5674271B.9090308@candw.ms>
	<yw1xtwnfad4y.fsf@unicorn.mansr.com> <56745BA4.1090607@candw.ms>
	<yw1xpoy39yl1.fsf@unicorn.mansr.com> <56748D85.4060108@candw.ms>
	<yw1xlh8r9wkm.fsf@unicorn.mansr.com>
	<CAHp75VfnTp=ob9reLuUSu-AaBwDhfJWKo1kjgNWnHuC5HgL=bw@mail.gmail.com>
	<567541EE.9010308@candw.ms> <yw1x60zua1ld.fsf@unicorn.mansr.com>
	<567585CD.9080105@candw.ms>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:50494 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932811AbbLSQj5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Dec 2015 11:39:57 -0500
In-Reply-To: <567585CD.9080105@candw.ms> (Julian Margetson's message of "Sat,
	19 Dec 2015 12:29:01 -0400")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Julian Margetson <runaway@candw.ms>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Julian Margetson <runaway@candw.ms> writes:

> On 12/19/2015 11:40 AM, M=E5ns Rullg=E5rd wrote:
>> OK, I've found something.  The dma setup errors are benign, caused by
>> the driver calling dmaengine_prep_slave_sg() even for non-dma
>> operations.  The real error is the lock recursion that's reported
>> later.  I wasn't seeing it since I was running a UP non-preempt kernel.
>> With lock debugging enabled, I get the same error.  This patch should
>> fix it.
>>
>> ---8<---
>> >From 94c4769d2171ce66079fd486a45e09dd64db62c0 Mon Sep 17 00:00:00 2001
>> From: Mans Rullgard<mans@mansr.com>
>> Date: Sat, 19 Dec 2015 15:26:23 +0000
>> Subject: [PATCH] ata: sata_dwc_460ex: remove incorrect locking
>>
>> This lock is already taken in ata_scsi_queuecmd() a few levels up the
>> call stack so attempting to take it here is an error.  Moreover, it is
>> pointless in the first place since it only protects a single, atomic
>> assignment.
>>
>> Signed-off-by: Mans Rullgard<mans@mansr.com>
>> ---
>>   drivers/ata/sata_dwc_460ex.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
>> index 799df86..5696f39 100644
>> --- a/drivers/ata/sata_dwc_460ex.c
>> +++ b/drivers/ata/sata_dwc_460ex.c
>> @@ -1001,16 +1001,14 @@ static void sata_dwc_exec_command_by_tag(struct =
ata_port *ap,
>>   					 struct ata_taskfile *tf,
>>   					 u8 tag, u32 cmd_issued)
>>   {
>> -	unsigned long flags;
>>   	struct sata_dwc_device_port *hsdevp =3D HSDEVP_FROM_AP(ap);
>>   	struct sata_dwc_device *hsdev =3D HSDEV_FROM_AP(ap);
>>     	dev_dbg(ap->dev, "%s cmd(0x%02x): %s tag=3D%d\n", __func__,
>> tf->command,
>>   		ata_get_cmd_descript(tf->command), tag);
>>   -	spin_lock_irqsave(&ap->host->lock, flags);
>>   	hsdevp->cmd_issued[tag] =3D cmd_issued;
>> -	spin_unlock_irqrestore(&ap->host->lock, flags);
>> +
>>   	/*
>>   	 * Clear SError before executing a new command.
>>   	 * sata_dwc_scr_write and read can not be used here. Clearing the PM
> having a problem applying the patch .
>
> patching file drivers/ata/sata_dwc_460ex.c
> Hunk #1 FAILED at 1001 (different line endings).

OK, attaching it instead.

--=20
M=E5ns Rullg=E5rd

--=-=-=
Content-Type: text/x-diff
Content-Disposition: attachment;
 filename=0001-ata-sata_dwc_460ex-remove-incorrect-locking.patch

>From 94c4769d2171ce66079fd486a45e09dd64db62c0 Mon Sep 17 00:00:00 2001
From: Mans Rullgard <mans@mansr.com>
Date: Sat, 19 Dec 2015 15:26:23 +0000
Subject: [PATCH] ata: sata_dwc_460ex: remove incorrect locking

This lock is already taken in ata_scsi_queuecmd() a few levels up the
call stack so attempting to take it here is an error.  Moreover, it is
pointless in the first place since it only protects a single, atomic
assignment.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/ata/sata_dwc_460ex.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 799df86..5696f39 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1001,16 +1001,14 @@ static void sata_dwc_exec_command_by_tag(struct ata_port *ap,
 					 struct ata_taskfile *tf,
 					 u8 tag, u32 cmd_issued)
 {
-	unsigned long flags;
 	struct sata_dwc_device_port *hsdevp = HSDEVP_FROM_AP(ap);
 	struct sata_dwc_device *hsdev = HSDEV_FROM_AP(ap);
 
 	dev_dbg(ap->dev, "%s cmd(0x%02x): %s tag=%d\n", __func__, tf->command,
 		ata_get_cmd_descript(tf->command), tag);
 
-	spin_lock_irqsave(&ap->host->lock, flags);
 	hsdevp->cmd_issued[tag] = cmd_issued;
-	spin_unlock_irqrestore(&ap->host->lock, flags);
+
 	/*
 	 * Clear SError before executing a new command.
 	 * sata_dwc_scr_write and read can not be used here. Clearing the PM
-- 
2.6.3


--=-=-=--
