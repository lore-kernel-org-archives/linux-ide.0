From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Why we were seeing so many spurious NCQ completions
Date: Thu, 06 Dec 2007 21:25:35 -0500
Message-ID: <4758AF1F.2060203@garzik.org>
References: <4758AD58.3000801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38311 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752749AbXLGCZm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Dec 2007 21:25:42 -0500
In-Reply-To: <4758AD58.3000801@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, diego torres <dtorres@coral.dnsalias.org>, Michael Tokarev <mjt@tls.msk.ru>

Tejun Heo wrote:
> Hello, all.
> 
> This has been going on for quite some time now but I finally succeeded
> to reproduce the problem and find out what has been going on.  It
> wasn't drive's or controller's fault.  The spurious completion
> detection logic was wrong which makes all of this my fault.  :-)
> 
> The attached patch induces NCQ spurious completions by inserting
> artificial delays during irq handling.  The following is log with the
> patch applied.
> 
> A [ 1125.478813] ata35: MON issue=0x0 SAct=0x1 sactive=0x3 SDB FIS=004040a1:00000002
> B [ 1125.480248] ata35: MON issue=0x4 SAct=0x6 sactive=0x7 SDB FIS=004040a1:00000001
> C [ 1125.481614] ata35: MON issue=0x0 SAct=0x5 sactive=0x7 SDB FIS=004040a1:00000002
> D [ 1125.481704] ata35: YYY 0x2 -> 0x4
> E [ 1125.481722] ata35: XXX issue=0x0 SAct=0x1 sactive=0x1 SDB FIS=004040a1:00000004
> F [ 1125.483087] ata35: MON issue=0x0 SAct=0x0 sactive=0x1 SDB FIS=004040a1:00000001
> G [ 1125.484297] ata35: MON issue=0x4 SAct=0x6 sactive=0x7 SDB FIS=004040a1:00000001

Thanks a lot for tracking this down, and thanks even more for being 
humble enough to admit mistakes.  More kernel hackers should follow your 
example.

I continue to be a proud mentor, watching you kick ass on the Linux 
kernel scene :)

	Jeff



