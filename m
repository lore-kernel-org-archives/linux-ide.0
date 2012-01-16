From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata updates for 3.3
Date: Mon, 16 Jan 2012 12:02:32 -0800
Message-ID: <CA+55aFzXFyHTUv=8NtSmXA2UY_qO5P=HXdGnhUmF9YoA5vpX1g@mail.gmail.com>
References: <20120109003255.GA6598@havoc.gtf.org> <CA+55aFwcBQSoWfqdT9CxV=GAr5ex0=RnqtBDFty+=_Lua2VXGw@mail.gmail.com>
 <4F12E57E.3090805@garzik.org> <1326676534.13517.3.camel@minggr>
 <1326691403.13517.21.camel@minggr> <CA+55aFzqECJjbtgyOXy_H1smh09SsfgrAuVY7hK2sC-xj1GZHg@mail.gmail.com>
 <20120116194211.2cd09fb3@pyramind.ukuu.org.uk> <CA+55aFxNcAtCmzEejS=3+_L_rp-MOBS0yLS061YgiCsFw_Mt5Q@mail.gmail.com>
 <20120116195427.64edd96f@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:38022 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157Ab2APUCy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jan 2012 15:02:54 -0500
In-Reply-To: <20120116195427.64edd96f@pyramind.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Matthew Garrett <mjg@redhat.com>
Cc: Lin Ming <ming.m.lin@intel.com>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Mon, Jan 16, 2012 at 11:54 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> Just ping Matthew about
>
> http://www.codon.org.uk/~mjg59/tmp/ahci_quirk_cleanup.diff

Hmm. This with just a setup option to enable it might well be good
enough. No need for whitelists/blacklists, since we couldn't maintain
those sanely anyway.

Matthew?

Googling shows that there's a few old bugreports for this too (big
surprise: macs):

  https://bugs.launchpad.net/ubuntu/+source/linux-source-2.6.20/+bug/96692

and various other ones..

                 Linus

                      Linus
