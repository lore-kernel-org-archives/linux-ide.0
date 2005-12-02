From: Tejun Heo <htejun@gmail.com>
Subject: Re: totally random "VFS: Cannot open root device"
Date: Fri, 02 Dec 2005 12:00:05 +0900
Message-ID: <438FB8B5.8070505@gmail.com>
References: <438B6E05.8070009@eq.cz> <438D2C19.3030008@gmail.com> <438DA3FA.2010809@eq.cz> <a762e240511301405s433109b7n93e7fdcc7409bef5@mail.gmail.com> <438EC502.1090103@keytradebank.com> <20051201112015.GA10462@htj.dyndns.org> <438EF3B6.7020007@keytradebank.com> <438EFAA5.3070901@gmail.com> <438FA924.1090005@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.207]:2130 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964821AbVLBDAL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Dec 2005 22:00:11 -0500
Received: by zproxy.gmail.com with SMTP id 14so141765nzn
        for <linux-ide@vger.kernel.org>; Thu, 01 Dec 2005 19:00:11 -0800 (PST)
In-Reply-To: <438FA924.1090005@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: =?ISO-8859-1?Q?Jean-Fran=E7ois_Stenuit?= <jfs@keytradebank.com>, Keith Mannthey <kmannth@gmail.com>, "0602@eq.cz" <0602@eq.cz>, Linux-ide <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Tejun Heo wrote:
>=20
>> Jean-Fran=E7ois Stenuit wrote:
>>
>>> Hi Tejun,
>>>
>>> Thanks for taking the time to check.
>>>
>>> Output of your trace with ata_piix.override_PCS=3D0
>>>  1st boot : success : combined=3D0 orig_mask=3D0x11
>>>  2nd boot : success : combined=3D0 orig_mask=3D0x11
>>>  3rd boot : failure : combined=3D0 orig_mask=3D0x0
>>>  4th boot : failure : combined=3D0 orig_mask=3D0x0
>>>  5th boot : failure : combined=3D0 orig_mask=3D0x0
>>>  6th boot : failure : combined=3D0 orig_mask=3D0x0
>>>  7th boot : success : combined=3D0 orig_mask=3D0x11
>>> Output of your trace with ata_piix.override_PCS=3D1
>>>  1st boot : success : combined=3D0 orig_mask=3D0x0
>>>  2nd boot : success : combined=3D0 orig_mask=3D0x0
>>>  3rd boot : success : combined=3D0 orig_mask=3D0x0
>>>  4th boot : success : combined=3D0 orig_mask=3D0x0
>>>  5th boot : success : combined=3D0 orig_mask=3D0x0
>>>  6th boot : success : combined=3D0 orig_mask=3D0x0
>>>  7th boot : success : combined=3D0 orig_mask=3D0x0
>>>  8th boot : success : combined=3D0 orig_mask=3D0x0
>>>
>>> Looks like you have found a fix/workaround for this bug (but it sti=
ll=20
>>> does not give the reason why it's failing).
>>>
>>
>> It probably is a BIOS issue.  The weird thing though is that the por=
t=20
>> works fine with its corresponding ENABLED bit cleared.  Anyways, if =
it=20
>> works by ignoring the ENABLED bit, ignoring should just be fine.
>>
>> 0602, can you verify this workaround works on your machine too?
>>
>> Jeff (Hi!), if 0602 also confirms that this workaround works, I'll=20
>> submit a patch to make ata_piix ignore PCS values on ICH5's.  How do=
es=20
>> that sound to you?
>=20

Hi, Jeff.

>=20
> I am being dragged into this thread with little background info.  Her=
e's=20
> some data points that may be relevant:
>=20
> * until very recently, ata_piix's definitions for the ENABLED and=20
> PRESENT bits was reversed.

I saw that in the log but it doesn't seem to be the reason for this as=20
PCS reports 0x00 on failure cases.  None of ENABLED/PRESENTS bits is se=
t.

> * the PRESENT bit reflects a device present status just like the SSta=
tus=20
> phy register does.  This implies that one must wait, before assuming=20
> that the PRESENT bit's absence truly indicates absence of a device.
>=20
> * the device may be in various power management states.  It may be wi=
se=20
> to issue COMRESET by
>     - clear ENABLED bit
>     - set ENABLED bit
>     - wait for device to appear
>     - if no device appeared, clear ENABLED bit
>=20
> In sum, think about the underlying SATA phy registers, and how they=20
> logically map to the PCS bits.

Interestingly, it seems that those problemetic ICH5's seem to work=20
happily on ports where ENABLED bits are cleared.  Turning off ENABLED=20
bits on my ICH7 certainly disables the ports.  It almost seems that the=
=20
ENABLED bits are read incorrectly even though they are set correctly.

I'm a little bit scared about turning on or off those bits.  As probing=
=20
a disabled/non-present port doesn't cause any problem (we're doing it=20
already for combined cases) and simply ignoring the ENABLED bits does=20
cure the symptom.  IMHO, it's best to just ignore those mysteriously=20
zero but nevertheless working bits.  I'll submit a patch to ignore=20
ENABLED bits on ICH5's.  If you don't like it, please NACK it; then,=20
I'll try to cook something up which dances with the ENABLED bits.

Thanks.

--=20
tejun
