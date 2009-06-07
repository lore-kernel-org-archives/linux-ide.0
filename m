From: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [git pull] IDE fixes
Date: Sun, 7 Jun 2009 19:54:08 +0300
Message-ID: <84144f020906070954p54cdfee4y62a51795be10b0d0@mail.gmail.com>
References: <200906071444.33047.bzolnier@gmail.com>
	 <200906071657.49513.bzolnier@gmail.com>
	 <1244387931.8262.24.camel@mulgrave.site>
	 <200906071744.23629.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:45369 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754473AbZFGQyL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Jun 2009 12:54:11 -0400
In-Reply-To: <200906071744.23629.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Bartlomiej,

On Sun, Jun 7, 2009 at 6:44 PM, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
> Honestly, this should be solved on technical basis by somebody posting
> needed libata patches instead of attempts to slow down IDE fixes.

Nobody is "slowing down" IDE fixes here. Linus explicitly said that
-rc8 is the last release candidate and the next one is going to be
-final. There's absolutely _no way_ this series is appropriate at the
very end of a release cycle.

                         Pekka
