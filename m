From: Tejun Heo <tj@kernel.org>
Subject: Re: Candidate for late revert ?
Date: Mon, 2 Jun 2014 20:45:20 -0400
Message-ID: <20140603004520.GB19855@htj.dyndns.org>
References: <20140603000728.28fca8fe@www.etchedpixels.co.uk>
 <CA+55aFykTbMRKku1bDd_wHCjyD+Yf2v-B8-c+NKMZ0AnNkpVrw@mail.gmail.com>
 <yq138fm98in.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:46336 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932221AbaFCApY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jun 2014 20:45:24 -0400
Received: by mail-qa0-f46.google.com with SMTP id w8so3777202qac.19
        for <linux-ide@vger.kernel.org>; Mon, 02 Jun 2014 17:45:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <yq138fm98in.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Hello, Martin.

(cc'ing linux-ide)

On Mon, Jun 02, 2014 at 07:49:52PM -0400, Martin K. Petersen wrote:
> I'm starting to think we'll have to make queued trim an opt-in for
> now. Every vendor appears to screw it up. I had a third patch in my
> series that would allow the users to override the type of trim in
> sysfs. It was mainly written as an aid to the SSD vendors so they could
> test queued trim on drives we had blacklisted. I didn't post it because
> I was afraid people would shoot themselves in the foot. But maybe opt-in
> for enthusiasts is a better approach in the short term...

The problem with that approach is that it's very likely that we won't
be able to take advantage of that feature ever.  IIRC, we did a
similar thing with FUA support.  We added the support, a bunch of
controllers and devices were broken, we hid it behind a module option
with the goal being eventually developing a whitelist.  Of course,
there's no way to actually find out which combinations work once the
feature is disabled by default and libata FUA support is essentially
dead, which BTW might be the right conclusion.  It's not like FUA
makes noticeable difference and quite likely that vendors haven't
gotten around to fix the issues anyway and won't ever.

The one difference is that, unlike FUA, queued trim is actually
useful, so I kinda wanna give it more fighting chances before we
declare defeat and bury it behind a module option.  That said, I
wouldn't have any problem with applying blacklist liberally for
devices which show any sign of issues.  If there isn't no definite
confirmation from the vendor regarding what the issue was and which
firmware fixes it, I think blacklisting the whole family of devices
isn't a bad idea.  If this feature is gonna survive, given its actual
usefulness, I think / hope it would, the trade-off of blacklisting
existing devices widely makes pretty good sense if that'd allow us to
salvage the feature in the long term.

So, let's keep blacklisting liberally for now.

Thanks.

-- 
tejun
