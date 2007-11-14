From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: [BUG] New Kernel Bugs
Date: Wed, 14 Nov 2007 14:39:58 -0700
Message-ID: <200711141439.58200.vda.linux@googlemail.com>
References: <20071113031553.3c7b5c16.akpm@linux-foundation.org> <20071114133034.GR17785@parisc-linux.org> <473AF9A5.50707@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.243]:7407 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298AbXKNVkZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Nov 2007 16:40:25 -0500
Received: by an-out-0708.google.com with SMTP id b36so63523ana
        for <linux-ide@vger.kernel.org>; Wed, 14 Nov 2007 13:40:25 -0800 (PST)
In-Reply-To: <473AF9A5.50707@suse.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>, Matthew Wilcox <matthew@wil.cx>
Cc: Adrian Bunk <bunk@kernel.org>, Theodore Tso <tytso@mit.edu>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, protasnb@gmail.com, linux-ide@vger.kernel.org, Benoit Boissinot <bboissin@gmail.com>, Mark Lord <liml@rtr.ca>, Ingo Molnar <mingo@elte.hu>, David Miller <davem@davemloft.net>

hi Matthew,

On Wednesday 14 November 2007 06:35, Hannes Reinecke wrote:
> Matthew Wilcox wrote:
> > On Wed, Nov 14, 2007 at 12:46:20AM -0700, Denys Vlasenko wrote:
> >> Finally they replied and asked to rediff it against their
> >> git tree. I did that and sent patches back. No reply since then.
> >>
> >> And mind you, the patch is not trying to do anything
> >> complex, it mostly moves code around, removes 'inline',
> >> adds 'const'. What should I think about it?
> >
> > I'm waiting for an ACK/NAK from Hannes, the maintainer.  What should I
> > do?

You could have informed me about this, and I would talk to Hannes
myself. This would free up your mind from keeping track of this
particular patch.
Parallelize development, prevent things from being forgotten.


Hi Hannes,

> I haven't actually been able to test it here (too busy, sorry). If someone
> else confirms it does it's job then
>
> Acked-by: Hannes Reinecke <hare@suse.de>

It's not in my mailbox on this machine, gladly we have lkml archived
in the Net. Here is a positive tester report:

http://lkml.org/lkml/2007/10/15/168:

======================
Date	Mon, 15 Oct 2007 15:53:08 +0200
From	Gabriel C <>
Subject	Re: [PATCH 0/3] debloat aic7xxx and aic79xx drivers

>> Compile tested and applies cleanly to 2.6.23.
>> I don't have this hardware anymore and cannot run test these patches.
> 
> I can test these patches on an aic7892 controller later on today if you 
want.

Works fine for me tested on :

03:0e.0 SCSI storage controller [0100]: Adaptec AIC-7892P U160/m [9005:008f] 
(rev 02)

Gabriel
=======================

--
vda
