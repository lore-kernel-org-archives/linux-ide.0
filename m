From: Lin Mac <mkl0301@gmail.com>
Subject: Re: Cannot detect SATA disks w/ CONFIG_SATA_PMP w/o actually using
 SATA multiplier
Date: Sun, 5 Dec 2010 01:07:32 +0800
Message-ID: <AANLkTi=aUA9qKVmEhfh=OG5f9oBNDG8LdZ-LRcjaXycw@mail.gmail.com>
References: <AANLkTi=kbTcq3hYBiDzGcAb02Ppwb1QEcs12-1W_T=LG@mail.gmail.com>
	<4CF50574.6000706@gmail.com>
	<AANLkTi=0gBcfrAyJNb0+=obH2QDsqhGM5a9xxwHAoh88@mail.gmail.com>
	<4CF55549.4080000@gmail.com>
	<AANLkTimWqFh-PD4DFXwaRmthb5Lyw3MAFknFmT7vp5pY@mail.gmail.com>
	<4CF77570.9000700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33408 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765Ab0LDRHd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Dec 2010 12:07:33 -0500
Received: by fxm20 with SMTP id 20so3118986fxm.19
        for <linux-ide@vger.kernel.org>; Sat, 04 Dec 2010 09:07:32 -0800 (PST)
In-Reply-To: <4CF77570.9000700@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: cbouatmailru@gmail.com, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

2010/12/2 Tejun Heo <htejun@gmail.com>:
> Hello,
>
> On 12/02/2010 11:23 AM, Lin Mac wrote:
>>> One thing which could be possible is that the controller stashes th=
e
>>> result code for the PMP aware SRST according to the PMP number inst=
ead
>>> of the usual place, so the driver can't see it. =A0In that case, th=
e
>>> driver can be modified to check both places I suppose but if the
>>> hardware can be fixed, that would be great.
>> the usual place, I presume you mean PxTFD+PxSIG.
>> I've check RFIS of received FIS structure after softreset failed and
>> nothing there. (UFIS neither)
>> Is there any other suspect to check?
> Have you checked all PxTFDs? =A0It could be that the controller is
> saving it in the wrong slot.
No, they are not there.

>> My situation is that device is sending D2H Reg FIS, but controller i=
s
>> not reflecting it on PxTFD, PxSIG, or RFIS of received FIS
>> structure.With the patch I sent, it seems the controller receives D2=
H
>> Reg FIS of the same PMP setting of the previous sent H2D Reg FIS, an=
d
>> drop the different one.
>
> If the controller is dropping the D2H Reg FIS altogether, it'll
> probably need more intricate workaround. =A0:-(
>
>> The AHCI controller I used is AHCI v1.1 compatible, command-based sw=
itching.
>>
>> In SATA spec (rev2.6) 16.7.1, it says:
>>
>> A host controller may support command-based switching by implementin=
g
>> the Port Multiplier Port (PMP) field in the SControl register as
>> detailed in section 14.1.3.In order to use this mechanism, host
>> software would set the PMP field appropriately before issuing a
>> command to a device conected to the Port Multiplier. (...) Note that
>> the PMP field shall be set to the control port when host software
>> issues commands to the Port Multiplier itself.
>> --
>>
>> In AHCI spec, the PMP field of PxSCTL "is not used by AHCI".Does it
>> implies AHCI would set it and software doesn't need to do anything?
>>
>> 13.13.4.1 Port Multiplier Discovery
>> If =A0a device is present, the host issues a software reset with the=
 PM
>> Port field set =A0to the control port. The host checks the signature
>> value returned and if....
>> --
>>
>> SATA spec didn't says what to do IF it received a data with PMP
>> setting doesn't match it's current setting (did it?). While 13.13.4.=
1
>> only implies the host should receive the signature successfully, eve=
n
>> if it is of different PMP setting.
>
> The probing sequence is described somewhere in the ahci spec and I'm
> fairly sure the dropping behavior you're describing is out of spec.
> You'll need to find a way to reliably distinguish a PMP device and
> then probably implement the workaround in custom hardreset or
> softreset method for the specific controller.
I have resent the patch which retry ahci_do_softreset again with pmp=3D=
0
if pmp=3D15 failed.
Thanks a lot for the help.

Best Regards,
Mac Lin
