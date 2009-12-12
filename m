From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 00/86] PATA fixes
Date: Sat, 12 Dec 2009 04:23:46 +0100
Message-ID: <200912120423.46712.bzolnier@gmail.com>
References: <20091125170218.5446.13513.sendpatchset@localhost> <200912032201.55115.bzolnier@gmail.com> <alpine.DEB.2.00.0912111801420.10307@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933819AbZLLD0G@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.0912111801420.10307@asgard.lang.hm>
Sender: linux-kernel-owner@vger.kernel.org
To: david@lang.hm
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Saturday 12 December 2009 03:02:43 am david@lang.hm wrote:
> On Thu, 3 Dec 2009, Bartlomiej Zolnierkiewicz wrote:
> 
> > On Thursday 03 December 2009 09:39:39 pm Jeff Garzik wrote:
> >> On 12/03/2009 03:26 PM, Bartlomiej Zolnierkiewicz wrote:
> >>> On Thursday 03 December 2009 09:11:19 pm Jeff Garzik wrote:
> >>>> On 12/03/2009 02:45 PM, Bartlomiej Zolnierkiewicz wrote:
> >>>>> On Thursday 03 December 2009 06:53:59 pm Jeff Garzik wrote:
> >>>>>> On 12/03/2009 07:39 AM, Bartlomiej Zolnierkiewicz wrote:
> >>>>>>> On Thursday 03 December 2009 09:07:41 am Jeff Garzik wrote:
> >>>>>>>> The merge window is upon us, which by strict rules means that anything
> >>>>>>>> not already in libata-dev.git#upstream needs to wait until 2.6.34.
> >>>>>>>>
> >>>>>>>> However, bug fixes and the like should definitely be in 2.6.33.
> >>>>>>>> ->init_host is definitely 2.6.34 material.  Some of the other stuff
> >>>>>>>> could go either way.
> >>>>>>
> >>>>>>> If you would like to apply some of my patches to 2.6.33 you are more than
> >>>>>>> welcome to do it.  I can even prepare separate git tree with specific changes
> >>>>>>> to make it easier for you once you tell me which changes you would like to
> >>>>>>> see in it.
> >>>>>>
> >>>>>> OK, great.
> >>>>>>
> >>>>>> Can you prepare a patchset containing only fixes?  Comment-only changes
> >>>>>> are acceptable too.  Trivial changes too, if they are extremely trivial :)
> >>>>>>
> >>>>>> Include nothing that adds features, removes or unifies drivers, etc.
> >>>>>
> >>>>> Since this is pretty high-level description and some changes fall into
> >>>>> many categories at once (i.e. addition of proper PCI Power Management
> >>>>> handling could be considered both as a fix and as a feature) I prepared
> >>>>> a rather conservative set of changes (which means that unfortunately
> >>>>> it misses many enhancements available in my tree):
> >>>>>
> >>>>>> Please do it in standard kernel submit form, which is either
> >>>>>> (a) repost the patches (yes, again) being submitted for 2.6.33, or
> >>>>>> (b) a standard git pull request, which includes shortlog, diffstat, and
> >>>>>> all-in-one diff.
> >>>>>
> >>>>> Thank you for the detailed explanation of the standard kernel submit
> >>>>> form (I wonder how would I know this otherwise :) but the thing is that
> >>>>> at the current moment I'm not submitting anything to the upstream.
> >>>>
> >>>> Ok, that explains my confusion, then.  I had thought you intended to get
> >>>> this stuff upstream, and into users' hands.
> >>>
> >>> Interesting argument but the vast majority of users use distribution kernels
> >>> which are not upstream and I doubt that any self-respecting distribution would
> >>> miss such amount of fixes.
> >>
> >> Interesting argument, but applied across 1000+ developers this is
> >> clearly an unscalable development model for distributions.  Thus,
> >
> > Interesting that you have brought distributions' convenience before
> > non-distribution developers' one.
> 
> and you are leaving those of us who use kernel.org out in the cold 
> (forcing all non-distribution users to go through all the work that Jeff 
> described)

[ ..and you believed it? ;) ]

> I'm not sure who you see as benifiting from this approach.

I'm not the maintainer of the affected code (according to MAINTAINERS
at least PATA code is unmaintained and to add more confusion it has been
in such state forever despite numerous claims of said code being the
'official' one ) so I think that you are barking at the wrong tree here..

Moreover the claim of forcing people to do the work was completely
ridiculous (BTW all the changes happen in my own time) since I did/do
a lot to make review/merge easier for people:

- My tree is based on top of libata tree and stays up-to-date with it.

- All changes have been posted to linux-ide and linux-kernel, and they
  had review concerns addressed already (there was only one real issue,
  Alan has noticed that scc_pata change is unnecessary).

- I'm OK with providing additional branches with only selected changes
  to ease the merging process.

--
Bartlomiej Zolnierkiewicz
