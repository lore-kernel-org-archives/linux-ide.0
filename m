From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: totally random "VFS: Cannot open root device"
Date: Thu, 01 Dec 2005 20:53:40 -0500
Message-ID: <438FA924.1090005@pobox.com>
References: <438B6E05.8070009@eq.cz> <438D2C19.3030008@gmail.com> <438DA3FA.2010809@eq.cz> <a762e240511301405s433109b7n93e7fdcc7409bef5@mail.gmail.com> <438EC502.1090103@keytradebank.com> <20051201112015.GA10462@htj.dyndns.org> <438EF3B6.7020007@keytradebank.com> <438EFAA5.3070901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:21981 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964775AbVLBBxw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Dec 2005 20:53:52 -0500
In-Reply-To: <438EFAA5.3070901@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: =?ISO-8859-1?Q?Jean-Fran=E7ois_Stenuit?= <jfs@keytradebank.com>, Keith Mannthey <kmannth@gmail.com>, "0602@eq.cz" <0602@eq.cz>, Linux-ide <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Jean-Fran=E7ois Stenuit wrote:
>=20
>> Hi Tejun,
>>
>> Thanks for taking the time to check.
>>
>> Output of your trace with ata_piix.override_PCS=3D0
>>  1st boot : success : combined=3D0 orig_mask=3D0x11
>>  2nd boot : success : combined=3D0 orig_mask=3D0x11
>>  3rd boot : failure : combined=3D0 orig_mask=3D0x0
>>  4th boot : failure : combined=3D0 orig_mask=3D0x0
>>  5th boot : failure : combined=3D0 orig_mask=3D0x0
>>  6th boot : failure : combined=3D0 orig_mask=3D0x0
>>  7th boot : success : combined=3D0 orig_mask=3D0x11
>> Output of your trace with ata_piix.override_PCS=3D1
>>  1st boot : success : combined=3D0 orig_mask=3D0x0
>>  2nd boot : success : combined=3D0 orig_mask=3D0x0
>>  3rd boot : success : combined=3D0 orig_mask=3D0x0
>>  4th boot : success : combined=3D0 orig_mask=3D0x0
>>  5th boot : success : combined=3D0 orig_mask=3D0x0
>>  6th boot : success : combined=3D0 orig_mask=3D0x0
>>  7th boot : success : combined=3D0 orig_mask=3D0x0
>>  8th boot : success : combined=3D0 orig_mask=3D0x0
>>
>> Looks like you have found a fix/workaround for this bug (but it stil=
l=20
>> does not give the reason why it's failing).
>>
>=20
> It probably is a BIOS issue.  The weird thing though is that the port=
=20
> works fine with its corresponding ENABLED bit cleared.  Anyways, if i=
t=20
> works by ignoring the ENABLED bit, ignoring should just be fine.
>=20
> 0602, can you verify this workaround works on your machine too?
>=20
> Jeff (Hi!), if 0602 also confirms that this workaround works, I'll=20
> submit a patch to make ata_piix ignore PCS values on ICH5's.  How doe=
s=20
> that sound to you?

I am being dragged into this thread with little background info.  Here'=
s=20
some data points that may be relevant:

* until very recently, ata_piix's definitions for the ENABLED and=20
PRESENT bits was reversed.

* the PRESENT bit reflects a device present status just like the SStatu=
s=20
phy register does.  This implies that one must wait, before assuming=20
that the PRESENT bit's absence truly indicates absence of a device.

* the device may be in various power management states.  It may be wise=
=20
to issue COMRESET by
	- clear ENABLED bit
	- set ENABLED bit
	- wait for device to appear
	- if no device appeared, clear ENABLED bit

In sum, think about the underlying SATA phy registers, and how they=20
logically map to the PCS bits.

	Jeff


