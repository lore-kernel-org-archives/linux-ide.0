From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Date: Sat, 27 Mar 2004 17:02:57 -0800
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040327170257.24c82915.akpm@osdl.org>
References: <4066021A.20308@pobox.com>
	<40661049.1050004@yahoo.com.au>
	<406611CA.3050804@pobox.com>
	<406616EE.80301@pobox.com>
	<4066191E.4040702@yahoo.com.au>
	<40662108.40705@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:26338 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262042AbUC1BDB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Mar 2004 20:03:01 -0500
In-Reply-To: <40662108.40705@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: nickpiggin@yahoo.com.au, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
>  TCQ-on-write for ATA disks is yummy because you don't really know what 
>  the heck the ATA disk is writing at the present time.  By the time the 
>  Linux disk scheduler gets around to deciding it has a nicely merged and 
>  scheduled set of requests, it may be totally wrong for the disk's IO 
>  scheduler.  TCQ gives the disk a lot more power when the disk integrates 
>  writes into its internal IO scheduling.

Slightly beneficial for throughput, disastrous for latency.

It appears the only way we'll ever get this gross misdesign fixed is to add
a latency test to winbench.

