From: "Mat Loikkanen" <Mat.Loikkanen@synopsys.com>
Subject: Libata NCQ
Date: Wed, 13 Apr 2005 11:24:09 -0700
Message-ID: <005f01c54055$fbf9b110$3c05040a@internal.synopsys.com>
Reply-To: <Mat.Loikkanen@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from us01smtp1.synopsys.com ([198.182.44.79]:39054 "EHLO
	boden.synopsys.com") by vger.kernel.org with ESMTP id S261151AbVDMSYL
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Apr 2005 14:24:11 -0400
Received: from maiden.synopsys.com (maiden.synopsys.com [146.225.100.170])
	by boden.synopsys.com (Postfix) with ESMTP id 34982DD8A
	for <linux-ide@vger.kernel.org>; Wed, 13 Apr 2005 11:23:20 -0700 (PDT)
Received: from us03-mail-1.synopsys.com (localhost [127.0.0.1])
	by maiden.synopsys.com (8.9.1/8.9.1) with ESMTP id LAA21598
	for <linux-ide@vger.kernel.org>; Wed, 13 Apr 2005 11:24:10 -0700 (PDT)
Received: from us03-mail-1.synopsys.com (localhost [127.0.0.1])
	by us03-mail-1.synopsys.com (Postfix) with ESMTP id 84AE35C5
	for <linux-ide@vger.kernel.org>; Wed, 13 Apr 2005 11:24:09 -0700 (PDT)
Received: from loikd600 (unknown [10.4.5.60])
	by us03-mail-1.synopsys.com (Postfix) with ESMTP id 58DE35C2
	for <linux-ide@vger.kernel.org>; Wed, 13 Apr 2005 11:24:09 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

>From what Jeff says, it sounds like it wouldn't take much to implement the
necessary changes for Libata to support NCQ, but that testing would be time
consuming.  Our host controller does NCQ, and we have drives (directly from
manufacturers) that also do NCQ.  I'd be able to do testing ... if somebody
made the code changes to Libata.  I just don't know my way around the SCSI
layer, so I'd be groping around in the dark if I embarked on trying to
figure this out.  Anybody out there want to tackle this, as a joint effort
with me?  I can dedicate as much time as needed on my end.

Cheers,
-mat
 
Mat Loikkanen
Synopsys, Inc.


