From: Jeff Garzik <jgarzik@pobox.com>
Subject: ATAPI corruption found
Date: Wed, 05 Oct 2005 06:05:24 -0400
Message-ID: <4343A564.2060308@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:50647 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965097AbVJEKFa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Oct 2005 06:05:30 -0400
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1EN69Q-0001KJ-CA
	for linux-ide@vger.kernel.org; Wed, 05 Oct 2005 10:05:29 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>


When atapi_qc_complete() takes the error path, completes the SCSI 
command, SCSI EH runs, and the code attempts to complete the SCSI 
command again, this time with scsi_finish_command().

Ideally what we should be doing is simply not completing the SCSI 
command until REQUEST SENSE is complete, more accurately simulating 
autosense.

I should have a fix in the next day or so, unless somebody beats me to it.

	Jeff



