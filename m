From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: Faulty drive data recovery
Date: Wed, 24 Nov 2010 12:00:07 -0500
Message-ID: <AANLkTikcPDOxcnb5tGMz9_mEgKntdwHHstO1CipMXv5+@mail.gmail.com>
References: <4CED1B5F.8000700@dpf.gov.br> <4CED376A.40502@ngs.ru> <AANLkTikhpPg4XMiDs8B7Jq=YC-xLYtemsarW5=EADkQM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61948 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753808Ab0KXRA2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Nov 2010 12:00:28 -0500
Received: by gyb11 with SMTP id 11so2896289gyb.19
        for <linux-ide@vger.kernel.org>; Wed, 24 Nov 2010 09:00:28 -0800 (PST)
In-Reply-To: <AANLkTikhpPg4XMiDs8B7Jq=YC-xLYtemsarW5=EADkQM@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Artem Bokhan <aptem@ngs.ru>
Cc: Atila <atila.alr@dpf.gov.br>, linux-ide@vger.kernel.org

resend

> On Wed, Nov 24, 2010 at 11:03 AM, Artem Bokhan <aptem@ngs.ru> wrote:
>>
>> =9Afind /sys/devices -name timeout
>>
>> /sys/devices/pci0000:00/0000:00:1f.1/host0/target0:0:0/0:0:0:0/timeo=
ut
>> /sys/devices/pci0000:00/0000:00:1f.2/host2/target2:0:0/2:0:0:0/timeo=
ut
>> /sys/devices/pci0000:00/0000:00:1f.2/host3/target3:0:0/3:0:0:0/timeo=
ut
>>
>> As I remember, some time ago somewhere in the sources was hardcoded =
3 retries.
>>
>> 24.11.2010 20:04, Atila =D0=C9=DB=C5=D4:
>>>
>>> HI, I'm trying to recover data from a damaged hard disk, which has
>>> plenty of bad sectors, but also has many good ones. The problem is =
that
>>> when a bad sector is found, the drive keeps trying to read it, inst=
ead
>>> of giving up and just move on, so the average data read rate is aro=
und
>>> 5Kb/s. With such rates, it will take more than an year to finish. S=
ince
>>> I'm using gnu ddrescue (which logs bad sectors, so one can try then
>>> again later), my goal is not waste time with errors, leaving the re=
tries
>>> to a second round.
>>> So, my first attempt was to drastically lower the timeouts in
>>> libata-eh.c. It seems to have improved a little, but I'm not having=
 more
>>> than 12Kb/s.
>>> Is there any way to minimize retries and make errors finish faster?
>>>
>>> Atila Romero
>>>
>
Those are kernel timeout / retry parameters, and while helpful to
adjust, you really also need to tell the drive itself not to retry,
and or reduce its internal drive retry timeout.=9A They can be as long
as 2 minutes as shipped from the factory.

So getting rid of the kernel retries, will still leave you with an
exceptionally slow ddrescue if your stuck with the drive default retry
logic.

But you may be lucky, because using drives with a 2 minute retry
timeout is unacceptable in the raid world progress has been made for
making the timeout end-user controllable.

Western Digital first came out with TLER as a way to control that
internal drive retry logic a few years ago.

The ATA-8 spec. incorporated it and called it ERC (Error Recovery Contr=
ol).

Unfortunately, not many drives really support your adjusting TLER/ERC.

And for those few that do, Mark Lord hasn't (yet?) incorporated
setting either into hdparm yet from what I know.
So your only way to adjust it is a very recent version of smartctl.

I think smartctl handles both the original TLER capability and the new
ERC capability.=9A (They may be the same, but just with different
names.)

Here's an end-user message about it:

http://markmail.org/message/vnb2ozh3fbmxgyrt

Good Luck
Greg
