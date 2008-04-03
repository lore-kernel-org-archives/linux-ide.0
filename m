From: "Boris Petkov" <petkovbb@googlemail.com>
Subject: Re: Proposed patch for IDE missing commands
Date: Thu, 3 Apr 2008 17:42:32 +0200
Message-ID: <9ea470500804030842ne89877dg840c960eb44f0219@mail.gmail.com>
References: <47F47324.80108@free.fr>
	 <9ea470500804030228p3077456ai4a756aa46116aa4c@mail.gmail.com>
	 <200804031220.07380.elendil@planet.nl>
	 <47F4F6D7.4050908@s5r6.in-berlin.de>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.186]:52767 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757684AbYDCPme convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Apr 2008 11:42:34 -0400
Received: by rn-out-0910.google.com with SMTP id e24so2124099rng.1
        for <linux-ide@vger.kernel.org>; Thu, 03 Apr 2008 08:42:33 -0700 (PDT)
In-Reply-To: <47F4F6D7.4050908@s5r6.in-berlin.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Frans Pop <elendil@planet.nl>, x.guimard@free.fr, linux-kernel@vger.kernel.org, bzolnier@gmail.com, linux-ide@vger.kernel.org

On Thu, Apr 3, 2008 at 5:25 PM, Stefan Richter
<stefanr@s5r6.in-berlin.de> wrote:
> Frans Pop wrote:
>  > Boris Petkov wrote:
>  >> Please, rebase/redo your patch against latest -rc kernel (in this=
 case
>  >> 2.6.25-rc8) und run it through scripts/checkpatch.pl in order to =
adjust it
>  >> to the kernel coding style. See Documentation/CodingStyle for det=
ails.
>
>  Why don't linux kernel insiders help first-time contributors here a =
bit
>  and simply repost the patch with style fix-up?  That would be a matt=
er
>  of 10 minutes or so and a more valuable contribution than a mere
>  RTFCodingStyle.

Well, it'll probably take the same time to run checkpatch.pl on it and
simply do what the
tool suggests wrt to style - after all this can't be more complex than
writing kernel code
in itself, now can it? What is more, my suggestion was also to _redo_
the patch against a more
recent kernel version since ide-disk has changed since then and, even
disregarding code
style issues, the patch is inapplicable as such (e.g. deleted
functions) Finally, despite all
that who's-doing-what soul searching, redoing patches has a great
didactical value which
all of us have experienced time and again :).


--=20
Regards/Gru=DF,
Boris
