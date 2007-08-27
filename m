From: Richard Scobie <richard@sauce.co.nz>
Subject: Re: Resets on sil3124 & sil3726 PMP
Date: Mon, 27 Aug 2007 20:08:08 +1200
Message-ID: <46D28668.3020501@sauce.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.sauce.co.nz ([210.48.49.72]:38603 "EHLO smtp.sauce.co.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795AbXH0IIx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Aug 2007 04:08:53 -0400
Received: from [192.168.4.201] (unknown [192.168.4.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp22.sauce.co.nz (Postfix) with ESMTP id 3ED1D288263
	for <linux-ide@vger.kernel.org>; Mon, 27 Aug 2007 20:08:51 +1200 (NZST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi Petr,

 > Though I do not run any RAID on them (I would say that with PMP's
 > bottleneck it would be bad idea), so maybe I'm not stressing them
 > sufficiently to trip over bugs.

Thanks for your reply.

Sorry, I should have asked "Does anyone have any performance figures to 
share, using md RAID with these PMP interfaces?"

I'm not sure what you are refering to when you say "PMP's bottleneck", 
but I have seen benchmarks for a 3124 host adapter in a Mac G5, attached 
to a 3726 based PMP, which had 5 7200 Maxtors connected to it.

It was RAID0 striped and achieved 226MB/s write and 253MB/s read.

I was just interested to see if anyone had tested a similar md RAID 5 
using these chips on Linux.

Regards,

Richard
