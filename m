From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: 19 May 2004 14:35:41 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084998941.4645.69.camel@patibmrh9>
References: <1084717146.3576.3.camel@patibmrh9> <40A7F641.3070809@pobox.com>
	<1084819720.4328.86.camel@patibmrh9>  <40A90D96.2040002@pobox.com><108482  
	8		840.3211.26.camel@patibmrh9>  <40A92F69.6030309@pobox.com><1084831524.32
	 11	.67.camel@patibmrh9>  <40A93E85.4010904@pobox.com><1084920024.3191.8.ca
	 mel@patibmrh9>  <40AAA0BA.9040307@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:43479 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264541AbUESUfz
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 May 2004 16:35:55 -0400
In-Reply-To: <40AAA0BA.9040307@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

> I don't necessarily expect this work, but we'll see...

Thanks I'll try -bk6 with my first device i.e.
my mass-produced PATA ATAPI DMA plus my mass-produced SATA adapter.

>  	cmd->sense_buffer[7] = 14 - 8;	/* addnl. sense len. FIXME: correct? */
> ...
>  	cmd->sense_buffer[7] = 14 - 8;	/* addnl. sense len. FIXME: correct? */

What's in dispute for these FIXME?

At offset seven in a field whose length is one byte we find the
additional length, when the data comes from op x03 "REQUEST SENSE". 
Therefore the value we should put there is the total length minus the
offset seven minus the length one.

14 - 7 - 1 would be a plainer way of saying that, sure, but 14 - 8
always gives us the same answer.

A comment like /* total - offset - length */ might help.  I know source
code like 14 - 7 - 1 has a history of persuading future maintainers to
erroneously code (total - offset - 1) where (total - offset - length)
was meant.

"What's in dispute for these FIXME?"

Curiously yours, Pat LaVarre


