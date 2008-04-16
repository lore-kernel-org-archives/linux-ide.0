From: "Christian Pernegger" <pernegger@gmail.com>
Subject: Re: Western Digital GreenPower drives and Linux
Date: Wed, 16 Apr 2008 19:59:24 +0200
Message-ID: <bb145bd20804161059u4fe45debs22adf337fef143aa@mail.gmail.com>
References: <200804092118.35501.tvrtko@ursulin.net>
	 <4805E59E.1020607@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.239]:48474 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756894AbYDPR7a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2008 13:59:30 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1923563wxd.4
        for <linux-ide@vger.kernel.org>; Wed, 16 Apr 2008 10:59:25 -0700 (PDT)
In-Reply-To: <4805E59E.1020607@aitel.hist.no>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: "Tvrtko A. Ursulin" <tvrtko@ursulin.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> > At this rate the disk would reach it's design limit for load/unload cycles
> in around 80 days.

Design *minimum* for load/unload cycles is reportedly 600K cycles,
that would give me over 7.5 years of 24/7 operation, which I can live
with in cheap high capacity drives that have only 5 years of warranty
anyway.

Support wouldn't say if the behavior is considered normal, though ...

Will set the timeout to 25sec using the DOS kludge and see what
happens ... doubt it will help much, though. I'd much rather like to
know what causes the drives to load heads again so soon after the
unload. With the usage pattern of these drives they should stay
unloaded most of the time here.

Being able to set the timeout online via hdparm would be nice, too :)

C.
