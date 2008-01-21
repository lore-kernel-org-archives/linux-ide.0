From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ATA device reset, shoud I be concerned?
Date: Mon, 21 Jan 2008 14:14:25 +0000
Message-ID: <20080121141425.45aa9c61@lxorguk.ukuu.org.uk>
References: <200801140019.20668.g.chulkov@jacobs-university.de>
	<20080115025435.1e21b703.akpm@linux-foundation.org>
	<20080115113552.75731bf8@lxorguk.ukuu.org.uk>
	<4794501E.90306@gmail.com>
	<20080121130256.2443d7c1@lxorguk.ukuu.org.uk>
	<47949AA4.9090601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46409 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753039AbYAUOQq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 09:16:46 -0500
In-Reply-To: <47949AA4.9090601@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Georgi Chulkov <g.chulkov@jacobs-university.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

> while IDE thinks that IRQ might be lost and complete the command if the
> TF status register says so.

For PATA at least that makes a lot of sense. It would probably make the
Promise driver a lot more stable too.

> It could be that the particular device doesn't raise IRQ on certain
> error conditions but updates TF registers.  After timeout, IDE completes
> the command with the indicated error while libata ignores the status and
> resets the device.

And loses the important information like media errors
 
> libata never touches TF register after timeout because some controllers
> lock up hard if TF register is read after certain error conditions
> (event the status register).

Should that not then be a per host flag ?

Alan
