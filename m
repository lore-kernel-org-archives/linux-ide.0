From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: PATA drivers in libata?
Date: Sun, 13 Feb 2005 17:01:51 -0500
Message-ID: <420FCE4F.7010205@pobox.com>
References: <Pine.LNX.4.44.0502131611360.16537-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27804 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261317AbVBMWCM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 13 Feb 2005 17:02:12 -0500
In-Reply-To: <Pine.LNX.4.44.0502131611360.16537-100000@coffee.psychology.mcmaster.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Mark Hahn wrote:
>>* With ATA passthru (in libata-dev currently), libata supports SMART and 
>>the HDIO_CMD/HDIO_TASK generalized ioctls.  Should I care about 
>>supporting other ioctls?
> 
> 
> is there some other mechanism to en/disable write caching?

Besides the SG_IO | HDIO_DRIVE_CMD | HDIO_DRIVE_TASK | 
HDIO_DRIVE_TASKFILE ioctls?  Nope.

	Jeff



