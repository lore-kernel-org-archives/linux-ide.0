From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_via cd/dvd timeout problems
Date: Fri, 21 Sep 2007 16:24:14 +0100
Message-ID: <20070921162414.7ac2606a@the-village.bc.nu>
References: <124748.3608.qm@web54408.mail.yahoo.com>
	<1188982210.3075.9.camel@castor.rsk.org>
	<20070906013347.1f588dc4@the-village.bc.nu>
	<1190364785.3121.10.camel@castor.rsk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41084 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753277AbXIUPRR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Sep 2007 11:17:17 -0400
In-Reply-To: <1190364785.3121.10.camel@castor.rsk.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: richard kennedy <richard@rsk.demon.co.uk>
Cc: linux-ide@vger.kernel.org

On Fri, 21 Sep 2007 09:53:05 +0100
richard kennedy <richard@rsk.demon.co.uk> wrote:

> On Thu, 2007-09-06 at 01:33 +0100, Alan Cox wrote:
> 
> > Probably. If you can file a bug in bugzilla and assign it to me I'll take
> > a look at this after the kernel summit. There are one or two reports with
> > pata_via and ATAPI (ie CD) that look similar.
> 
> Hi Alan,
> your [PATCH] libata: Set transfer sizes properly for ATAPI fixes this
> for me.

Yay - thanks for letting me know and for testing it.

Alan
