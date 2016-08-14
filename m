From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Regression - SATA disks behind USB ones on v4.8-rc1, breaking
 boot. [Re: Who reordered my disks (probably v4.8-rc1 problem)]
Date: Sun, 14 Aug 2016 18:13:11 +0200
Message-ID: <20160814161311.GA8699@amd>
References: <20160814120327.GA8292@amd>
 <Pine.LNX.4.44L0.1608141055350.22463-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50521 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbcHNQNO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Aug 2016 12:13:14 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1608141055350.22463-100000@netrider.rowland.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <gregkh@linuxfoundation.org>, David Lang <david@lang.hm>, Tom Yan <tom.ty89@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, james harvey <jamespharvey20@gmail.com>, regressions@leemhuis.info, hdegoede@redhat.com, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-usb@vger.kernel.org, Oliver Neukum <oliver@neukum.org>

On Sun 2016-08-14 10:56:54, Alan Stern wrote:
> On Sun, 14 Aug 2016, Pavel Machek wrote:
> 
> > > That being said, it would be great if the original reporter could use
> > > 'git bisect' and let the linux-usb and linux-scsi mailing list know what
> > > the offending patch is, and we can take it from there.
> > 
> > Original reporter is me :-(.
> > 
> > Yes, I can do bisect, if required. I'd like some kind of confirmation
> > that it happens on other systems...
> 
> Can you post a kernel log from one of those unsuccessful boots
> (netconsole or something or the sort)?

Even scrollback does not seem to work well on modern kernels. So
sorry, no easy way to get a kernel log :-(.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
