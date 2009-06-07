From: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [git pull] IDE fixes
Date: Sun, 7 Jun 2009 22:09:47 +0300
Message-ID: <84144f020906071209m51e5fd15jaa67f9143ab1d126@mail.gmail.com>
References: <200906071444.33047.bzolnier@gmail.com>
	 <200906071955.42378.bzolnier@gmail.com>
	 <84144f020906071121k34d6d555i6332d49b0db0fac6@mail.gmail.com>
	 <200906072100.10649.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:36348 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755241AbZFGTJs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Jun 2009 15:09:48 -0400
In-Reply-To: <200906072100.10649.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Bartlomiej,

On Sun, Jun 7, 2009 at 10:00 PM, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
>> > My honest opinion is that it is as appropriate now as it will be 2=
=2E6.31.
>> >
>> > [ I'm still amazed by the amount of *completely* bogus reasons giv=
en for
>> > =A0not merging it. ]
>>
>> I don't consider this a bogus reason at all:
>>
>> =A010 files changed, 134 insertions(+), 43 deletions(-)
>
> Since when do we validate code quality based solely on LOC changed? :=
)

Since when we entered -rc8 (or even earlier).

On Sun, Jun 7, 2009 at 10:00 PM, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
> I'm yet to see anybody posting a single code chunk in this whole disc=
ussion.

That's because I am not objecting to the code. I am objecting to the
fact that you're submitting something as big as this so late in the
release cycle and the fact that it's not a clear-cut bug fix.

But anyway, I don't really want to argue about this. I simply wanted
to point out that I agree with Alan's and James' comments and that I
don't think they have anything to do with "slowing down IDE fixes" but
rather with how the whole release cycle with fixed merge window works.

                        Pekka
