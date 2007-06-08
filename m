From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Re: Linux v2.6.22-rc3
Date: Fri, 08 Jun 2007 20:32:03 +0900
Message-ID: <46693E33.6080705@gmail.com>
References: <alpine.LFD.0.98.0705252008210.26602@woody.linux-foundation.org>	<9d2cd630705270801m2826be60p3f802c502b26c531@mail.gmail.com>	<466196AD.3090502@garzik.org>	<9d2cd630706031046n2bd77585o7c0df1c5fea5167f@mail.gmail.com>	<46667466.4010500@gmail.com>	<9d2cd630706062322v2d73b32dp1da56f97e2069fff@mail.gmail.com>	<4667B347.9040900@gmail.com>	<alpine.LFD.0.98.0706071352440.4205@woody.linux-foundation.org>	<20070607224746.GA23290@havoc.gtf.org>	<46690D10.9040808@gmail.com> <20070608122750.7f8ae0e0@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:10502 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968558AbXFHLce (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jun 2007 07:32:34 -0400
Received: by wr-out-0506.google.com with SMTP id i21so687298wra
        for <linux-ide@vger.kernel.org>; Fri, 08 Jun 2007 04:32:34 -0700 (PDT)
In-Reply-To: <20070608122750.7f8ae0e0@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@linux-foundation.org>, Gregor Jasny <gjasny@googlemail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Alan Cox wrote:
>> Upto 2.6.21, if the same condition triggers, it delays 30secs and just
>> continue, so I don't think it was a worthy protection against ghost
>> devices or TF malfunction.  The only protection it offers is preventing
>> libata from accessing slave's status register too early.  SRST sequence
>> looks like the following.
> 
> I've seen no bug where it looked like it saved something, and the only
> ghost device bugs I've seen it failed to detect anyway (hence the PCMCIA
> drivers own ghost detection logic)

If we still have several rc's left, how about just removing it and
watching the fireworks?  Jeff?

-- 
tejun
