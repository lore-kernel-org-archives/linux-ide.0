From: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: [BUG 2.6.7] : Partition table display bogus...
Date: Thu, 24 Jun 2004 00:56:40 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040623225640.GE3072@pclin040.win.tue.nl>
References: <20040623220557.GA26199@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kweetal.tue.nl ([131.155.3.6]:19469 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262009AbUFWW4w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Jun 2004 18:56:52 -0400
Content-Disposition: inline
In-Reply-To: <20040623220557.GA26199@bougret.hpl.hp.com>
List-Id: linux-ide@vger.kernel.org
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl

On Wed, Jun 23, 2004 at 03:05:57PM -0700, Jean Tourrilhes wrote:

> 	Playing with 2.6.7 on my laptop. I realised Lilo did not work
> anymore. Look further, and the partition table was all screwed up.

Not so pessimistic.

Old situation:
>  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
New situation:
>  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >

Nothing wrong with that partition table.

Maybe you get unhappy because of the fdisk output, but that only
shows that you have an old fdisk. Also there nothing wrong.

Ah - so the only wrong thing must be the fact that lilo stopped working.
I suppose things will improve if you give it the "linear" (or "lba32") flag.

What changed is that the kernel no longer attempts at guessing a geometry.
If such guessing is required, user space must do so itself.

Andries
