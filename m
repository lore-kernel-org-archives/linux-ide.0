From: Tejun Heo <htejun@gmail.com>
Subject: Re: ATA device reset, shoud I be concerned?
Date: Tue, 22 Jan 2008 11:08:24 +0900
Message-ID: <47955018.7000901@gmail.com>
References: <200801140019.20668.g.chulkov@jacobs-university.de> <20080121164744.2f7d0ed1@lxorguk.ukuu.org.uk> <4794D020.4060204@gmail.com> <200801220231.22609.bzolnier@gmail.com> <4795488E.30706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:7898 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754385AbYAVCIe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 21:08:34 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4077535wah.23
        for <linux-ide@vger.kernel.org>; Mon, 21 Jan 2008 18:08:31 -0800 (PST)
In-Reply-To: <4795488E.30706@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Georgi Chulkov <g.chulkov@jacobs-university.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

Tejun Heo wrote:
> Bartlomiej Zolnierkiewicz wrote:
>> On Monday 21 January 2008, Tejun Heo wrote:
>>
>> [...]
>>
>>>> Old IDE says it works for PATA. For SATA I can see it might need more
>>>> care and you might simply not be able to get the info.
>>> Old IDE often locks up the machine hard after timeouts.  I'm all for
>> Could you point me to some bugreports?
>>
>> I would like to know more about hosts/conditions for which it happens.
> 
> It's jmicron and all on-board jmicrons I have show the same problem.
> Connect harddrrive to the controller and drive it via jmicron, hot plug
> unplug SATA drives continuously, after a while, jmicron says it lost
> interrupt and the machine locks up hard.

BTW, those hot plug/unplugs don't have any direct relationship with the
JMB controller.  It's some interference or power issue, I guess.  Hot
plugging unrelated drives somehow locks up the jmicron driver.  :-(

-- 
tejun
