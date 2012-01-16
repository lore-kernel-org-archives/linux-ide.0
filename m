From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata updates for 3.3
Date: Mon, 16 Jan 2012 12:21:20 -0800
Message-ID: <CA+55aFxUyBvkAhQZFKDuiJrMx9sR2Nb3s5F3P8wDLa4eNspJ1Q@mail.gmail.com>
References: <20120109003255.GA6598@havoc.gtf.org> <CA+55aFwcBQSoWfqdT9CxV=GAr5ex0=RnqtBDFty+=_Lua2VXGw@mail.gmail.com>
 <4F12E57E.3090805@garzik.org> <1326676534.13517.3.camel@minggr>
 <1326691403.13517.21.camel@minggr> <CA+55aFzqECJjbtgyOXy_H1smh09SsfgrAuVY7hK2sC-xj1GZHg@mail.gmail.com>
 <20120116194211.2cd09fb3@pyramind.ukuu.org.uk> <CA+55aFxNcAtCmzEejS=3+_L_rp-MOBS0yLS061YgiCsFw_Mt5Q@mail.gmail.com>
 <20120116195427.64edd96f@pyramind.ukuu.org.uk> <CA+55aFzXFyHTUv=8NtSmXA2UY_qO5P=HXdGnhUmF9YoA5vpX1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36835 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754348Ab2APUVm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jan 2012 15:21:42 -0500
In-Reply-To: <CA+55aFzXFyHTUv=8NtSmXA2UY_qO5P=HXdGnhUmF9YoA5vpX1g@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Matthew Garrett <mjg@redhat.com>
Cc: Lin Ming <ming.m.lin@intel.com>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Mon, Jan 16, 2012 at 12:02 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>>
>> http://www.codon.org.uk/~mjg59/tmp/ahci_quirk_cleanup.diff
>
> Hmm. This with just a setup option to enable it might well be good
> enough. No need for whitelists/blacklists, since we couldn't maintain
> those sanely anyway.

That patch doesn't work for me. I get a panic in ahci_enable_ahci,
looks like 'mmio' is bogus there (attempting to dereference 0x01ffe6).

I notice that the PIIX device doesn't have any MMIO at all, it's all
PIO. Maybe there is some "need to enable MMIO thing" too. Or maybe I
used the wrong PCI ID when I added it to the quirk table.

                       Linus
