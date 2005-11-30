From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: sata suspend status?
Date: Tue, 29 Nov 2005 16:41:04 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0511291636000.27404@shark.he.net>
References: <1133020582.438885a6615dc@www.ijichi.org>
 <20051127205613.18f48772.rdunlap@xenotime.net> <1133169049.438ac999da2ab@www.ijichi.org>
 <Pine.LNX.4.58.0511281439300.13751@shark.he.net> <1133310840.438cf3782abee@www.ijichi.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:52870 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750736AbVK3AlG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Nov 2005 19:41:06 -0500
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <linux-ide@vger.kernel.org>; Tue, 29 Nov 2005 16:41:04 -0800
In-Reply-To: <1133310840.438cf3782abee@www.ijichi.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dominic Ijichi <dom@ijichi.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-ide@vger.kernel.org

On Wed, 30 Nov 2005, Dominic Ijichi wrote:

> Quoting "Randy.Dunlap" <rdunlap@xenotime.net>:
>
> > On Mon, 28 Nov 2005, Dominic Ijichi wrote:
> >
> > > Quoting "Randy.Dunlap" <rdunlap@xenotime.net>:
> > >
> > > > On Sat, 26 Nov 2005 15:56:22 +0000 Dominic Ijichi wrote:
> > > >
> > > > > hello

[snip]

> > > > Hi,
> > > > It seems to work for some people.  I don't know if that's just
> > > > good luck or that some controllers don't need the SATA ACPI methods
> > > > that I am working on.  We should know more about that in the next
> > > > few weeks, I hope.
> > >
> > > hiya
> > > can't work out how to apply your patches, have tried against 2.6.15-rc2
> > with
> > > symlinked directories but everything rejects.  sorry for my ignorance,
> > would
> > > like to try these out!
> >
> > Sorry about that.  I'll correct that and repost with exact
> > info about correct kernel version to use.
>
> hmm, i must have cut and paste them wrongly as i get failed hunks.  is there a
> decent archive of the mailing list?  the MARC one pointed to from kernel.org
> doesnt seem to update or have attachments.

Cut-n-paste often converts tabs to spaces, so that could be
the problem.  (BTW, I double-checked after your first email
and verified that they applied cleanly.)

MARC has the patches -- and none of them were sent as
attachments.

1 of 5: http://marc.theaimsgroup.com/?l=linux-ide&m=113279087717303&w=2
then click on "Download message RAW"

2 of 5: http://marc.theaimsgroup.com/?l=linux-ide&m=113279088931675&w=2
and Download message RAW

3 of 5: http://marc.theaimsgroup.com/?l=linux-ide&m=113279087922204&w=2
and Download message RAW

4/5:  http://marc.theaimsgroup.com/?l=linux-ide&m=113279088127703&w=2
and Download message RAW

5/5:  http://marc.theaimsgroup.com/?l=linux-ide&m=113279088916977&w=2
and Download message RAW


> > However, these current patches won't get you much additional help
> > for SATA suspend/resume since they lack writing the taskfile data
> > to the controller ports.
>
> really look forward to it!
>
> thanks for your work
> dom

I'll also put them on a web site for download after I have these
changes made.

-- 
~Randy
