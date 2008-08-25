From: Tejun Heo <htejun@gmail.com>
Subject: Re: Old Thread: sata_inic162x driver for 2.6.19 timeouts etc
Date: Mon, 25 Aug 2008 10:39:17 +0200
Message-ID: <48B26FB5.4070109@gmail.com>
References: <747739.95266.qm@web901.biz.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:36128 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbYHYIka (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Aug 2008 04:40:30 -0400
Received: by ti-out-0910.google.com with SMTP id b6so908512tic.23
        for <linux-ide@vger.kernel.org>; Mon, 25 Aug 2008 01:40:29 -0700 (PDT)
In-Reply-To: <747739.95266.qm@web901.biz.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bob Stewart <bob@evoria.net>
Cc: linux-ide@vger.kernel.org

Bob Stewart wrote:
> Tejun, 
> This is an update to an old thread.
> 
> --- Tejun Heo <htejun@gmail.com> wrote:
>> Bob Stewart wrote:
>>> I wonder if this card of mine is what's bad.  <snipp.
>> My bet is on broken driver.  sunix driver doesn't seem like it was 
>> written carefully.  Anyways, thanks for testing.  It seems we'll either 
>> have to implement adma mode.  I'll mark the driver broken for 2.6.21. 
>> Thanks.
> 
> I just got your note that there is a new SATA_INIC162X driver, so I
> loaded up kernel 2.6.27-rc2 and gave it a try.  Timeouts again, so I
> ordered a new card on ebay.  I'm sad to say that the errors, months
> ago, were from a card that I had gotten bad from new.  Wasted a lot of my
> time and this list's time.  Sorry about that.  :(
> 
> OTOH, with the new card, both your new driver and the old one seem
> to be OK after several hours of copying ISO files and running "md5sum"
> on the copied filed.  Good job!  Thanks for all the hard work!  If there are
> any other tests needed on this driver let me know before I bow out again.

Ah.. great, so at least something works.  :-)

Any chance you can put the old one under windows and see whether it
works there?

-- 
tejun
