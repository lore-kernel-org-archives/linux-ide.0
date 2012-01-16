From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] libata updates for 3.3
Date: Mon, 16 Jan 2012 15:27:08 -0500
Message-ID: <4F14881C.8040601@garzik.org>
References: <20120109003255.GA6598@havoc.gtf.org> <CA+55aFwcBQSoWfqdT9CxV=GAr5ex0=RnqtBDFty+=_Lua2VXGw@mail.gmail.com> <4F12E57E.3090805@garzik.org> <1326676534.13517.3.camel@minggr> <1326691403.13517.21.camel@minggr> <CA+55aFzqECJjbtgyOXy_H1smh09SsfgrAuVY7hK2sC-xj1GZHg@mail.gmail.com> <20120116194211.2cd09fb3@pyramind.ukuu.org.uk> <CA+55aFxNcAtCmzEejS=3+_L_rp-MOBS0yLS061YgiCsFw_Mt5Q@mail.gmail.com> <20120116195427.64edd96f@pyramind.ukuu.org.uk> <CA+55aFzXFyHTUv=8NtSmXA2UY_qO5P=HXdGnhUmF9YoA5vpX1g@mail.gmail.com> <CA+55aFxUyBvkAhQZFKDuiJrMx9sR2Nb3s5F3P8wDLa4eNspJ1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43294 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756401Ab2APU1M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jan 2012 15:27:12 -0500
In-Reply-To: <CA+55aFxUyBvkAhQZFKDuiJrMx9sR2Nb3s5F3P8wDLa4eNspJ1Q@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Matthew Garrett <mjg@redhat.com>, Lin Ming <ming.m.lin@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On 01/16/2012 03:21 PM, Linus Torvalds wrote:
> On Mon, Jan 16, 2012 at 12:02 PM, Linus Torvalds
> <torvalds@linux-foundation.org>  wrote:
>>>
>>> http://www.codon.org.uk/~mjg59/tmp/ahci_quirk_cleanup.diff
>>
>> Hmm. This with just a setup option to enable it might well be good
>> enough. No need for whitelists/blacklists, since we couldn't maintain
>> those sanely anyway.
>
> That patch doesn't work for me. I get a panic in ahci_enable_ahci,
> looks like 'mmio' is bogus there (attempting to dereference 0x01ffe6).
>
> I notice that the PIIX device doesn't have any MMIO at all, it's all
> PIO. Maybe there is some "need to enable MMIO thing" too. Or maybe I
> used the wrong PCI ID when I added it to the quirk table.

Part of the problem with force-enable is that the MMIO BAR may need a 
value, and not have it.  That, and an expectations mismatch between BIOS 
and kernel WRT mode (IDE/AHCI) has always been the reason why 
'ahci=force' never made it in.  It just never seemed to be reliable broadly.

I'm happy with anything we can get working reliably, even with the 
obvious proviso that 'ahci=force' would be a default-off, user-enabled 
option.  It's always been motherboard/BIOS issues that got in the way.

	Jeff





