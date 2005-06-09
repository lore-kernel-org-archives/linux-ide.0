From: Greg Stark <gsstark@mit.edu>
Subject: Re: SMART support for libata
Date: 09 Jun 2005 14:13:57 -0400
Message-ID: <87u0k74cuy.fsf@stark.xeocode.com>
References: <87y8g8r4y6.fsf@stark.xeocode.com> <41B7EFA3.8000007@pobox.com>
	<87br6g6ayr.fsf@stark.xeocode.com> <42A73E6E.80808@rtr.ca>
	<873brs5ir8.fsf@stark.xeocode.com> <42A85F5E.10208@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262435AbVFISOM@vger.kernel.org>
In-Reply-To: <42A85F5E.10208@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Greg Stark <gsstark@mit.edu>, linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org


Mark Lord <liml@rtr.ca> writes:

> Greg Stark wrote:
> ..
> >>You should be using "-y" (standby) instead of "-Y" (sleep).
> > I'll try that. But that's not going to make it spin up when it gets a SMART
> > query is it?
> 
> Depends on what SMART items are being queried.
> 
> Actually, what you should *really* be using is "hdparm -S"
> with a suitable timeout value (say, 30 or larger).

Not really since the drive will just spin up ever few seconds as bdflush (or
whatever it's called these days) dribbles out pages.

What I should *really* be using is the noflushd daemon. That's been on hold
since I found it didn't work with SATA drives. But I wonder if it would work
these days.

-- 
greg
