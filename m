From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCHSET #upstream-fixes] libata: update HPA handling
Date: Thu, 16 Aug 2007 04:11:25 -0400
Message-ID: <46C406AD.5000904@garzik.org>
References: <20070815180508.GD21623@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37344 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757824AbXHPIL1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Aug 2007 04:11:27 -0400
In-Reply-To: <20070815180508.GD21623@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> Hello,
> 
> The current HPA handling implementation isn't robust enough and causes
> regressions on several cases.  This patchset contains HPA handling
> update.
> 
> * blacklist devices which puke on READ_NATIVE_MAX
> * proper/better error handling - in most cases, HPA failure won't
>   result in detection failure
> * re-read IDENTIFY data after resizing
> * more concise messages
> 
> Tested by setting up HPA area manually.

This is a bit big for 2.6.23-rc though :/


