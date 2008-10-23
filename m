From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git pull] IDE updates #4
Date: Thu, 23 Oct 2008 23:07:14 +0200
Message-ID: <200810232307.15462.bzolnier@gmail.com>
References: <200810212100.52985.bzolnier@gmail.com> <48FFAFBB.8020709@ru.mvista.com> <49009EDA.2030707@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:61509 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753910AbYJWVuL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Oct 2008 17:50:11 -0400
Received: by ug-out-1314.google.com with SMTP id k3so6993ugf.37
        for <linux-ide@vger.kernel.org>; Thu, 23 Oct 2008 14:50:09 -0700 (PDT)
In-Reply-To: <49009EDA.2030707@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 23 October 2008, Sergei Shtylyov wrote:
> Hello, I wrote:
> 
> >>>> and number of new submitted patches is < 10 (I'll take
> >>>> care of fixing them up, ditto for all other new stuff that will be 
> >>>> using old
> >>>> naming scheme).
> 
> >>>    Thanks for clarifying this.
> >>>    This rename only added more uncertainty for my pending patchset 
> >>> (which had been already dependant on at least TX4939 driver which 
> >>> keeps being recast by Atsushi and being stale in pata-2.6 series) as 
> >>> I can't predict when you and Linus will merge the changes and this is 
> >>> getting on my nerves, as I don't have time on any extra rework and 
> >>> I'm running out of time with the submission. I know I should have 
> >>> done this earlier and     
> 
> >> Maybe some parts could be submitted separately?
> >> (so keeping them up-to-date in pata-2.6 would be my task)
> 
> >   2 (maybe even 3) out of 4 can be but that doesn't make much sense 
> > already (and would incur the patch reordering for me) -- the best thing 
> > you can do is to merge ASAP the last verison of TX4939 which has my ACK.
> > I'm not sure about TX4938 driver yet -- will look at it after some sleep...
> 
>     Still haven't looked at it... too little sleep and incuring headache. :-/
> 
> >> Also I didn't know anything about your patchset and its
> >> dependency on TX4939, otherwise I'll be pushing things in
> 
> >   The patchset consists of a large patch moving read_sff_dma_status() to 
> > its porper place, one small preparatory patch, and 2 followup patches, 
> > so unfortunately it's dependent on TX4939 in its main patch (worse, the 
> > relevant part of this driver has changed after your last merged driver 
> > version)...
> 
> >> different order or even skip this pull request if needed
> >> (TX493x drivers are new stuff and were still under review,
> >> such things can be also submitted after the merge window
> >> closes so they were given the lowest priority).
> 
> >   Unfortunately, that driver has been submitted first back 9/09, long 
> > before my patchset was even created, so the dependence was just natural.
> 
>     I could also rip out TX4939 part from the patch and leave Atsushi to deal 
> with the fallout (though I could give him the ripped out part to simply be 
> merged to the driver) if you would queue my patchset ahead of the driver. 
> Though I feel it's too late now for my patchset to get into 2.6.28 the way 
> things have been happening... :-/

Ehm, submitting things _before_ the merge window usually help. ;-)

Anyway, no need to get too frustrated over it.  It is normal that
sometimes you will need to push back your own changes if you're doing
more higher-level work...  though it takes a while to get used to it.
