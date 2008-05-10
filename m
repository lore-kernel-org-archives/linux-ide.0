From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Re: [git patches] libata updates - (improve post-reset
 device ready test) regression
Date: Sat, 10 May 2008 15:34:11 +0900
Message-ID: <482541E3.6020001@gmail.com>
References: <20080506154847.GA15299@havoc.gtf.org> <20080507145616.GA2210@gentoox2.trippelsdorf.de> <48231DAF.7070900@garzik.org> <4823BD8E.40109@gmail.com> <4823D4EC.7060407@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:26065 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbYEJGeV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 May 2008 02:34:21 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1890548rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 09 May 2008 23:34:20 -0700 (PDT)
In-Reply-To: <4823D4EC.7060407@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, marc.c.dionne@gmail.com, dl9pf@gmx.de, bug-track@fisher-privat.net, sitsofe@yahoo.com

Jeff Garzik wrote:
> Tejun Heo wrote:
>> This means that we need to make custom readiness tests for controllers 
>> using 0x77 or 0x7f.  Eeeek... Both groups of controllers are behaving 
>> in incorrect way.  Controllers shouldn't use 0x77 or 0x7f for either 
>> busy or ready states - it's invalid for both, yet, some use the 77/7f 
>> for busy while others use them for ready state.  Great.  :-(
> 
> I think that's assuming too much?  PATA and SATA are quite different 
> here... in PATA the status is mostly the value from the device directly 
> off the wires.  in SATA, it may be from the device or from the 
> controller.  And "smart" or firmware-based controllers may generate 
> their own status, too, apart from the device's status.
 >
> So that results in varied status returns, and not all the time is a 
> definite "ready" or "not ready" obvious.

I think it's pretty safe to say that these weird ready values are from 
TF emulation on controller side.  The ready/not ready distinction is 
probably too simplistic but those values aren't supposed to appear 
during post-reset readiness test.

Sorry about the big regression.  Heh... It's amazing how all the 
controllers I tested didn't show the problem and I did test a good 
number of combinations.

I still think it would be better to have a unified readiness test 
function.  The problem is subtle (device misdetection on hotplug of 
certain drives) and went unnoticed quite some time for JMB ahcis && test 
coverage over those things can't be good.  I'll try to think about 
something better.

Thanks.

-- 
tejun
