From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Linux 2.6.26-rc4
Date: Wed, 28 May 2008 19:59:17 -0400
Message-ID: <483DF1D5.9030706@tmr.com>
References: <alpine.LFD.1.10.0805261127030.2958@woody.linux-foundation.org> <20080527120128.7074c1bc@werewolf.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.tmr.com ([64.65.253.246]:49041 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751165AbYE1XrK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 May 2008 19:47:10 -0400
In-Reply-To: <20080527120128.7074c1bc@werewolf.home>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?=22J=2EA=2E_Magall=F3n=22?= <jamagallon@ono.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Linus-IDE <linux-ide@vger.kernel.org>

J.A. Magall=F3n wrote:
> On Mon, 26 May 2008 11:41:35 -0700 (PDT), Linus Torvalds <torvalds@li=
nux-foundation.org> wrote:
>=20
>> You know the drill by now: another week, another -rc.
>>
>> There's a lot of small stuff in here, most people won't even notice.=
 The=20
>> most noticeable thing is for all you 32-bit x86 people who use PAE=20
>> (enabled by the HIGHMEM64G config option) due to having too much mem=
ory in=20
>> your machine - mprotect() was broken due to some of the PAT fix/clea=
nup=20
>> patches, causing the NX bit to be not set correctly.
>>
>> So if you had PAE enabled _and_ a recent enough CPU to have NX, but =
not=20
>> recent enough to be 64-bit (or you were just perverse and wanted to =
run a=20
>> 32-bit kernel despite having a chip that could do 64-bit and enough =
memory=20
>> that you _really_ should have used a 64-bit kernel), you'd get vario=
us=20
>> random program failures with SIGSEGV. It ranged from X not starting =
up to=20
>> apparently OpenOffice not working if it did.
>>
>> But most of the changes, as usual, are in drivers, at 60%, with some=
 DRI=20
>> changes leading the way (fixing a number of other regressions, mainl=
y by=20
>> reverting the under-cooked vblank update). Network, MMC, USB, watchd=
og and=20
>> IDE drivers also got updates.
>>
>> We had CIFS and NFS updates, and some arch updates as usual. The dir=
stat=20
>> gives the overview:
>>
>=20
> I have this patchsets collected from LKML, that still apply ontop of =
-rc4.
> Are they not so urgent or are they not needed any more ?
>=20
> JBD[2] races
> http://marc.info/?l=3Dlinux-ext4&m=3D121141319601650&w=3D2
> http://marc.info/?l=3Dlinux-ext4&m=3D121141319701660&w=3D2
>=20
Unless I misread the thread, akpm had a raft of issues with the first=20
one, all of which were spelling except one initialization which he=20
thought was not needed. All of those could be fixed in less effort that=
=20
it takes to mention them, perhaps, but even so I think the patch could=20
be ready in a short time.

The problem looks worth fixing to me, but probably not a must have at=20
the rc4 level. Maybe in 2.6.27 we could get rid of the potential race?


--=20
Bill Davidsen <davidsen@tmr.com>
   "We have more to fear from the bungling of the incompetent than from
the machinations of the wicked."  - from Slashdot

