From: Lin Mac <mkl0301@gmail.com>
Subject: Re: Question regarding PORT_IRQ_BAD_PMP (Re: AHCI support Port
 Multiplier problem.)
Date: Tue, 15 Feb 2011 21:00:31 +0800
Message-ID: <AANLkTikup_2ooyTJrxQwwyq5zZHObtbHFSk4bmGT9eAP@mail.gmail.com>
References: <20110107212537.GH7355@mtj.dyndns.org>
	<55871.3142.qm@web74203.mail.tp2.yahoo.com>
	<20110111143726.GE30607@htj.dyndns.org>
	<loom.20110215T051458-468@post.gmane.org>
	<20110215085504.GA3160@htj.dyndns.org>
	<AANLkTimG0Y2XjRTmaSLs0uq4h-zoz-x+k_eA-2Abxmg9@mail.gmail.com>
	<20110215100335.GH3160@htj.dyndns.org>
	<AANLkTin_K=KzYkrfO_pJDe_9LZzSJBbQn=8vjO1HhNG4@mail.gmail.com>
	<20110215103150.GI3160@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56841 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754905Ab1BONAc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Feb 2011 08:00:32 -0500
Received: by fxm20 with SMTP id 20so151811fxm.19
        for <linux-ide@vger.kernel.org>; Tue, 15 Feb 2011 05:00:31 -0800 (PST)
In-Reply-To: <20110215103150.GI3160@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, Anton Vorontsov <cbouatmailru@gmail.com>, "Basheer, Mansoor Ahamed" <mansoor.ahamed@ti.com>

2011/2/15 Tejun Heo <tj@kernel.org>:
> On Tue, Feb 15, 2011 at 06:26:21PM +0800, Lin Mac wrote:
>> 2011/2/15 Tejun Heo <tj@kernel.org>:
>> > On Tue, Feb 15, 2011 at 05:50:55PM +0800, Lin Mac wrote:
>> >> > You're already working around buggy hardware. =A0It isn't surpr=
ising
>> >> > that both behave incorrectly in their own separate ways. =A0Jus=
t do
>> >> > what's necessary to get the hardware working as long as the wor=
karound
>> >> > is localized to the specific controller.
>> >>
>> >> If I implement it as a quirk, would you prefer to add a new field
>> >> quirk, or just use flags of ahci_host_priv and add a new AHCI_HFL=
AG*?
>> >> I prefer the later, but afraid that it's not what it is for.
>> >
>> > Please implement it as a separate ata_port_operations like
>> > ahci_CONTROLLER_NAME_ops and use the customized reset methods.
>>
>> In fact, I did. But it doesn't get accepted.
>>
>> =A0 =A0 [PATCH v5 0/3] add CNS3xxx AHCI support (Cavium Networks)
>> =A0 =A0 http://www.spinics.net/lists/linux-ide/msg39859.html
>>
>> And given that there are many of them, shouldn't we implement it as =
quirk?
>
> IIRC, the rejected part was the renaming of files and addition of a
> new driver, no?

Before v5,
Jeff's concern is the renaming of the ahci_platform.c. Therefore I
fixed that part and rename the module name instead.

In v5, first I rename the module ahci_platform to ahci_platforms. Then
switch the ahci platform driver to device table matching. And add
cns3xxx change with a new entry in device table.

Basheer suggest that several platform have this issue, and can be
implemented as quirk.

Hi guys, could you kindly provide some input on the patchset:
[PATCH v5 0/3] add CNS3xxx AHCI support (Cavium Networks)
http://www.spinics.net/lists/linux-ide/msg39859.html

Best Regards,
Mac Lin
