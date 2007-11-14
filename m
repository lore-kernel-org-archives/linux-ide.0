From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata , Silicon Image 3124
Date: Wed, 14 Nov 2007 11:10:57 +0900
Message-ID: <473A5931.4040704@gmail.com>
References: <4738A231.5010700@kasimir-mueller.de> <4738FC4C.7050103@gmail.com> <473A11B4.5030409@kasimir.mueller.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:46155 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763912AbXKNCLF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Nov 2007 21:11:05 -0500
Received: by wa-out-1112.google.com with SMTP id v27so28156wah
        for <linux-ide@vger.kernel.org>; Tue, 13 Nov 2007 18:11:03 -0800 (PST)
In-Reply-To: <473A11B4.5030409@kasimir.mueller.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kasimir Mueller <kjm@kasimir.mueller.de>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

[linux-ide added back. please don't drop cc list]

Kasimir Mueller wrote:
> Tejun Heo schrieb:
>> Kasimir M=FCller wrote:
>> =20
>>> Nov 12 19:28:42 linux kernel: ata6.02: cmd
>>> ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0
>>> Nov 12 19:28:42 linux kernel:          res
>>> 40/00:00:09:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
>>>    =20
>>
>> That's flush timing out, which isn't good.
>>
>> 1. Are the errors localized to ata6.02?
>>  =20
> I think it's ata6.01

The above message says 6.02 tho.  Anyways, if the errors are localized
to one drive, please swap that drive with another drive.  Do the errors
follow the drive or stay with the slot?

>> 2. Is FLUSH always involved (ie. is cmd always ea)?
>>  =20
> yes

Hmmm... okay.  That sounds like a dying drive to me.  What does
'smartctl -a /dev/sdX' say?

>> 3. If you disable NCQ, what do errors look like?
>>  =20
> I put all disk-drives in the blacklist , without a change

So, NCQ isn't the problem.

ATM, it sounds like a dying drive to me.  Please double check the error=
s
are localized to one drive, check smartctl log and try to verify as
written above.

Thanks.

--=20
tejun
