From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFT] libata hpa support
Date: Fri, 23 Feb 2007 18:19:59 +0000
Message-ID: <20070223181959.56502bf2@lxorguk.ukuu.org.uk>
References: <20070223170625.GA29931@athena.road.mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60191 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933142AbXBWRQ1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Feb 2007 12:16:27 -0500
In-Reply-To: <20070223170625.GA29931@athena.road.mcmartin.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kyle McMartin <kyle@canonical.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, mjg59@ubuntu.com

> A few questions are raised, libata SATA hasn't been resizing disks in the
> past, should we only disable HPA on PATA only, a la drivers/ide? In any

drivers/ide disable HPA on SATA ports it manages too.

> event, supporting HPA lets people who had partitions which extend beyond
> the protected area boot with libata PATA. Some policy decision needs to be
> made too... Right now, I'm just disabling it unilaterally.

Last time we had a Red Hat bitching session about it the main thing the
installer guys wanted was a way to find out what size the disk thought it
was before we twiddled with it, so that they can make an intelligent
attempt to handle partitioning in the case where for example a disk is
unpartitioned. A partitioned disk isn't so much of a problem as the
partitioning itself tells you the a lot about the state of disk and
intended HPA.

What do the Ubuntu installer/partitioning folk think ?

Alan
