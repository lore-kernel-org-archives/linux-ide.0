From: Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH] libata: Allow SOFT_RESET for Sil3726
Date: Thu, 6 Oct 2011 13:44:27 -0700
Message-ID: <CAMHSBOXhmhaRQgA104U+yajDLwyjVAeMqYUvUZFvZNroL0urug@mail.gmail.com>
References: <CAMHSBOWbaLjbWZ7PNwTa-AsZRAzrOGLgSip=q2=u+qVQW4u3mQ@mail.gmail.com>
	<1317881037-11831-1-git-send-email-gwendal@google.com>
	<20111006080314.GB373@dhcp-172-17-108-109.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:61639 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935421Ab1JFUo3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Oct 2011 16:44:29 -0400
Received: from hpaq14.eem.corp.google.com (hpaq14.eem.corp.google.com [172.25.149.14])
	by smtp-out.google.com with ESMTP id p96KiSS4002979
	for <linux-ide@vger.kernel.org>; Thu, 6 Oct 2011 13:44:29 -0700
Received: from qyk2 (qyk2.prod.google.com [10.241.83.130])
	by hpaq14.eem.corp.google.com with ESMTP id p96KZJfP004434
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-ide@vger.kernel.org>; Thu, 6 Oct 2011 13:44:28 -0700
Received: by qyk2 with SMTP id 2so3924166qyk.5
        for <linux-ide@vger.kernel.org>; Thu, 06 Oct 2011 13:44:27 -0700 (PDT)
In-Reply-To: <20111006080314.GB373@dhcp-172-17-108-109.mtv.corp.google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mihrcke@gmail.com, linux-ide@vger.kernel.org, derry@high-rely.com

