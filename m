From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 6/6] drivers/ide: Convert printk(KERN_NOTICE to pr_notice(
Date: Mon, 18 May 2009 15:50:07 +0200
Message-ID: <200905181550.07723.bzolnier@gmail.com>
References: <cover.1242609803.git.joe@perches.com> <4A11343C.5070809@ru.mvista.com> <m3skj2im12.fsf@intrepid.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:64575 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbZERNpv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 May 2009 09:45:51 -0400
In-Reply-To: <m3skj2im12.fsf@intrepid.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Monday 18 May 2009 15:22:01 Krzysztof Halasa wrote:
> Sergei Shtylyov <sshtylyov@ru.mvista.com> writes:
> 
> >>  			} else {
> >>  				floppy->blocks = blocks;
> >>  				floppy->block_size = length;
> >>  				floppy->bs_factor = length / 512;
> >>  				if (floppy->bs_factor != 1)
> >> -					printk(KERN_NOTICE PFX "%s: Warning: "
> >> -					       "non 512 bytes block size not "
> >> -					       "fully supported\n",
> >> -					       drive->name);
> >> +					pr_notice(PFX "%s: Warning: non 512 bytes block size not fully supported\n",
> >>   
> >
> >   Again.
> 
> (> 80 chars in line)
> 
> Though I think most people would agree that the latter is much better,
> no?

No, it just hides the real issue:

Please factor out descriptor parsing from ide_floppy_get_capacity()
and remove superfluous "Warning: " part of the message instead if you
want something much better.

It is also a real pain for people depending on some kind of automatic
verification of patches (infamous checkpatch.pl ;).

> I think removal (rewording) of this rule has already been agreed upon,
> though not exactly yet codified.

This is not a strict rule but in 99% cases it shows that the code could
be improved further without >80 chars lines.

Thanks.
Bart
