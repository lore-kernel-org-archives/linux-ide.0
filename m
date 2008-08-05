From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 3/5] libata: Implement disk shock protection support
Date: Tue, 5 Aug 2008 21:59:12 +0200
Message-ID: <20080805195912.GE7939@elf.ucw.cz>
References: <fa.nx0yFPJm+aNXPHgykUrOzZXvvIs@ifi.uio.no> <fa.NfEr7Ik6e8oextyWICW/jR5emeE@ifi.uio.no> <fa.zGvATZImeUo0tHJe4hzlk5+mTiM@ifi.uio.no> <fa.SRVleMItV5QEF7/tgCjSHz0ScJA@ifi.uio.no> <fa.YKbhgq8XUxH/Qg1ArE+73YsDlpE@ifi.uio.no> <4897D16F.3000504@shaw.ca> <20080805131417.GC8569@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57914 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758402AbYHET5v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Aug 2008 15:57:51 -0400
Content-Disposition: inline
In-Reply-To: <20080805131417.GC8569@mit.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>, Robert Hancock <hancockr@shaw.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Gabor Gombas <gombasg@sztaki.hu>, Tejun Heo <htejun@gmail.com>Elias Oltmanns <e>

Hi!

> > Yes, from what I've seen on these laptops, it doesn't take much to  
> > trigger the shock protection in Windows - lifting the front of the  
> > laptop off the table an inch and dropping it will do it, 
> 
> A few years ago, I had a Thinkpad T21 laptop, accidentally slip
> through my butterfingers and dropped about an inch before it landed on
> the table.  Unfortunately, (a) the Thinkpad T21 laptop was rather
> heavy (compared to modern laptops), (b) it didn't have the rubber
> "bubble" on the bottom of the laptop to cushion the landing as the T22
> and T23's had (and I'm sure I know why it was added), and (c) the hard
> drive was active at the time.  It was enough to cause a head crash and
> Linux immediately started reporting an exponentially increasing number
> of write errors; the hard drive was totally unusable within an hour or
> so.
> 
> So there's a reason why the anti-shock protection is set at a rather
> sensitive level...    
> 
> The real right answer though is to buy one of the laptop drives (such
> as the Seagate Momentus 7200.2 or 7200.3) which has the anti-shock
> detection built directly into the hard drive.  That way you don't have
> to have a daemon that sits in the OS waking up the CPU some 20 to 30
> times a second and burning up your battery even when the laptop is
> idle.

Hmm, when the laptop is idle, "right thing" is to spin the disk down,
and at that point you no longer need to poll the accelerometer...

Yes, doing it in drive is probably right place... but I'm told the
algorithms are quite complex.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
