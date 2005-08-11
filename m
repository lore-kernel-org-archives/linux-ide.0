From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/3] libata-dev: pdc2027x mdelay() problem fix for power5
 micro-partitioning
Date: Wed, 10 Aug 2005 23:04:47 -0400
Message-ID: <42FAC04F.4060405@pobox.com>
References: <42F24DBE.0@tw.ibm.com> <42F251C2.8090409@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:58786 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932235AbVHKDEv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Aug 2005 23:04:51 -0400
In-Reply-To: <42F251C2.8090409@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Albert Lee wrote:
> Jeff,
> 
> Patch 2/3: pdc2027x mdelay() problem fix for micro-partitioning
> 
> Description:
>   The mdelay(100) does not delay exactly 100 ms on IBM power5 machines 
> when the power5 CPU micro-partitioning feature is turned on.
> Ex. If micro-partitioning is set to use 0.1 of the CPU time, mdelay(100) 
> will delay about 1 sec instead of 100ms.
> 
> Changes:
>  - Use do_gettimeofday() to measure the actual elapsed time.
>  According to the documentation, do_gettimeofday() works on most platforms
> except some old M68K machines. There are no PCI slots on M68K machines,
> so using do_gettimeofday() seems to be safe here.

NAK.

mdelay() should be investigated as to why its not working on your 
platform.  do_gettimeofday() is -less- granular and accurate than 
mdelay(), usually.

	Jeff

