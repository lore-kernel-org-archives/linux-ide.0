From: Gwendal Grignou <gwendal@google.com>
Subject: Re: ahci port hangs while hard resetting link
Date: Fri, 27 Aug 2010 01:09:50 -0700
Message-ID: <AANLkTimN0tg+mBGaU=BHmC1FyVWr8LXhdNC6FzV_7J57@mail.gmail.com>
References: <201008230010.48355.anssi.hannula@iki.fi>
	<4C723FF4.1020208@kernel.org>
	<201008231811.59828.anssi.hannula@iki.fi>
	<4C73F2E3.6030909@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:49608 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304Ab0H0IJy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Aug 2010 04:09:54 -0400
Received: from hpaq6.eem.corp.google.com (hpaq6.eem.corp.google.com [172.25.149.6])
	by smtp-out.google.com with ESMTP id o7R89r2o006853
	for <linux-ide@vger.kernel.org>; Fri, 27 Aug 2010 01:09:53 -0700
Received: from vws10 (vws10.prod.google.com [10.241.21.138])
	by hpaq6.eem.corp.google.com with ESMTP id o7R89pMd009616
	for <linux-ide@vger.kernel.org>; Fri, 27 Aug 2010 01:09:51 -0700
Received: by vws10 with SMTP id 10so3816458vws.17
        for <linux-ide@vger.kernel.org>; Fri, 27 Aug 2010 01:09:51 -0700 (PDT)
In-Reply-To: <4C73F2E3.6030909@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Anssi Hannula <anssi.hannula@iki.fi>, linux-ide@vger.kernel.org

It is a good fix. We experience a similar issue [a bad drive was
passing hard reset but would not answer a soft reset]. Without the
patch the machine would hang. With it, the error is found. This
problem has been introduced a long time ago, in commit
2cbb79ebbd4be07041368da5379a64f89f8ad518; it is there in 2.6.33, in
drivers/ata/ahci.c. I can send you the trivial patch for it if you
want, for stable kernel.

Gwendal.

On Tue, Aug 24, 2010 at 9:27 AM, Tejun Heo <tj@kernel.org> wrote:T
> On 08/23/2010 05:11 PM, Anssi Hannula wrote:
>> On Monday 23 August 2010 12:31:32 Tejun Heo wrote:
>>> Hello,
>>>
>>> On 08/22/2010 11:10 PM, Anssi Hannula wrote:
>>>> 22:52:18 : ata6: exception Emask 0x10 SAct 0x0 SErr 0x4050002 acti=
on 0xe
>>>> frozen
>>>> 22:52:18 : ata6: irq_stat 0x00400040, connection status changed
>>>> 22:52:18 : ata6: SError: { RecovComm PHYRdyChg CommWake DevExch }
>>>> 22:52:18 : ata6: hard resetting link
>>>> 22:52:28 : ata6: softreset failed (device not ready)
>>>> 22:52:28 : ata6: hard resetting link
>>>> 22:52:38 : ata6: softreset failed (device not ready)
>>>> 22:52:38 : ata6: hard resetting link
>>>> 22:52:49 : ata6: link is slow to respond, please be patient (ready=
=3D0)
>>>> 22:53:13 : ata6: softreset failed (device not ready)
>>>> 22:53:13 : ata6: limiting SATA link speed to 1.5 Gbps
>>>> 22:53:13 : ata6: hard resetting link
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> I disconnect the drive for a few moments, but nothing is output by
>>>> kernel. I reconnect it again, but again, nothing is output by the
>>>> kernel. I run: echo "- - -" >
>>>> /sys/devices/pci0000:00/0000:00:1f.2/host5/scsi_host/host5/scan
>>>> However, it appeared stuck and still no messages in the kernel log=
, so
>>>> I disconnected the device again. Still nothing is output, and the
>>>> following messages started to be output, indicating that the proce=
ss
>>>
>>>> had become stuck:
>>> Looks like EH got stuck somehow. =A0Maybe the timeout calculation i=
s
>>> wrong? =A0Can you please trigger sysrq-t while the system is stuck =
and
>>> post the result?
>>
>> Ok, here's the output. And the system is not stuck, just the bash pr=
ocess that
>> is writing to 'scan' file.
>>
>> In this occasion, the hard reset had been stuck for some 16 hours, a=
nd it is
>> on ata5 (scsi4):
>
> Does the following patch fix the problem?
>
> Thanks.
>
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 666850d..68dc678 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1326,7 +1326,7 @@ int ahci_do_softreset(struct ata_link *link, un=
signed int *class,
> =A0 =A0 =A0 =A0/* issue the first D2H Register FIS */
> =A0 =A0 =A0 =A0msecs =3D 0;
> =A0 =A0 =A0 =A0now =3D jiffies;
> - =A0 =A0 =A0 if (time_after(now, deadline))
> + =A0 =A0 =A0 if (time_after(deadline, now))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msecs =3D jiffies_to_msecs(deadline - =
now);
>
> =A0 =A0 =A0 =A0tf.ctl |=3D ATA_SRST;
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
