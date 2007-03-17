From: YUP <yupadmin@gmail.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Sat, 17 Mar 2007 19:38:09 +0100
Message-ID: <45FC3591.40404@gmail.com>
References: <45F873AC.6010204@gmail.com> <200703171429.49646.bzolnier@gmail.com> <45FBFD89.3080308@tw.ibm.com> <200703171600.55863.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:35182 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbXCQSiN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Mar 2007 14:38:13 -0400
Received: by nf-out-0910.google.com with SMTP id o25so608682nfa
        for <linux-ide@vger.kernel.org>; Sat, 17 Mar 2007 11:38:12 -0700 (PDT)
In-Reply-To: <200703171600.55863.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: albertl@mail.com, linux-ide@vger.kernel.org

Sorry for delay I was a little bit busy. I'll do this tests today and=20
let you know about results.

Regards,

Yarema


Bartlomiej Zolnierkiewicz =EF=E8=F8=E5:
> On Saturday 17 March 2007, Albert Lee wrote:
>> Bartlomiej Zolnierkiewicz wrote:
>>> Hi,
>>>
>>> Any news about this test?  ide-cd driver is much more forgiving for
>>> quirky hardware than libata+sr so please give it a try...
>>>
>> Hi Bart,
>> Yarema did the run test, but the AOpen drive was connected to the PI=
IX
>> controller, which is driven by libata:
>=20
> Which unfortunately says us nothing besides that pdc202xx_new works g=
reat
> on this system... ;-)
>=20
> Yarema, could you disable ata_piix, enable drivers/ide piix driver an=
d retest?
>=20
> Thanks,
> Bart
>=20

