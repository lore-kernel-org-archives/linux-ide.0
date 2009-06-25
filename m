From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] libata: Delegate nonrot flag setting to SCSI
Date: Wed, 24 Jun 2009 22:46:33 -0400
Message-ID: <yq1ab3xrpx2.fsf@sermon.lab.mkp.net>
References: <yq1eit9rurq.fsf@sermon.lab.mkp.net> <4A42D49D.1070100@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from acsinet12.oracle.com ([141.146.126.234]:52279 "EHLO
	acsinet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbZFYCrc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Jun 2009 22:47:32 -0400
In-Reply-To: <4A42D49D.1070100@garzik.org> (Jeff Garzik's message of "Wed, 24
	Jun 2009 21:36:29 -0400")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, jens.axboe@oracle.com, linux-ide@vger.kernel.org

>>>>> "Jeff" == Jeff Garzik <jeff@garzik.org> writes:

Jeff> Does the existence of this code cause any problems or regressions
Jeff> today?

Nope.  We set the flag twice, that's all.


Jeff> It looks correct vis a vis current drivers/scsi/sd.c, but given
Jeff> that the merge window just closed, I lean towards classifying this
Jeff> as a cleanup (thus, 2.6.32).

Up to you.  I obviously couldn't submit this patch until the relevant
SCSI bits hit Linus' tree and that didn't happen until yesterday.

-- 
Martin K. Petersen	Oracle Linux Engineering
