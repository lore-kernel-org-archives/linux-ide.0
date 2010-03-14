From: s ponnusa <foosaa@gmail.com>
Subject: Re: ATA 4 KiB sector issues.
Date: Sun, 14 Mar 2010 18:56:20 -0400
Message-ID: <f875e2fe1003141556p1f6595e0m8ce2a17c1843c326@mail.gmail.com>
References: <4B947393.2050002@kernel.org>
	 <alpine.DEB.1.10.1003090733330.9819@uplift.swm.pp.se>
	 <4B961D8F.3010500@ziu.info> <4B96E397.1040005@kernel.org>
	 <4B9D506D.3000609@ziu.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38371 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769Ab0CNW4X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Mar 2010 18:56:23 -0400
In-Reply-To: <4B9D506D.3000609@ziu.info>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michal Soltys <soltys@ziu.info>
Cc: Tejun Heo <tj@kernel.org>, Mikael Abrahamsson <swmike@swm.pp.se>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de

Has been following this thread and I might possibly be testing with
Windows XP soon. Will update the results.
-
SP

On Sun, Mar 14, 2010 at 5:09 PM, Michal Soltys <soltys@ziu.info> wrote:
> Tejun Heo wrote:
>>
>> I was thinking about testing XP booting this weekend but really want
>> to avoid it, so thanks a lot for the info. =A0I'll update the doc
>> accordingly but can you please enlighten me on how it works and what=
's
>> broken in detail? =A0So, XP should be fine with any alignment?
>>
>> Thanks.
>>
>
> Sorry for late reply.
>
> s/sp2/sp3 - although it shouldn't make a difference from sp2 onwards.
>
> Anyway - the tests I did were because of weird laptop, where I shrink=
ed
> whole win7 stuff and having no primary partitions left to use, I test=
ed my
> usual windows xp installation I deploy with ntfsclone. Originally tha=
t XP
> were installed from installation disk merged with sp3 (or how it's us=
ually
> called in windows world - slipstreamed). Of course, windows xp itself=
 will
> not present any options to install itself into logical partition in t=
he
> usual way - but during later deployment it's not a problem to put it =
where
> one's want.
>
> It's possible that this wouldn't work, if windows were installed firs=
t from
> pre-sp2 media, and then service pack was installed (in such case, ntl=
dr in
> C:\ is not updated afaik). It's also possible, that "brute-force" cop=
ied
> pre-sp2 or win2k to a partition made with either - a) xp sp2+'s disk =
manager
> or b) mkfs.ntfs and with updated most recent ntldr - =A0would boot as=
 well
> (the partition requirement is due to potential differences between th=
e code
> in bootsector, or more precisely - $Boot - first 8KiB of ntfs partiti=
on).
>
> Obvious requirements besides the above (ntldr, perhaps $Boot as well)=
 are:
>
> - mentioned "hidden sectors" (must be manually adjusted, recent sysli=
nux's
> chain.c32 has option to do it automatically)
> - adjusted boot.ini (to point to new partition, eventually other wind=
owish
> stuff as necessary)
>
> As you can see, there're many "if"s and combinations here that I didn=
't
> test.
>
> On a related note - ironically, while I had 0 problems making it work
> through syslinux (both regular chaining and through direct ntldr load=
ing) -
> I couldn't make win7's bootmgr (bcd, bcdedit ....) do it properly. Oh=
 well.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
