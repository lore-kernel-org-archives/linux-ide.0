From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: 21 May 2004 17:57:00 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1085183819.3125.0.camel@patibmrh9>
References: <1084717146.3576.3.camel@patibmrh9> <40AD7FB2.10506@pobox.com><1
	 085153750.6103.33.camel@patibmrh9><200405211746.35015.bzolnier@elka.pw.ed
	u	 .	pl><1085162347.4791.24.camel@patibmrh9><1085170025.3083.91.camel@pati
	bm	r h9> <40AE79E1.9020005@pobox.com><1085181861.3266.11.camel@patibmrh9> <
	40AE96D4.8060009@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:39925 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265173AbUEUX5H
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 May 2004 19:57:07 -0400
In-Reply-To: <40AE96D4.8060009@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

> > In the example here, we tell the host to expect to copy out x1000 = 4 Ki
> > bytes, but we tell the device to agree to copy out only x0001 blocks
> > i.e. x800 = 2 Ki bytes.
>
> That's considered a "don't do that" condition :)

Is that not an accurate simulation of the real world case of a write
error?

Pat LaVarre


