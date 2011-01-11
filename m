From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: AHCI support Port Multiplier problem.
Date: Mon, 10 Jan 2011 19:54:29 -0600
Message-ID: <4D2BB855.5070703@gmail.com>
References: <20110107212537.GH7355@mtj.dyndns.org> <55871.3142.qm@web74203.mail.tp2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55892 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753712Ab1AKByc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Jan 2011 20:54:32 -0500
Received: by iwn9 with SMTP id 9so19743205iwn.19
        for <linux-ide@vger.kernel.org>; Mon, 10 Jan 2011 17:54:32 -0800 (PST)
In-Reply-To: <55871.3142.qm@web74203.mail.tp2.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Luo Dislo <dislo_b_j@yahoo.com.tw>
Cc: Tejun Heo <tj@kernel.org>, jgarzik@pobox.com, linux-ide@vger.kernel.org

On 01/09/2011 07:46 PM, Luo Dislo wrote:
> Hello,
>
> This is my company(Faraday) implemented AHCI SATA controller. Our
> controller is not located at PCI bus, but AHB bus(ARM based platform)=
=2E
>
> However, I modify Linux kernel builtin AHCI driver(ahci.c) to replace
> the PCI related code by using platform bus. Just pretty similar way
> with drivers/ata/ahci_platform.c (Kernel 2.6.35).
>
> I think the problem happens because libata does not give up, keep on
> expecting the Port Multiplier Signature when we set CONFIG_SATA_PMP
> to 1.

It shouldn't be expecting only a PMP signature in this case if there is=
=20
no PMP connected. The PMP spec states:

"To determine if a Port Multiplier is present, the host performs the=20
following procedure. The host will determine if communication is=20
established on the host=E2=80=99s Serial ATA port by checking the host=E2=
=80=99s SStatus=20
register. If a device is present, the host will issue a software reset=20
with the PM Port field set to the control port. The host will check the=
=20
signature value returned and if it corresponds to the Port Multiplier=20
Signature, the host knows that a Port Multiplier is present. If the=20
signature value does not correspond to a Port Multiplier, the host may=20
proceed with the normal initialization sequence for that device type."

The code is doing this. However, I suspect the problem is that on some=20
controllers, it won't fill in the signature as expected if the PMP fiel=
d=20
on the received D2H Register FIS doesn't match the one listed in the=20
command 15, for the PMP control port), which it won't if there's no PMP=
=20
connected. I'm not sure if this is the intent of the AHCI spec or not,=20
but in any case it appears that a number of controllers have this issue=
=2E=20
I suspect that retrying with PMP=3D0 if the softreset with PMP=3D15 fai=
led=20
to acquire a signature is likely the thing to do.


>
> I know how to fix this problem, just add AHCI_HFLAG_NO_PMP to AHCI_HF=
LAGS when I connect hard drive to the controller. Meanwhile, when I wan=
t to connect the Port Muliplier to my controller, I need to remove AHCI=
_HFLAG_NO_PMP from AHCI_HFLAGS.
>
> I don't think this is a good solution because I have to compile two v=
ersion of my code. It does not make sense. We set CONFIG_SATA_PMP to 1 =
and inside the driver code DOES NOT have AHCI_HFLAG_NO_PMP just means t=
hat controller support Port Multiplier but the device connecting to the=
 port might be others type.
>
>
>
> Regards,
>
> Dislo
>
>
>
>
> --- 11/1/8 (=E5=85=AD)=EF=BC=8CTejun Heo<tj@kernel.org>  =E5=AF=AB=E9=
=81=93=EF=BC=9A
>
>> =E5=AF=84=E4=BB=B6=E8=80=85: Tejun Heo<tj@kernel.org>
>> =E4=B8=BB=E6=97=A8: Re: AHCI support Port Multiplier problem.
>> =E6=94=B6=E4=BB=B6=E8=80=85: "Luo Dislo"<dislo_b_j@yahoo.com.tw>
>> =E5=89=AF=E6=9C=AC: jgarzik@pobox.com, linux-ide@vger.kernel.org
>> =E6=97=A5=E6=9C=9F: 2011=E5=B9=B41=E6=9C=888=E6=97=A5,=E5=85=AD,=E4=B8=
=8A=E5=8D=885:25
>> Hello,
>>
>> On Fri, Jan 07, 2011 at 10:55:14AM +0800, Luo Dislo wrote:
>>> I am using AHCI driver, when CONFIG_SATA_PMP is set
>> and the ahci
>>> driver DOES NOT have AHCI_HFLAG_NO_PMP. Libata sends
>> Software Reset
>>> with PMP=3D0xF, trying to detect if Port Multiplier
>> connected to the
>>> port. Unfortunately, if I plugged in general Hard
>> drive, my
>>> controller failed to identify the hard drive.
>>>
>>> What I observed was that libata always sent Software
>> Reset with
>>> PMP=3D0xF and I guessed expecting signature is
>> 0x96690101. I think
>>> libata should give up if the device does not return
>> the Port
>>> Multiplier signature at the first time and take the
>> signature value
>>> from device as the real device connnecting to the port
>> now.
>>>
>>> What we said "support" PMP does not mean the port can
>> only connnect
>>> to Port Multiplier. It might connect with hard drive
>> or ATAPI
>>> device.
>>
>> Which controller is this?  Can you please post the
>> output of "lspci
>> -nn"?  SB600 had this problem and needed workaround
>> but later SBs
>> fixed it.  Looks like someone else screwed up
>> similarly.
>>
>> Thanks.
>>
>> --
>> tejun
>>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

