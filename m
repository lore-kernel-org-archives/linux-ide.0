From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: IDE issues with "choose_drive"
Date: Sun, 09 Oct 2005 08:18:33 +1000
Message-ID: <1128809913.17365.78.camel@gaston>
References: <1128559019.22073.19.camel@gaston>
	 <1128560569.22073.25.camel@gaston> <1128734104.17365.73.camel@gaston>
	 <58cb370e0510080129i80710c7gc2178b9330a1ee19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751171AbVJHWU6@vger.kernel.org>
In-Reply-To: <58cb370e0510080129i80710c7gc2178b9330a1ee19@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel list <linux-kernel@vger.kernel.org>, list linux-ide <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org


> It seems we need internal ide_dev_do_request(ide_drive_t *, int)
> which will explicitly state which device we want to service as I see
> no sane way to fix the problem in choose_drive().

Not only that, but if you read my blurb, I wonder how even the
non-targetted case can work properly if we ever hit a couple of the code
path in there that either early exit because the elevator returned no
request or the case where we "sleep" a drive to give more time to the
other... I have the feeling that we may "miss" an opportunity to servive
a drive, and thus this drive will stick around with a pending request
not beeing serviced... I reckon those are corner cases, but I feel the
whole thing need some serious revisiting.

> Your workaround is OK for 2.6.14 given that you will document it
> now and later fix it properly for 2.6.15.

Ok. Well, I'm not sure what is the right fix at the moment given the
other issues I described above, but I'm definitely up to doign a proper
fix for 2.6.15 with your help ;)

Ben.
