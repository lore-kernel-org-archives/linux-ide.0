From: Dominic Ijichi <dom@ijichi.org>
Subject: Re: sata suspend status?
Date: Wed, 30 Nov 2005 01:32:04 +0000
Message-ID: <1133314324.438d0114556cd@www.ijichi.org>
References: <1133020582.438885a6615dc@www.ijichi.org> <20051127205613.18f48772.rdunlap@xenotime.net> <1133169049.438ac999da2ab@www.ijichi.org> <Pine.LNX.4.58.0511281439300.13751@shark.he.net> <1133310840.438cf3782abee@www.ijichi.org> <Pine.LNX.4.58.0511291636000.27404@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from buffy.ijichi.org ([213.161.76.94]:20475 "EHLO buffy.ijichi.org")
	by vger.kernel.org with ESMTP id S1750771AbVK3BcN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Nov 2005 20:32:13 -0500
In-Reply-To: <Pine.LNX.4.58.0511291636000.27404@shark.he.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-ide@vger.kernel.org

Quoting "Randy.Dunlap" <rdunlap@xenotime.net>:

> On Wed, 30 Nov 2005, Dominic Ijichi wrote:
> 
> > Quoting "Randy.Dunlap" <rdunlap@xenotime.net>:
> >
> > > On Mon, 28 Nov 2005, Dominic Ijichi wrote:
> > >
> > > > Quoting "Randy.Dunlap" <rdunlap@xenotime.net>:
> > > >
> > > > > On Sat, 26 Nov 2005 15:56:22 +0000 Dominic Ijichi wrote:
> > > > >
> > > > > > hello
> 
> [snip]
> 
> > > > > Hi,
> > > > > It seems to work for some people.  I don't know if that's just
> > > > > good luck or that some controllers don't need the SATA ACPI methods
> > > > > that I am working on.  We should know more about that in the next
> > > > > few weeks, I hope.
> > > >
> > > > hiya
> > > > can't work out how to apply your patches, have tried against 2.6.15-rc2
> > > with
> > > > symlinked directories but everything rejects.  sorry for my ignorance,
> > > would
> > > > like to try these out!
> > >
> > > Sorry about that.  I'll correct that and repost with exact
> > > info about correct kernel version to use.
> >
> > hmm, i must have cut and paste them wrongly as i get failed hunks.  is
> there a
> > decent archive of the mailing list?  the MARC one pointed to from
> kernel.org
> > doesnt seem to update or have attachments.
> 
> Cut-n-paste often converts tabs to spaces, so that could be
> the problem.  (BTW, I double-checked after your first email
> and verified that they applied cleanly.)

ah, super, downloading and snipping the raw messages did the trick nicely.  they
apply cleanly to 2.6.15-rc3 with 2.6.15-rc3-libata1.patch.bz2 as well.

thanks!
dom

ps - i can't see any messages after the 25th on MARC, as an aside.

> 
> MARC has the patches -- and none of them were sent as
> attachments.
> 
> 1 of 5: http://marc.theaimsgroup.com/?l=linux-ide&m=113279087717303&w=2
> then click on "Download message RAW"
> 
> 2 of 5: http://marc.theaimsgroup.com/?l=linux-ide&m=113279088931675&w=2
> and Download message RAW
> 
> 3 of 5: http://marc.theaimsgroup.com/?l=linux-ide&m=113279087922204&w=2
> and Download message RAW
> 
> 4/5:  http://marc.theaimsgroup.com/?l=linux-ide&m=113279088127703&w=2
> and Download message RAW
> 
> 5/5:  http://marc.theaimsgroup.com/?l=linux-ide&m=113279088916977&w=2
> and Download message RAW
> 
> 
> > > However, these current patches won't get you much additional help
> > > for SATA suspend/resume since they lack writing the taskfile data
> > > to the controller ports.
> >
> > really look forward to it!
> >
> > thanks for your work
> > dom
> 
> I'll also put them on a web site for download after I have these
> changes made.
> 
> --
> ~Randy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


------------------------------------------
This message was penned by the hand of Dom
