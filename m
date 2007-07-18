From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Fix SMART reporting on 2.6.22
Date: Wed, 18 Jul 2007 12:08:32 +0900
Message-ID: <469D8430.10509@gmail.com>
References: <20070713065600.GB8320@vana.vc.cvut.cz> <46972519.80703@gmail.com> <46980AFD.3000503@shaw.ca> <6.2.0.14.2.20070713175627.031aada0@linux.sysreset.com> <4698356D.60605@gmail.com> <4698BE05.2080003@vandrovec.name> <469B4959.8010109@gmail.com> <20070717105459.GA15382@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:22863 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867AbXGRDIk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jul 2007 23:08:40 -0400
Received: by wr-out-0506.google.com with SMTP id 50so36002wra
        for <linux-ide@vger.kernel.org>; Tue, 17 Jul 2007 20:08:39 -0700 (PDT)
In-Reply-To: <20070717105459.GA15382@vana.vc.cvut.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Petr Vandrovec <petr@vandrovec.name>
Cc: Ryan Power <rpower@sysreset.com>, Robert Hancock <hancockr@shaw.ca>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Albert Lee <albertcc@tw.ibm.com>, Andrew Morton <akpm@linux-foundation.org>

> Fix reported task file values in sense data
> 
> ata_tf_read was setting HOB bit when lba48 command was submitted, but
> was not clearing it before reading "normal" data.  As it is only place
> which sets HOB bit in control register, and register reads should not
> be affected by other bits, let's just clear it when we are done with
> reading upper bytes so non-48bit commands do not have to touch ctl
> at all.
> 
> pata_scc suffered from same problem...
> 
> Signed-off-by: Petr Vandrovec <petr@vandrovec.name>

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
