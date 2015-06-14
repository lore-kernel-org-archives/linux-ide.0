From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 4/4] libata: Fall back to unqueued READ LOG EXT if the DMA variant fails
Date: Sun, 14 Jun 2015 19:45:49 -0400
Message-ID: <yq1wpz5hn0y.fsf@sermon.lab.mkp.net>
References: <1430790861-30066-1-git-send-email-martin.petersen@oracle.com>
	<1430790861-30066-4-git-send-email-martin.petersen@oracle.com>
	<557B39FB.4060304@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:19342 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbbFNXp6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Jun 2015 19:45:58 -0400
In-Reply-To: <557B39FB.4060304@redhat.com> (David Milburn's message of "Fri,
	12 Jun 2015 14:58:51 -0500")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, tj@kernel.org, hare@suse.de, linux-ide@vger.kernel.org

>>>>> "David" == David Milburn <dmilburn@redhat.com> writes:

David> Have you seen both commands fail on any of the Samsung SSD 840
David> EVO drives?

David> # dmesg | grep Samsung [ 2.254443] ata10.00: ATA-9: Samsung SSD
David> 840 EVO 1TB, EXT0BB6Q, max UDMA/133

I have an 840 EVO in my test box. However, yours is running an older
firmware that predates queued TRIM support. So I guess that's
expected...

-- 
Martin K. Petersen	Oracle Linux Engineering
