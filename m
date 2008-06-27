From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: libata and DMA quirks
Date: Fri, 27 Jun 2008 19:31:23 +1000
Message-ID: <1214559083.8011.544.camel@pasglop>
References: <1214548895.8011.526.camel@pasglop>
	 <4864A6C9.2050709@ru.mvista.com> <1214556703.8011.531.camel@pasglop>
	 <4864AE92.2090805@ru.mvista.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:40298 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181AbYF0Jbx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Jun 2008 05:31:53 -0400
In-Reply-To: <4864AE92.2090805@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

On Fri, 2008-06-27 at 13:10 +0400, Sergei Shtylyov wrote:
> > It doesn't use DMA to transfer the bulk of ATAPI ? I know it uses PIO
> > for the CDB but the rest of the transfer isn't done with DMA ?
> >   
>    Like I said, DMA is used only for the *block* transfer commands for 
> which the transfer size would always be a multiple of 16 bytes.

Ok, I see. That might explain why I never saw a problem not doing
anything special with drivers/ide.

Cheers,
Ben.


