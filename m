From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] speed up SATA
Date: Sun, 28 Mar 2004 12:31:05 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40670BD9.9020707@pobox.com>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406612AA.1090406@yahoo.com.au> <4066156F.1000805@pobox.com> <20040328141014.GE24370@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35796 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262153AbUC1RbS
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Mar 2004 12:31:18 -0500
In-Reply-To: <20040328141014.GE24370@suse.de>
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Jens Axboe wrote:
> On Sat, Mar 27 2004, Jeff Garzik wrote:
> 
>>I also wouldn't want to lock out any users who wanted to use SATA at 
>>full speed ;-)
> 
> 
> And full speed requires 32MB requests?


Full speed is the SATA driver supporting the hardware maximum.  The 
block layer and general fragmentation limit things further from there.

	Jeff



