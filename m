From: Erik Postma <e.j.postma+linux-ide@gmail.com>
Subject: Re: PROBLEM: "lost interrupt (Status 0x50)" from DVD drive, long wait
	on 2.6.31 till 2.6.32rc6
Date: Tue, 1 Dec 2009 09:41:53 -0500
Message-ID: <d4db24520912010641j398506b4h50fdab4fde5e7b73@mail.gmail.com>
References: <d4db24520911150535pc4cddbufe86713cb317d7c9@mail.gmail.com>
	 <d4db24520911151957s781902e0v2bc9e9c20f3ebdd5@mail.gmail.com>
	 <4B14B3A3.4090103@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:33593 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbZLAOls convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Dec 2009 09:41:48 -0500
Received: by fxm5 with SMTP id 5so4958593fxm.28
        for <linux-ide@vger.kernel.org>; Tue, 01 Dec 2009 06:41:54 -0800 (PST)
In-Reply-To: <4B14B3A3.4090103@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

2009/12/1 Tejun Heo <tj@kernel.org>:
> Hello,
>
> On 11/16/2009 12:57 PM, Erik Postma wrote:
>> 2009/11/15 Erik Postma <e.j.postma+linux-ide@gmail.com>:
>>> (...)
>>> [7.7.] Other information that might be relevant to the problem
>>> =A0 =A0 =A0 (please look in /proc and include all information that =
you
>>> =A0 =A0 =A0 think to be relevant):
>>>
>>> Here's dmesg:
>>> (...)
>>
>> Just now I had a boot where it did something different; here's what =
I
>> guess is the relevant part of dmesg. This is the same kernel and of
>> course the same hardware as described in the earlier email. Does the
>> fact that it's unpredictable mean there's possibly hardware issues?
>> Still have not seen any sign of trouble on 2.6.30 or earlier.
>>
>> [ =A0 =A06.872066] ata4.00: qc timeout (cmd 0xa0)
>> [ =A0 =A06.872123] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 ac=
tion
>> 0x6 frozen
>> [ =A0 =A06.872183] ata4.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 =
tag 0
>> [ =A0 =A06.872184] =A0 =A0 =A0 =A0 =A0cdb 00 00 00 00 00 00 00 00 =A0=
00 00 00 00 00 00
>> 00 00
>> [ =A0 =A06.872186] =A0 =A0 =A0 =A0 =A0res 51/20:03:00:00:00/00:00:00=
:00:00/a0 Emask
>> 0x5 (timeout)
>> [ =A0 =A06.872337] ata4.00: status: { DRDY ERR }
>> [ =A0 =A06.872417] ata4: soft resetting link
>> [ =A0 =A07.052604] ata4.00: configured for UDMA/33
>> [ =A0 =A07.053051] ata4: EH complete
>
> Timeouts on TURs. =A0These seem pretty common for optical drives for
> some reason. =A0I can't think of anything which has changed since .30
> which could have affected execution of NODATA command. =A0Is the driv=
e
> useable once those timeouts passed? =A0Does having a media in the dri=
ve
> or not make any difference?
>
> Thanks.
>
> --
> tejun
>

Hi tejun,

Thanks for your reply.
Having media in the drive does not make a difference. I'll check if
the drive is usable afterwards tonight, or worst case some time later
this week.

Best,

Erik.
