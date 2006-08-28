From: Tejun Heo <htejun@gmail.com>
Subject: Re: [Fwd: [BUG] sata_via doesn't detect anymore my disks (broken
 between rc1 and rc3)]
Date: Tue, 29 Aug 2006 00:24:46 +0900
Message-ID: <44F30ABE.2050803@gmail.com>
References: <m2wt98bio1.fsf@vador.mandriva.com>	<m2sljwbil7.fsf@vador.mandriva.com> <44E37BD4.8010709@pobox.com>	<m23bbva9cs.fsf@vador.mandriva.com> <44E46E0E.4060703@gmail.com>	<m2fyfv7a8s.fsf@vador.mandriva.com> <44EB32AD.1080305@gmail.com>	<m2fyfnciky.fsf@vador.mandriva.com> <m2d5aprtw0.fsf@vador.mandriva.com>	<44EEEA29.1010008@gmail.com> <20060825135540.GE21866@htj.dyndns.org>	<m2ac5soqjl.fsf@vador.mandriva.com> <44EF1158.1040507@gmail.com> <m2r6z1c4k9.fsf@vador.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:3474 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751064AbWH1PYw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Aug 2006 11:24:52 -0400
Received: by py-out-1112.google.com with SMTP id n25so2518079pyg
        for <linux-ide@vger.kernel.org>; Mon, 28 Aug 2006 08:24:52 -0700 (PDT)
In-Reply-To: <m2r6z1c4k9.fsf@vador.mandriva.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thierry Vignaud <tvignaud@mandriva.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Thierry Vignaud wrote:
> Tejun Heo <htejun@gmail.com> writes:
> 
>>>>> The second patch is essentially identical to what you did the
>>>>> one liner.  Can you please check it once more?  I'll prepare
>>>>> old-sequence hardreset in the meantime.
>>>> Okay, here's the old-sequence hardreset patch.  This should have
>>>> the highest chance of working.  This patch should be applied on
>>>> top of the vt6420 patch.
>>> On top of which patch?
>>> I just tried to apply it on top of:
>>> - your last week patch
>>> - your two patches of this week
>>> and it does *not* apply on top of anyone...
>> Arghh... Sorry.  I sent the wrong version.  This patch is against
>> #upstream while I should have sent the one against #upstream-fixes.
>>
>>> Couldn't you either check first your patch or (better) just send a
>>> patch against vanilla 2.6.18-rc4-mm2?
>> I've attached whole sata_via.c to the other mail.  I think that should
>> do the trick.
> 
> It didn't (tested by overwriting 2.6.18-rc4-mm2's driver).
> I tried a few reset methods combinations w/os success.
> Like in other faillure cases, the driver saw the two links but failed
> to see the hd attached to the second sata link.

Hmmm.. That's very weird.  The detection sequence is almost identical to 
the original code.  Argh.....  Any ideas?

-- 
tejun
