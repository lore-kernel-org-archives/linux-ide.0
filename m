From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: 27 May 2004 19:28:51 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1085707731.3117.11.camel@patibmrh9>
References: <1084717146.3576.3.camel@patibmrh9> <40AD7FB2.10506@pobox.com><1
	 085153750.6103.33.camel@patibmrh9><200405211746.35015.bzolnier@elka.pw.ed
	u	 .	pl><1085162347.4791.24.camel@patibmrh9><1085170025.3083.91.camel@pati
	bm	r h9> <40AE79E1.9020005@pobox.com><1085182749.3122.15.camel@patibmrh9> <
	40AE9493.1040701@pobox.com><1085186021.4510.0.camel@patibmrh9>  <1085188300
	.3658.18.camel@patibmrh9><1085608170.4148.138.camel@patibmrh9>  <1085699522
	.3853.1.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:63621 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265478AbUE1B24
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 May 2004 21:28:56 -0400
In-Reply-To: <1085699522.3853.1.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

> naive variation on your auto sense patch
> ...
> I'll follow up with quoted dmesg when I can ...

Deeply boring, I'm sorry to say:

ata_tf_load_pio: feat 0x0 nsect 0x0 lba 0x0 0x12 0x0
ata_tf_load_pio: device 0xA0
ata_exec: cmd 0xA0

That was the end of life.

Now of course I hope to abandon that naive approach in favour of naively
misunderstanding what you're starting again with ata_check_bmdma near
the intact inline patch of:

http://marc.theaimsgroup.com/?l=linux-ide&m=108570321913006

Pat LaVarre


