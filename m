From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] atapi request sense work
Date: Fri, 21 May 2004 17:51:29 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40AE79E1.9020005@pobox.com>
References: <1084717146.3576.3.camel@patibmrh9> <40AD7FB2.10506@pobox.com><1	085153750.6103.33.camel@patibmrh9><200405211746.35015.bzolnier@elka.pw.edu.	pl><1085162347.4791.24.camel@patibmrh9> <1085170025.3083.91.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42463 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265977AbUEUVvm
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 May 2004 17:51:42 -0400
In-Reply-To: <1085170025.3083.91.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Pat LaVarre wrote:
> Without auto sense, we read and write ok ...
> 
> But when I try a no-data op x00 "TEST UNIT READY", I get:

Well, it's a no-op on the ATA side, but not on the ATAPI side.

Thanks for testing though, I'll think about this one a bit.  I'm 
surprised the interrupt wasn't handled correctly.

	Jeff



