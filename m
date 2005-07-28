From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: libata suspend/resume
Date: Thu, 28 Jul 2005 14:31:50 +0100
Message-ID: <20050728133150.GA29418@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.81.22]:7053 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S261272AbVG1Nc2
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Jul 2005 09:32:28 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, axboe@suse.de

Hi,

An increasing number of laptop vendors seem to be including sata 
controllers now, and so we're looking at shipping the libata 
suspend/resume patch. The discussion about suspend in the scsi layer 
doesn't seem to have ended very conclusively, and I haven't been able to 
find any sign of that code ending up anywhere. What's the current 
status with this?

Thanks,
-- 
Matthew Garrett | mjg59@srcf.ucam.org
