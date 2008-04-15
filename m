From: "Justin Mattock" <justinmattock@gmail.com>
Subject: Re: sda
Date: Tue, 15 Apr 2008 05:27:25 +0000
Message-ID: <dd18b0c30804142227j7ff1723bp6afabfffa6882f1d@mail.gmail.com>
References: <dd18b0c30804021244k1d44a48hc05ea88552104a71@mail.gmail.com>
	 <48016F54.5070405@gmail.com>
	 <dd18b0c30804122117hc0cd548v6cbef5d2c0c0ce5e@mail.gmail.com>
	 <48041E2A.9000602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.250]:50459 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753541AbYDOF10 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Apr 2008 01:27:26 -0400
Received: by an-out-0708.google.com with SMTP id d31so499688and.103
        for <linux-ide@vger.kernel.org>; Mon, 14 Apr 2008 22:27:25 -0700 (PDT)
In-Reply-To: <48041E2A.9000602@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

On Tue, Apr 15, 2008 at 3:16 AM, Tejun Heo <htejun@gmail.com> wrote:
> Hello,
>
>  Justin Mattock wrote:
>
> >
> > >  Can you please post the result of "lspci -nn".  The error per-se is
> okay.
> > > The drive failed to respond to IDENTIFY at the first try but on retrial
> it
> > > responded okay.
> > >
> >
> > Hello; Thank you for the response.
> > I guess you can say I have a tendancy to freak out or panic with
> > little things like that,
> > below is lspci -nn.
> >
>
>  Hmm... ICH7.  I recently had a different bug report on < ICH7 (don't
> remember whether it was 4, 5 or 6).  In that case, the drive went completely
> offline after resume.  It never came back after retries.  It seemed like the
> device needed hardreset after waking up from sleep which we currently only
> support for >= ICH8).
>
>  Mark, you played with the hardreset bits in PCS (right?) register.  What do
> you think about adding it?  Last time I played with it, the presence
> detection seemed unreliable so hotplug might not work too well but as long
> as the hardreset itself works we can augment it with follow up srst for
> cases like this.
>
>
> > Besides the SATA drive, with the PATA ATAPI drive, I'm running a
> > little test of playing a DVD, then performing a suspend, upon wakeup
> > The movie becomes choppy;
> > "Basically what I can see over here is"; when the system is wokenup
> > whatever is left in the ram or memory continues to play, In the meantime
> > the PATA drive from what I can hear, moves around a little bit thinks
> > for a second, then starts turning fast, but by then whatever was in
> > the ram or memory has played, causing the playback to be out of sync,
> > resulting in a choppy feed.
> > Idealistically I would like to take the media player, and have it wait
> > for the DVD to catch up then start playback, Or see If when suspend
> > occurs (if possible)the lens in the PATA keeps the position, then upon
> > resume PATA resumes, Or If this is already available try and enable
> > that feature.
> >
>
>  What happens if you stop the playing and restart it?  Does it play okay?
>
>  --
>  tejun
>

Yes the media plays just fine.
Overrall this isn't a huge issue for me, It was something I noticed
when switching to osx and linux,
Causing enough attention for me to ask the question on how I can have
the the dvd react properly upon resume.
but not enough to loose sleep over.

-- 
Justin P. Mattock
