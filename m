From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] jmicron: make ide jmicron driver play nice with libata
 ones
Date: Sat, 17 Mar 2007 22:13:11 +0000
Message-ID: <20070317221311.2d114d2d@lxorguk.ukuu.org.uk>
References: <20070316060610.GA6152@htj.dyndns.org>
	<200703172136.20784.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38344 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751110AbXCQVLd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Mar 2007 17:11:33 -0400
In-Reply-To: <200703172136.20784.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, justin@jmicron.com

> > PATA ports live in separate functions with different programming
> > interfaces.  pata_jmicron and ide jmicron drivers can drive only the
> > PATA part.

This isn't actually true. The IDE jmicron driver can drive both the PATA
and the SATA parts in legacy mode. It cannot drive the SATA part in AHCI
mode.

Alan
