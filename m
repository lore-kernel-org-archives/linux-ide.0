From: Tejun Heo <htejun@gmail.com>
Subject: Re: [ANNOUNCE] libata EH/NCQ/hotplug/PM git tree
Date: Sat, 13 May 2006 12:59:02 +0900
Message-ID: <44655986.3060007@gmail.com>
References: <44614592.7080301@gmail.com> <446536C5.80503@pobox.com> <44653807.3030101@gmail.com> <44655496.9030402@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.207]:59920 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932318AbWEMD7J (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 May 2006 23:59:09 -0400
Received: by nz-out-0102.google.com with SMTP id 13so607921nzn
        for <linux-ide@vger.kernel.org>; Fri, 12 May 2006 20:59:08 -0700 (PDT)
In-Reply-To: <44655496.9030402@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Albert Lee <albertcc@tw.ibm.com>, Jens Axboe <axboe@suse.de>, Edward Falk <efalk@google.com>, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Raymond Liu <Raymond.Liu@siliconimage.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Jeff Garzik wrote:
>>> Tejun Heo wrote:
>>>> tested.  I implemented AHCI PM support half-way but then realized =
I=20
>>>> don't have any AHCI controller which supports PM (I have ICH7R).  =
Is=20
>>>> there any AHCI controller which reports PM support?
>>>
>>> You can always use SCR-based PM support...
>>>
>>
>> Can you elaborate a bit?
>=20
> Sections A.1 and 6.1 of the PM spec.  You set the PMP field of the=20
> SControl register.  This has obvious parallelism limitations, which i=
s=20
> why "hardware context switching support" aka native PM support is=20
> greatly preferred.
>=20

That cmd-switching PM support is what AHCI SPM bit indicates.  As of=20
v1.1, AHCI doesn't define FIS-switching PM support yet.

Supports Port Multiplier (SPM): Indicates whether the HBA can support a=
=20
Port Multiplier. When set, a Port Multiplier using command-based=20
switching is supported. When cleared to =910=92, a Port Multiplier is n=
ot=20
supported, and a Port Multiplier may not be attached to this HBA.

And. the SControl section says...

19:16 RO 0h  Port Multiplier Port (PMP): This field is not used by AHCI=
=2E

Which is understandable considering AHCI doesn't construct FISes itself=
=2E=20
  I don't think PM requires more hardware support than being capable fo=
r=20
setting PMP in the FISes, which AHCI certainly can (standing down on=20
collision for SDB notify aside).  I can give it a shot but it clearly=20
violates the spec, and even if it works, we would need to print big fat=
=20
warning message while attaching PM.

--=20
tejun
