From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Polling (was Re: [PATCHSET 2/2] implement PMP support, take 6)
Date: Mon, 01 Oct 2007 08:28:18 -0400
Message-ID: <4700E7E2.4040208@garzik.org>
References: <1190521193410-git-send-email-htejun@gmail.com>	<46F9BF3E.5050708@garzik.org>	<46FA1B4E.8090103@gmail.com>	<46FD079F.3010007@garzik.org>	<46FD0D50.8030602@gmail.com>	<20070928155703.490d7575@the-village.bc.nu>	<46FD1BAD.8020506@garzik.org>	<20070928164312.208b8c56@the-village.bc.nu>	<46FD2071.2070608@garzik.org>	<46FD5D55.4070706@rtr.ca>	<46FDC6A8.3000306@garzik.org> <20070929215623.030abd66@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46089 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbXJAM2Z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Oct 2007 08:28:25 -0400
In-Reply-To: <20070929215623.030abd66@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Alan Cox wrote:
> ty today, with 3+ month kernel release cycles (ugh!!).
>> I'm very much interested in hearing suggestions and comments.
> 
> I think PMP should go in for 2.6.24 and then get revised over time to not
> poll and to go via qc_issue. Which seems to be the consensus of everyone
> but you on this one.

It's not an "over time" issue.  SAS drivers that will be ready for 
2.6.24 (broadsas, mvsas) have both been coded to support PMP 
transparently -- but the current libata PMP code requires that PMP 
support in SAS be TURNED OFF, because it is fundamentally incompatible 
by its design.

This is an issue that has been present and known for many, many months 
-- as long as drivers/scsi/libsas/sas_ata.c has been in the tree.

The more we walk down the polling path, the more incompatible we become 
with SATA-capable controllers that are in users' hands today.

	Jeff


