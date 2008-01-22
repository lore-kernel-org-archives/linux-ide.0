From: Tejun Heo <htejun@gmail.com>
Subject: Re: ATA device reset, shoud I be concerned?
Date: Tue, 22 Jan 2008 10:36:14 +0900
Message-ID: <4795488E.30706@gmail.com>
References: <200801140019.20668.g.chulkov@jacobs-university.de> <20080121164744.2f7d0ed1@lxorguk.ukuu.org.uk> <4794D020.4060204@gmail.com> <200801220231.22609.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:15826 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbYAVBgW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 20:36:22 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1958975rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 21 Jan 2008 17:36:20 -0800 (PST)
In-Reply-To: <200801220231.22609.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Georgi Chulkov <g.chulkov@jacobs-university.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

Bartlomiej Zolnierkiewicz wrote:
> On Monday 21 January 2008, Tejun Heo wrote:
> 
> [...]
> 
>>> Old IDE says it works for PATA. For SATA I can see it might need more
>>> care and you might simply not be able to get the info.
>> Old IDE often locks up the machine hard after timeouts.  I'm all for
> 
> Could you point me to some bugreports?
> 
> I would like to know more about hosts/conditions for which it happens.

It's jmicron and all on-board jmicrons I have show the same problem.
Connect harddrrive to the controller and drive it via jmicron, hot plug
unplug SATA drives continuously, after a while, jmicron says it lost
interrupt and the machine locks up hard.

Thanks.

-- 
tejun
