From: Mark Rustad <mrustad@gmail.com>
Subject: Re: Why is NCQ enabled by default by libata? (2.6.20)
Date: Tue, 27 Mar 2007 17:12:00 -0500
Message-ID: <711F1620-F483-4CC2-83D6-F2DD577AB5BB@gmail.com>
References: <Pine.LNX.4.64.0703241232580.11608@p34.internal.lan> <4608B2B9.7090503@garzik.org> <ACBD2F44-03C7-49BE-9A2F-ABF7078BCC5E@gmail.com> <460964BA.8090101@garzik.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=WINDOWS-1252;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:56330 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934210AbXC0WMF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Mar 2007 18:12:05 -0400
Received: by py-out-1112.google.com with SMTP id a29so1134560pyi
        for <linux-ide@vger.kernel.org>; Tue, 27 Mar 2007 15:12:05 -0700 (PDT)
In-Reply-To: <460964BA.8090101@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

On Mar 27, 2007, at 1:38 PM, Jeff Garzik wrote:

> Mark Rustad wrote:
>> reorder any queued operations. Of course if you really care about =20
>> your data, you don't really want to turn write cache on.
>
> That's a gross exaggeration.  FLUSH CACHE and FUA both ensure data =20
> integrity as well.
>
> Turning write cache off has always been a performance-killing =20
> action on ATA.

Perhaps. Folks I work with would disagree with that, but I am not =20
enough of a storage expert to judge. My statement mirrors the =20
judgement of folks I work with that know more than I do.

>> Also the controller used can have unfortunate interactions. For =20
>> example the Adaptec SAS controller firmware will never issue more =20
>> than two queued commands to a SATA drive (even though the firmware =20
>> will happily accept more from the driver), so even if an attached =20
>> drive is capable of reordering queued commands, its performance is =20
>> seriously crippled by not getting more commands queued up. In =20
>> addition, some drive firmware seems to try to bunch up queued =20
>> command completions which interacts very badly with a controller =20
>> that queues up so few commands. In this case turning NCQ off =20
>> performs better because the drive knows it can't hold off =20
>> completions to reduce interrupt load on the host =96 a good idea =20
>> gone totally wrong when used with the Adaptec controller.
>
> All of that can be fixed with an Adaptec firmware upgrade, so not =20
> our problem here, and not a reason to disable NCQ in libata core.

It theoretically could be, but we are using the latest Adaptec =20
firmware. Until there exists firmware that fixes it, it remains an =20
issue. We worked with Adaptec to isolate this issue, but no =20
resolution has been forthcoming from them. I agree that this does not =20
mean that NCQ should be disabled in libata core, but some combination =20
of controller/drive/firmware blacklist may need to be managed, as =20
distasteful as that is.

>> Today SATA NCQ seems to be an area where few combinations work =20
>> well. It seems so bad to me that a whitelist might be better than =20
>> a blacklist. That is probably overstating it, but NCQ performance =20
>> is certainly a big problem.
>
> Real world testing disagrees with you.  NCQ has been enabled for a =20
> while now.  We would have screaming hordes of users if the majority =20
> of configurations were problematic.

I didn't say that it is a majority or that it doesn't work, it just =20
often doesn't perform. If it didn't work there would be lots of =20
howling for sure. I'm also not saying that it is a libata problem. It =20
seems mostly to be controller and drive firmware issues - and the odd =20
fan issue (if you saw the thread: [BUG 2.6.21-rc3-git9] SATA NCQ =20
failure with Samsum HD401LJ).

I guess I am mainly lamenting the current state of SATA/NCQ devices =20
and sharing what little I have picked up about it - which is that I =20
want SAS disks in my next system!

--=20
Mark Rustad, MRustad@gmail.com


