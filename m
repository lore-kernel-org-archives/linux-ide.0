From: Bob Stewart <bob@evoria.net>
Subject: Re: Old Thread: sata_inic162x driver for 2.6.19 timeouts etc
Date: Sun, 24 Aug 2008 16:50:02 -0700 (PDT)
Message-ID: <747739.95266.qm@web901.biz.mail.mud.yahoo.com>
References: <4604D564.9010806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web901.biz.mail.mud.yahoo.com ([216.252.100.41]:48281 "HELO
	web901.biz.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752948AbYHXX4o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Aug 2008 19:56:44 -0400
In-Reply-To: <4604D564.9010806@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun, 
This is an update to an old thread.

--- Tejun Heo <htejun@gmail.com> wrote:
> Bob Stewart wrote:
> > I wonder if this card of mine is what's bad.  <snipp.
> 
> My bet is on broken driver.  sunix driver doesn't seem like it was 
> written carefully.  Anyways, thanks for testing.  It seems we'll either 
> have to implement adma mode.  I'll mark the driver broken for 2.6.21. 
> Thanks.

I just got your note that there is a new SATA_INIC162X driver, so I
loaded up kernel 2.6.27-rc2 and gave it a try.  Timeouts again, so I
ordered a new card on ebay.  I'm sad to say that the errors, months
ago, were from a card that I had gotten bad from new.  Wasted a lot of my
time and this list's time.  Sorry about that.  :(

OTOH, with the new card, both your new driver and the old one seem
to be OK after several hours of copying ISO files and running "md5sum"
on the copied filed.  Good job!  Thanks for all the hard work!  If there are
any other tests needed on this driver let me know before I bow out again.

Bob
