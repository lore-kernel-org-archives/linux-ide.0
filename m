From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: 24 May 2004 09:27:59 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1085412479.3362.7.camel@patibmrh9>
References: <1084717146.3576.3.camel@patibmrh9> <40AD7FB2.10506@pobox.com><1
	 085153750.6103.33.camel@patibmrh9><200405211746.35015.bzolnier@elka.pw.ed
	u	 .	pl><1085162347.4791.24.camel@patibmrh9><1085170025.3083.91.camel@pati
	bm	r h9> <40AE79E1.9020005@pobox.com><1085182749.3122.15.camel@patibmrh9> <
	40AE9493.1040701@pobox.com><1085186021.4510.0.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:2242 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264306AbUEXP2F
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 May 2004 11:28:05 -0400
In-Reply-To: <1085186021.4510.0.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff G:

> I recommend we apply the following patch, so that non-data commands no
> longer provoke "irq" "nobody cared!".
> 
> Open-ioctl-close of /dev/scd$n now mostly works.

Nope, not that patch, that patch messes unjustifiably with the (rare or
not) default case of ata_host_intr.

Naturally next I'll try naming the fragment of code that fetches the
host_stat so I can concisely say do that only when appropriate.

Pat LaVarre


