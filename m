From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: 02 Jun 2004 14:52:12 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1086209532.8016.2.camel@patibmrh9>
References: <068F5E91-B237-11D8-819C-000393A22C62@ieee.org><1085930101.3135.
	4.camel@patibmrh9>  <1086019779.3144.6.camel@patibmrh9><1086134487.12245.0.
	camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:13011 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264131AbUFBUwT
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Jun 2004 16:52:19 -0400
Received: from royntex01.iomegacorp.com (edison [10.1.1.82])
	by email.iomega.com (Postfix) with ESMTP id 866A61875
	for <linux-ide@vger.kernel.org>; Wed,  2 Jun 2004 14:52:18 -0600 (MDT)
In-Reply-To: <1086134487.12245.0.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

> kernel: irq event 18: bogus return value 3
> ...
> +		struct ata_taskfile *tf = &qc->tf;
> +		DPRINTK("before tf_read\n");
> +		ap->ops->tf_read(ap, &tf);

Cancel that.

I'm reminded of course I meant tf where I wrote &tf by such signals as:

drivers/scsi/libata-core.c: In function `ata_host_intr':
drivers/scsi/libata-core.c:2643: warning: passing arg 2 of pointer to function from incompatible pointer type

Pat LaVarre


