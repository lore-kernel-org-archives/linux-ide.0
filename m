From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 stability and performance
Date: Thu, 06 Mar 2008 16:08:48 +0900
Message-ID: <47CF9880.4080900@gmail.com>
References: <47BAF677.5000602@rtr.ca> <20080302061453.GA7291@denix.org> <005d01c87c4c$0d01f550$4d0fa8c0@M2007> <47CC9197.9050609@gmail.com> <20080304002215.GA13317@denix.org> <47CCC1C6.5010600@gmail.com> <20080304062942.GA14335@denix.org> <47CE55B3.6070701@gmail.com> <20080306041454.GA7242@denix.org> <47CF7222.7060702@gmail.com> <20080306065513.GE7150@denix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.188]:18169 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758057AbYCFHI5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Mar 2008 02:08:57 -0500
Received: by rn-out-0910.google.com with SMTP id v46so783877rnb.15
        for <linux-ide@vger.kernel.org>; Wed, 05 Mar 2008 23:08:56 -0800 (PST)
In-Reply-To: <20080306065513.GE7150@denix.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Denys Dmytriyenko <denis@denix.org>
Cc: Gabor FUNK <FUNK.Gabor@hunetkft.hu>, linux-ide@vger.kernel.org, Jim Paris <jim@jtan.com>, Mark Lord <liml@rtr.ca>

Denys Dmytriyenko wrote:
>>> Also, few months ago instead of sata_sil24 I had my drives connected to
>>> sata_mv (Supermicro 8-port) and performance was normal...
>> Everything seems okay.  I wonder where the difference is.  Does "dd
>> if=/dev/zero of=file oflags=direct bs=1M" make any difference?  And can
>> you vacate a raw partition and try it on there?
> 
> oflag=direct has no effect - same speed. Tried it on a raw /dev/sda device
> and still no difference. It maybe slighly better, giving me 18 MB/s.
> 
> Can it be something with the way SiI 3124 controller is configured in the
> system?

Hmmm... That's strange you did specify the "bs" parameter, right?  It
should essentially give the same performance as "hdparm -t".  I wonder
where the difference comes from.

-- 
tejun
