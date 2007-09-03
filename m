From: Richard Scobie <richard@sauce.co.nz>
Subject: Re: Resets on sil3124 & sil3726 PMP
Date: Tue, 04 Sep 2007 09:21:59 +1200
Message-ID: <46DC7AF7.1010304@sauce.co.nz>
References: <46DC62E4.8050901@sauce.co.nz> <20070903203441.GF23498@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.sauce.co.nz ([210.48.49.72]:55140 "EHLO smtp.sauce.co.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754838AbXICVR4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Sep 2007 17:17:56 -0400
Received: from [192.168.4.111] (unknown [192.168.4.111])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp22.sauce.co.nz (Postfix) with ESMTP id 1A70F288263
	for <linux-ide@vger.kernel.org>; Tue,  4 Sep 2007 09:17:53 +1200 (NZST)
In-Reply-To: <20070903203441.GF23498@curie-int.orbis-terrarum.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Robin H. Johnson wrote:

> The single PMP numbers they have (under "Addonics ADSA3GPX8-4EM Striped RAID Set
> Performance Comparison") has Write=211MB/sec Read=231MB/sec.

True. I wonder if the bus spec of 3Gb/s is somewhat optimistic in the 
real world - a bit like saying one can get 132MB/s from a 32bit 33MHz 
PCI bus.

The absolute ideal throughput for 1.5 Gb/s would be 187MB/s, so the 
throughput figures above mean the link must be at 3Gb/s, it's just not 
inpressive, given that the 5 drives can do at least 300MB/s and the 
theoretical maximum for 3Gb/s is 375MB/s.

In another test at the same site, a Marvell 88SX7042 based card gets 
slightly better throughput - 196.8 write 251 read:

http://www.amug.org/amug-web/html/amug/reviews/articles/sonnet/e4p/

Looking at the graphs towards the end of the article "Seagate 160GB 
7200.9 Port Multiplier Write/Read Performance", it looks as though 
better performance may be had by distributing disks across multipole PM 
ports, rather than all on one - see 5 drives on one PM v 4 drives, each 
on it's own PM.

There are quite a number of tests of many PM cards and enclosures here:

http://www.amug.org/amug-web/html/amug/reviews/reviews.html

Regards,

Richard
