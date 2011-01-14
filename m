From: =?UTF-8?B?576F56eJ6Yie?= <luobingjiun@gmail.com>
Subject: Re: Why is only one command issue per time in AHCI driver?
Date: Fri, 14 Jan 2011 09:06:29 +0800
Message-ID: <AANLkTikV-VWpy0XKpMUvurp86dRAOWUUNEQP5OkvfCso@mail.gmail.com>
References: <AANLkTin5=NiZn6ZWZ=r-XS0v_Utrf6dpTb_YzCay-PJM@mail.gmail.com>
	<4D2F3A86.3010503@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42861 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343Ab1ANBGa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Jan 2011 20:06:30 -0500
Received: by wyb28 with SMTP id 28so2351020wyb.19
        for <linux-ide@vger.kernel.org>; Thu, 13 Jan 2011 17:06:29 -0800 (PST)
In-Reply-To: <4D2F3A86.3010503@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

Hi,

Yes, what I see is every time scsi_request_fn is called, we can only po=
p
up one request to be dispatched. So, How can we make block layer to
pass more than one commands to us? So that we can fill up more
commands into the Command List before write Px.CI. I think it might
shorten the command interval time.

Even I enable the NCQ, I observed that there is only one command to be
executed per time and tag 0 is used.

Is there any possible to change the libata and ahci.c to be able to fir=
e up
more than one commands at one time and report complete multiple to
upper layer(SCSI and block layer).

Another question, at scsi_adjust_queue_depth() function, why sdev->orde=
red_tags
and sdev->simple_tags value is only 0 or 1 regardless of queue_depth? W=
hat
does it mean?

Thank you in advance for your explanation.



On Fri, Jan 14, 2011 at 1:46 AM, Jeff Garzik <jeff@garzik.org> wrote:
> On 01/13/2011 05:52 AM, =E7=BE=85=E7=A7=89=E9=88=9E wrote:
>>
>> Hello,
>>
>> Inside ahci_qc_issue() function, I see that driver always write one =
bit
>> to Px.CI register even enable the NCQ.
>>
>> AHCI allows to fire 32 commands at one time and AHCI driver also
>> claims itself able to queue up to 31 commands.
>>
>> Inside ahci.c :
>> static struct scsi_host_template ahci_sht =3D {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0ATA_NCQ_SHT(DRV_NAME),
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0.can_queue =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D AHCI_MAX_CMDS - 1,
>> ............
>>
>> Why upper layer(Block or SCSI layer) does not fill up as many as pos=
sible
>> commands into Command List before sending the commands out
>> (Write to Px.CI register)?
>
> The driver successfully executes up to 31 commands at a time, in para=
lle.
>
> We submit one command at a time to hardware because the block layer p=
asses
> commands to us one at a time.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Jeff
>
>
>
>
