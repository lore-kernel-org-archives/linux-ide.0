From: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [git pull] IDE fixes
Date: Sun, 7 Jun 2009 21:21:11 +0300
Message-ID: <84144f020906071121k34d6d555i6332d49b0db0fac6@mail.gmail.com>
References: <200906071444.33047.bzolnier@gmail.com>
	 <200906071744.23629.bzolnier@gmail.com>
	 <84144f020906070954p54cdfee4y62a51795be10b0d0@mail.gmail.com>
	 <200906071955.42378.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:64628 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbZFGSVK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Jun 2009 14:21:10 -0400
In-Reply-To: <200906071955.42378.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Bartlomiej,

On Sun, Jun 7, 2009 at 8:55 PM, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
> On Sunday 07 June 2009 18:54:08 Pekka Enberg wrote:
>> Hi Bartlomiej,
>>
>> On Sun, Jun 7, 2009 at 6:44 PM, Bartlomiej Zolnierkiewicz
>> <bzolnier@gmail.com> wrote:
>> > Honestly, this should be solved on technical basis by somebody pos=
ting
>> > needed libata patches instead of attempts to slow down IDE fixes.
>>
>> Nobody is "slowing down" IDE fixes here. Linus explicitly said that
>> -rc8 is the last release candidate and the next one is going to be
>> -final. There's absolutely _no way_ this series is appropriate at th=
e
>> very end of a release cycle.
>
> My honest opinion is that it is as appropriate now as it will be 2.6.=
31.
>
> [ I'm still amazed by the amount of *completely* bogus reasons given =
for
> =A0not merging it. ]

I don't consider this a bogus reason at all:

 10 files changed, 134 insertions(+), 43 deletions(-)

Just search the LKML archives for the amount of crap other subsystem
maintainers have gotten from Linus when they've tried to sneak
something like that after -rc4 or so.

                        Pekka
