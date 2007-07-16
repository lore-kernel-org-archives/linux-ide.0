From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Unbreak build of PMP with ACPI disabled
Date: Mon, 16 Jul 2007 19:32:57 +0900
Message-ID: <469B4959.8010109@gmail.com>
References: <20070713065600.GB8320@vana.vc.cvut.cz> <46972519.80703@gmail.com> <46980AFD.3000503@shaw.ca> <6.2.0.14.2.20070713175627.031aada0@linux.sysreset.com> <4698356D.60605@gmail.com> <4698BE05.2080003@vandrovec.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.231]:12985 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745AbXGPKdD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 06:33:03 -0400
Received: by qb-out-0506.google.com with SMTP id e11so1020410qbe
        for <linux-ide@vger.kernel.org>; Mon, 16 Jul 2007 03:33:02 -0700 (PDT)
In-Reply-To: <4698BE05.2080003@vandrovec.name>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Petr Vandrovec <petr@vandrovec.name>
Cc: Ryan Power <rpower@sysreset.com>, Robert Hancock <hancockr@shaw.ca>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Albert Lee <albertcc@tw.ibm.com>

[cc'ing Jeff and Albert]

Petr Vandrovec wrote:
> Fix reported task file values in sense data
> 
> ata_tf_read was setting HOB bit when lba48 command was submitted, but
> was not clearing it before reading "normal" data.  Maybe it would be
> better to just clear HOB bit immediately after reading upper halves
> for lba48 command, but I just decided to clear HOB bit in each
> ata_tf_read...
> 
> Signed-off-by: Petr Vandrovec <petr@vandrovec.name>

Acked-by: Tejun Heo <htejun@gmail.com>

Gee, thanks a lot for spotting this.  This is definitely for -stable.
Hmm... it's a separate issue and not your fault but ap->last_ctl caching
is broken in the function.  Albert is about to remove ap->last_ctl
caching but we still need to fix it for -stable.  Petr, are you
interested in submitting a separate patch for fixing ap->last_ctl
handling in the function?

Thanks.

-- 
tejun
