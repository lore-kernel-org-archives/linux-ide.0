From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/1] sata_sil: Option to use IO space to access TF
 registers.
Date: Thu, 23 Oct 2008 08:32:15 +0100
Message-ID: <20081023083215.74e48b03@lxorguk.ukuu.org.uk>
References: <20081022182243.9471.87443.stgit@linux-chris2.mips.com>
	<20081022221623.344aea62@lxorguk.ukuu.org.uk>
	<20081022233439.GA30488@ftp.linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:33463 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751416AbYJWHdb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Oct 2008 03:33:31 -0400
In-Reply-To: <20081022233439.GA30488@ftp.linux-mips.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chris Dearman <chris@ftp.linux-mips.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

> unfortunately I don't think that's possible. There is no way to
> generate a read cycle to PCI memory space on this hardware without all
> of the byte enables being set. Normally this isn't a problem, a full

Ok so this isn't about not being able to do the workaround, you have
hardware which is just busted ? Is this devel hardware or stuff in mass
circulation ?

>   The patch is a relatively clean work around for limitations in the
> hardware I'm using, but I know it probably looks like just more
> cruft from an outside perspective so I won't be championing it :)

I would make the switch a runtime value personally - some network drivers
do this for similar reasons.

Alan