On Thu, Oct 6, 2011 at 1:03 AM, Tejun Heo <htejun@gmail.com> wrote:
> Hello, Gwendal.
>
> Which tree is this patch against?
I am using 2.6.34. I try to have this mail follow the thread "RE:
Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)", Derry started. It
did not work, sorry.
I will rebase the ata-dev branch soon - and clean up the patch
following Sergei comments.
>
> On Wed, Oct 05, 2011 at 11:03:57PM -0700, Gwendal Grignou wrote:
>> Allow controllers to send SOFT_RESET to Sil3726 PMP.
>> This PMP does not accept frames until the drive connected to
>> its port spins up.
>
> Do you mean until the device sets RDY by sending D2H Reg FIS?
Yes. Until the device sends the async D2H Reg FIS indicating the drive
spun up, the MPM does not accept the SoftRest FIS from the controller.
On most controller, that fine, the controller state machine keeps
retrying, but on Sil3132 it stops after a second or so and send an
error back to the driver.
>
>> Some controller [Sil3132 family] can not wait for the drive to spinu=
p
>> and fails the reset, leading to unnecessary speed downgrade.
>> Not allowing to send SOFT_RESET can lead some drive slow to spinup
>> to be ignored and produces weird error messages.
>
> Yeap, I agree this is nasty.
>
>> @@ -2805,7 +2805,14 @@ int ata_eh_reset(struct ata_link *link, int c=
lassify,
>> =A0 =A0 =A0 =A0 =A0 sata_scr_read(link, SCR_STATUS, &sstatus))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D -ERESTART;
>>
>> - =A0 =A0 if (rc =3D=3D -ERESTART || try >=3D max_tries)
>> + =A0 =A0 if (try >=3D max_tries)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> +
>> + =A0 =A0 /* Some PMP will not serve SRST until the disk is spunup,
>> + =A0 =A0 =A0* if the controller can not wait for the PMP to acknowl=
edge the frame,
>> + =A0 =A0 =A0* wait here */
>> + =A0 =A0 if (rc =3D=3D -ERESTART &&
>> + =A0 =A0 =A0 =A0 !((lflags & ATA_LFLAG_WAIT_SRST) && (reset =3D=3D =
softreset)))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>
>> =A0 =A0 =A0 now =3D jiffies;
>> @@ -2820,6 +2827,8 @@ int ata_eh_reset(struct ata_link *link, int cl=
assify,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 delta =3D schedule_timeo=
ut_uninterruptible(delta);
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 if (rc =3D=3D -ERESTART)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>
> So, now libata waits for full reset period before proceeding to reset
> PMP. =A0Hmmm... yeah, it makes sense. =A0Unfortunately, the only way =
to
> achieve spinup wait in this case is waiting blindly and libata's rese=
t
> timeouts are configured to accomodate drive spinup times. =A0PMP SCR
> failure kinda destroys those blind wait periods.
Yes, I totally agree this blind wait is not clean. Normally we would
wait until an event occurs [async FIS] and have the timeout just for
the error case.
Here we wait [10s] because we think the device is spinning up.
>
> I'm not too sure about ATA_LFLAG_WAIT_SRST. =A0I don't think making t=
he
> new behavior default would hurt.
I see your point. But if there is no PMP, Sil3132 is behaving, there
is no need of this logic.
>
> Can you please post before & after logs?
There are 2 problem with the current solution:
- by not waiting for device spin up, we basically disabled staggered
spinup: we send hard reset to all port very fast.
That may put burden on enclosure with weak power supplies.
- as Derry found out, disk which are slow to spin up can be ignored by
the kernel.

=46rom my experience:

Before:
Apr 11 13:29:23 cigg22 kernel: ata5.15: Port Multiplier 1.1,
0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
Apr 11 13:29:23 cigg22 kernel: ata5.00: hard resetting link
Apr 11 13:29:23 cigg22 kernel: ata5.00: SATA link up 3.0 Gbps (SStatus
123 SControl 320)
Apr 11 13:29:23 cigg22 kernel: ata5.01: hard resetting link
=2E..
Apr 11 13:29:23 cigg22 kernel: ata5.04: SATA link up 3.0 Gbps (SStatus
123 SControl 300)
Apr 11 13:29:23 cigg22 kernel: ata5.05: hard resetting link
Apr 11 13:29:23 cigg22 kernel: ata5.05: SATA link up 1.5 Gbps (SStatus
113 SControl 320)
Apr 11 13:29:23 cigg22 kernel: ata5.00: failed to IDENTIFY (I/O error,
err_mask=3D0x11)
Apr 11 13:29:23 cigg22 kernel: ata5.15: hard resetting link
Apr 11 13:29:23 cigg22 kernel: ata5: controller in dubious state,
performing PORT_RST
Apr 11 13:29:23 cigg22 kernel: ata5.15: SATA link up 3.0 Gbps (SStatus
123 SControl 0)
Apr 11 13:29:23 cigg22 kernel: ata5.00: hard resetting link
Apr 11 13:29:23 cigg22 kernel: ata5.00: SATA link up 3.0 Gbps (SStatus
123 SControl 320)
=2E..

We are hoping that by the time it takes to hard reset 5 ports, the
disks would have spun up.

After:
Sep 12 12:40:38 pnkv6 kern.info kernel: ata7: SATA link up 3.0 Gbps
(SStatus 123 SControl 0)
Sep 12 12:40:38 pnkv6 kern.info kernel: ata7.15: Port Multiplier 1.1,
0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
Sep 12 12:40:38 pnkv6 kern.info kernel: ata7.00: hard resetting link
Sep 12 12:40:38 pnkv6 kern.err kernel: ata7.00: softreset failed (SRST
command error)
Sep 12 12:40:38 pnkv6 kern.warn kernel: ata7.00: failed to read SCR 0
(Emask=3D0x40)
Sep 12 12:40:38 pnkv6 kern.warn kernel: ata7.00: reset failed
(errno=3D-85), retrying in 10 secs

<<< this allows the disk to spin up >>>

Sep 12 12:40:48 pnkv6 kern.err kernel: ata7.00: reset failed, giving up
Sep 12 12:40:48 pnkv6 kern.info kernel: ata7.15: hard resetting link
Sep 12 12:40:48 pnkv6 kern.warn kernel: ata7: controller in dubious
state, performing PORT_RST
Sep 12 12:40:50 pnkv6 kern.info kernel: ata7.15: SATA link up 3.0 Gbps
(SStatus 123 SControl 0)
Sep 12 12:40:50 pnkv6 kern.info kernel: ata7.00: hard resetting link
Sep 12 12:40:50 pnkv6 kern.info kernel: ata7.00: SATA link up 3.0 Gbps
(SStatus 123 SControl 320)
Sep 12 12:40:50 pnkv6 kern.info kernel: ata7.01: hard resetting link

>
> Thank you.
>
> --
> tejun
>
