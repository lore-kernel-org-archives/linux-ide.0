From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Thu, 14 May 2009 20:58:43 +0200
Message-ID: <200905142058.43377.bzolnier@gmail.com>
References: <49CCD7C4.8000207@inov.pt> <4A0C470B.8040609@ru.mvista.com> <4A0C4897.5050207@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:63611 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663AbZENTkJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 May 2009 15:40:09 -0400
Received: by fxm2 with SMTP id 2so1523416fxm.37
        for <linux-ide@vger.kernel.org>; Thu, 14 May 2009 12:40:09 -0700 (PDT)
In-Reply-To: <4A0C4897.5050207@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: =?iso-8859-1?q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Thursday 14 May 2009 18:36:39 Sergei Shtylyov wrote:
> Hello, I wrote:
> 
> >>>>> I'm not sure what you're getting at with "such advices"... :)
> 
> >>>>> We need to cast somewhere anyway so we may as well cast from 'void 
> >>>>> *' to
> >>>>> 'unsigned int' where needed and not the other way around (or rather 
> >>>>> from
> >>>>> 'unsigned int' to 'struct ide_timing *') -- which would be an ugly 
> >>>>> hack
> >>>>> and could cause maintainability/portability problems later.
> 
> >>>>> BTW it seems like a good occasion to add ide_{get,set}_drivedata() 
> >>>>> helpers
> >>>>> (ala existing ide_{get,set}_hwifdata() ones) to <linux/ide.h> and 
> >>>>> thus make
> >>>>> internal IDE API more coherent.
> 
> >>>>> [ Yes, I know that we may get away with s/unsigned int/unsigned long/
> >>>>>  and casting it to 'struct ide_timing *' for now but it always better
> >>>>>  to at least consider more elegant solution first... ]
> 
> >>>    Changing a lot of drivers is more elegant than not? Doubt it.
> 
> >>>    And don't tell me this patch is "elegant"... :-/
> 
> >> Well, it is makes code more coherent and more maintainable...
> 
> >> Moreover those inline helpers serve as a part of documentation (though
> >> real DocBook documentation would also be nice) for host drivers authors.
> 
> >> Either this or we should remove ide_{get,set}_hwifdata() and allow
> >> host drivers to poke directly also at hwif->hwif_data...
> 
>     Besides, some drivers like siimage.c do poke hwif->hwif_data directly.

siimage.c seems to be the only driver doing it so this is rather exception
from the rule...

[ modulo one occurrence in scc_pata.c but this driver uses inline helpers ]

> >    Seems like a good idea. I'm not sure why these fields should be special.
> 
>     While there are a number of 'ide_hwif_t' fields like 'select_data' or 
> 'config_data' that are being poked directly...

I think that it would be better to remove these extra fields and stop
pretending that they are used for storing similar things across different
host drivers (cause they are not and things stored there are host driver
specific)...

If host driver needs more "local storage" it should allocate private data
structures and use ide_{get,set}_hwifdata() to access them (like it821x.c).

With a bit of invention[1] it seems to be entirely possible to switch all
current users (maybe except tc86c001.c, though I'm not sure) of ->config_data
and ->select_data to just use ->hwif_data...

Once I find some time I'll try to cook some patches to see how it looks
(unless of course somebody beats me to it)...

[1] i.e.:

* scc_pata.c: we may just use pci_get_drvdata()
  (+ none of hwif->config_data users is in the hot-path)

* trm290.c: after removing dead (maybe even since the initial merge
  years ago) DMA support hwif->select_data will no longer be needed

Thanks,
Bart
