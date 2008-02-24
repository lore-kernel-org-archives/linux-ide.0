From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] AMD SB700/SB800 SATA support 64bit DMA
Date: Sun, 24 Feb 2008 00:30:00 -0500
Message-ID: <47C100D8.5050109@garzik.org>
References: <e2a1ca3c0802220500n565144f6k4fd25b55e4489326@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36113 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759199AbYBXFaD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 24 Feb 2008 00:30:03 -0500
In-Reply-To: <e2a1ca3c0802220500n565144f6k4fd25b55e4489326@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shane Huang <ati.shane@gmail.com>
Cc: htejun@gmail.com, linux-ide@vger.kernel.org, henry.su@amd.com, shane.huang@amd.com

Shane Huang wrote:
> Jeff and Tejun:
> 
> 
> I'm using my private mailbox to submit it before I set up
> the connection to our exchange mail server under linux.
> Please check whether this patch can be accepted.
> 
> 
> Thanks
> Shane
> 
> 
> CUT HERE
> ========
> SB700 SATA controller can support 64 bit DMA, the previous commit
> badc2341579511a247f5993865aa68379e283c5c was added with
> careless reference to SB600, which should be modified by this patch.
> 
> Signed-off-by: Shane Huang <shane.huang@amd.com>

applied


