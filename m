From: Tejun Heo <tj@kernel.org>
Subject: Re: ATA 4 KiB sector issues.
Date: Wed, 10 Mar 2010 09:26:02 +0900
Message-ID: <4B96E71A.9070701@kernel.org>
References: <4B947393.2050002@kernel.org>	 <1268031640.4389.11.camel@mulgrave.site> <4B94ACE8.4060400@zytor.com> <87f94c371003091446h62e50257qf884b278c69cfbfa@mail.gmail.com> <4B96E25B.7050200@kernel.org> <3E0C3AE547FA504DA5E89EA5A24AC85803E2BD80@wdscexbe01.sc.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39015 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755788Ab0CJA1B (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Mar 2010 19:27:01 -0500
In-Reply-To: <3E0C3AE547FA504DA5E89EA5A24AC85803E2BD80@wdscexbe01.sc.wdc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Taylor <Daniel.Taylor@wdc.com>
Cc: Greg Freemyer <greg.freemyer@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, James Bottomley <James.Bottomley@suse.de>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de, mkp@mkp.net

Hello,

On 03/10/2010 09:14 AM, Daniel Taylor wrote:
> The MBR in a GPT installation doesn't map the first GPT partition,
> it maps the entire drive drive after the first sector, as well as
> marking it type 0xEE.

Yeah, yeah, that was exactly what I was saying by "describing the rest
of the whole disk as a single chunk containing GPT managed area" with
a typo making "whole" "while".

> The start LBA of the file system is not correctly located in the
> MBR.

Sure it's not but MBR belongs to the boot loader not the BIOS.  BIOS
just needs to load MBR and handles control to it.  If the MBR or more
likely later stages of the bootloader loaded by MBR knows how to boot
from GPT, it should work.

> I will run some experiments to see if any of the systems on my desk can boot
> Linux from a GPT.

I'm not sure about grub although I strongly suspect recent version of
it should work but AFAICS lilo should definitely work as it doesn't
care how the disk is logically organized at all.

Thanks.

-- 
tejun
