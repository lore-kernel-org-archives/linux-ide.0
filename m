From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/2] hpt366: UltraDMA filtering for SATA cards
Date: Sat, 11 Aug 2007 18:30:24 +0200
Message-ID: <200708111830.24516.bzolnier@gmail.com>
References: <200708060008.38077.sshtylyov@ru.mvista.com> <200708102316.09960.bzolnier@gmail.com> <46BDD989.6060202@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:1255 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbXHKQbH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Aug 2007 12:31:07 -0400
Received: by fk-out-0910.google.com with SMTP id z23so983279fkz
        for <linux-ide@vger.kernel.org>; Sat, 11 Aug 2007 09:31:05 -0700 (PDT)
In-Reply-To: <46BDD989.6060202@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: rah@bash.sh, linux-ide@vger.kernel.org

On Saturday 11 August 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>>>Index: linux-2.6/drivers/ide/pci/hpt366.c
> >>>>===================================================================
> >>>>--- linux-2.6.orig/drivers/ide/pci/hpt366.c
> >>>>+++ linux-2.6/drivers/ide/pci/hpt366.c
> 
> [...]

> >>>IMO all HPT*_ALLOW_ATA* defines should just go away...
> 
> >>    I think it's still worth to keep 'em alive for the possible blacklist 
> >>additions.
> 
> > No strong feelings about these defines but I think that they actually make
> > the code less readable and also more complex because they control _both_
> > DPLL used (through controlling max_ultra) and the maximum UDMA mask.
> 
>     That's because the maximum UDMA mask depends on the DPLL frequency...
> 
> > Moreover they are _compile_ time options so for testing purposes we may
> > as well ask user to change UDMA mask etc.
> 
>     ... and UltraDMA/100 is *not* reachable with 66 MHz clock (it will have to 
> use the same timings as UltraDMA/66 -- so changing the mask only is just not 
> enough.
> 
>     Now you can hopefully see that these #define's as they are now exist for a 
> good reason... :-)

Yes but I still believe that there should be some cleaner solution... ;)

> >>>Also now that ->udma_filter is always present the initial hwif->ultra_mask
> >>>doesn't matter so as well we may set it to ATA_UDMA6 (0x7f) and cleanup
> >>>struct hpt_info (by removing max_ultra after fixing init_chipset_hpt366()
> >>>to use info->chip_type >= HPT374 check instead),
> 
> >>    It's all interesting but you've missed one aspect -- this will make the 
> >>kernel larger while the current code keeps all this logic in the init.text 
> >>section.
> 
> > We won't be adding a single line of new code:
> 
> > - the current ->udma_filter implementation does everything needed already
> 
>     Not really. It will return 0x7f for chipset not supporting it

Which is 100% correct given current values of HPT*_ALLOW_ATA133_6 defines.

> > - in init_chipset_hpt366() we simply would replace
> 
> > 		if (info->max_ultra > 6)
> 
>     Actually,( info->max_ultra == 6)

Yes.
 
> >   with
> 
> > 		if (info->chip_type >= HPT374)
> 
>     This is just wrong -- HPT374 does not tolarate 66 MHz clock.  You probably 
> meant HPT372 (or >)?

Yes, ">".

> >   (this change depends on the current HPT3xx enums order
> >    and on removal HPT*_ALLOW_ATA* defines)
> 
>     Heh, how about doing this (pardon for the bad... er, sed language):
> 
> 	default:
> 		return s/0x71/drive->hwif->ultra_mask/;
> 
> without all any changes that you've proposed and being done with that fix? :-)

I hope that you meant:

	default:
		return s/0x7f/drive->hwif->ultra_mask/;

Yep, I'm fine with it.

> >>>Uh, the only real change here consists of the three lines above, the rest
> >>>is just a noise caused by removal of one tab.
> 
> >>>Such changes are really not worth it - in this case it caused rejects in
> >>>two patches from IDE quilt tree which I had to fix manually.
> 
> >>    I hope now that you've fixed it, I may leave this part intact? ;-)
> 
> > Iff you base the new patch on top of IDE quilt tree otherwise I'll have
> > to fix it _again_. ;-)
> 
>     I hope you haven't forgotten the basic rule: "the fixes come first"? :-)

The basic rule is to keep the process steady. :-)

"The fixes come first" is the 2-nd rule and becomes a bit hard to keep up
when there is almost hundred patches in the series.

>     And why fix it again, if I'm not going to drop that part?

Indeed, there is no need to fix again...

Thanks,
Bart
