From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] libata atapi work #2.1
Date: 17 May 2004 19:48:34 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084844914.3211.182.camel@patibmrh9>
References: <1084721991.3085.6.camel@patibmrh9> <40A7F757.9020200@pobox.com>
	<1084805767.3083.10.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:22255 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S261610AbUERBsv
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 May 2004 21:48:51 -0400
Received: from royntex01.iomegacorp.com (edison [10.1.1.82])
	by email.iomega.com (Postfix) with ESMTP id B37A01A1F
	for <linux-ide@vger.kernel.org>; Mon, 17 May 2004 19:48:50 -0600 (MDT)
In-Reply-To: <1084805767.3083.10.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

> > on the SCSI end of ATAPI ...
> > * issue REQUEST SENSE, to simulate an
> > auto-sensing scsi device
> ...
> I will have to discover how to auto sense only after a plain failure,
> not inappropriately after a timeout.
> ...
> I will try to create a desired inference of ATAPI op x03 "REQUEST SENSE"
> to immediately follow the failing command, after the pattern of the
> existing inference of ATA op xA1 "IDENTIFY".

Sorry, no good.

That won't work well til after someone finishes the "(TODO: investigate
using standard PIO-IN paths)" of ata_dev_identify of
drivers/scsi/libata-core.c to replace the "we hand-code it here" found
there now.

Also ATA folk might resist adding a for-them-unused { u8 sense[0x100]; }
member to the (struct ata_port), by way of analogy with the { u16
id[ATA_ID_WORDS]; } now found there in include/linux/libata.h.

Pat LaVarre


