From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: Resets on sil3124 & sil3726 PMP
Date: Mon, 03 Sep 2007 02:57:24 -0700
Message-ID: <46DBDA84.3050505@vc.cvut.cz>
References: <46D2595B.1030409@sauce.co.nz> <46D2792B.401@vc.cvut.cz> <46DBCCE9.9080806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailgw.cvut.cz ([147.32.3.235]:43231 "EHLO mailgw.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752641AbXICJ5a (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Sep 2007 05:57:30 -0400
In-Reply-To: <46DBCCE9.9080806@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Richard Scobie <richard@sauce.co.nz>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Petr Vandrovec wrote:
>> For comparsion 1TB Hitachi behind 3726 PMP (again MS4UM) with sata_sil
>> patch I sent last week (no NCQ, 1.5Gbps link between 3512 and PMP, and
>> 3.0Gbps link between PMP and drive... why is it faster?):
> 
> If you turn off NCQ by echoing 1 to /sys/block/sdd/device/queue_depth on
> sata_sil24, does the performance change?

I have recompiled kernel with all debugging disabled, and it brought me 
1.5MBps, so it is still consistently 1MBps slower than on sil. 
Disabling NCQ seems to improve concurrent access a bit (for which I have 
no explanation), while slows down single drive scenario:

With NCQ:

1TB alone: 81.22, 79.86
1TB+1TB:   56.28+56.70, 53.51+56.11

Without NCQ:

1TB alone: 79.78, 80.82
1TB+1TB:   57.99+58.12, 56.50+56.46

3512 sil, no NCQ:

1TB alone: 82.28, 82.18
1TB+1TB:   47.20+47.54    # Here apparently command based switching or 
1.5Gbps link between device and PMP becomes bottleneck

And it seems that I observe what other poster pointed out - that 
apparently all SiI chips are limited somewhere around 120-130MBps, and 
cannot do more even if you pretty ask...
							Petr

