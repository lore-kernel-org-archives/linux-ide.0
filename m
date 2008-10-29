From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/2] cmd64x: set IDE_HFLAG_SERIALIZE explictly for CMD646
Date: Thu, 30 Oct 2008 00:42:29 +0100
Message-ID: <200810300042.29405.bzolnier@gmail.com>
References: <200810272058.54522.bzolnier@gmail.com> <200810300010.06303.bzolnier@gmail.com> <4908F240.2020606@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:53881 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbYJ2XpL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Oct 2008 19:45:11 -0400
Received: by ug-out-1314.google.com with SMTP id 39so791843ugf.37
        for <linux-ide@vger.kernel.org>; Wed, 29 Oct 2008 16:45:09 -0700 (PDT)
In-Reply-To: <4908F240.2020606@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Thursday 30 October 2008, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>>>>>> * Set IDE_HFLAG_SERIALIZE explictly for CMD646.
> >>>>>>>           
> >>>>>>>               
> >>>>>>  Was that some kernel.org bug that this is fixing?
> >>>>>>         
> >>>>>>             
> >>>>> Nope (AFAIK).
> >>>>>       
> >>>>>           
> >>>>     User report then?
> >>>>     
> >>>>         
> >>> Nope as far as my inbox tells me.
> >>>   
> >>>       
> >>    Then whar's the reason? :-)
> >>     
> >
> > From the patch description:
> >
> > 	* Set IDE_HFLAG_SERIALIZE explictly for CMD646.
> >
> > 	* Remove no longer needed ide_cmd646 chipset type (which has
> > 	  a nice side-effect of fixing handling of unexpected IRQs).
> >
> > The latter is possible because of the former
> > (see ide-probe.c::init_irq() for details).
> >   
> 
>    Ah, got it at last. But I doubt that 646 *really* needs serialization...

I remember getting bugreport which supposedly was fixed by commit
deffca117b90dadec395c0cf3ee816de27dfe2fd (but it could also be that
it was something else in reality or that it just hide some other
bug that we fixed in the meantime).

We would need somebody with the hardware to verify it.
