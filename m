From: Tejun Heo <htejun@gmail.com>
Subject: Re: Support for dual-drive pmp?  0x197b:0x2352
Date: Thu, 19 May 2011 11:39:48 +0200
Message-ID: <20110519093948.GB627@htj.dyndns.org>
References: <4DD418EE.8020405@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48527 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932864Ab1ESJk1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 May 2011 05:40:27 -0400
Received: by bwz15 with SMTP id 15so2193511bwz.19
        for <linux-ide@vger.kernel.org>; Thu, 19 May 2011 02:40:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DD418EE.8020405@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Hello, Mark.

On Wed, May 18, 2011 at 03:07:26PM -0400, Mark Lord wrote:
> But it also fails equally well without the patch.  :)

Awesome! :)

> The eSATA host controller is the ever-popular JMicron:
> 
> 04:00.0 SATA controller: JMicron Technology Corp. JMB362/JMB363 Serial ATA
> Controller (rev 02)
> (197b:2363)
> 
> Just about everything around here has one of those JMicron chips
> for the eSATA ports, so I'm guessing that this problem may be
> somewhat more widespread than just my home office.

Can you send me a link of the PMP device?

> So what next?
> I suspect something isn't quite right in the JMicron AHCI driver code.

I have no idea.  I'll get one and see what's up with it.

Thanks.

-- 
tejun
