From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.23-rc7-mm1 AHCI ATA errors -- won't boot
Date: Tue, 25 Sep 2007 21:10:12 -0400
Message-ID: <46F9B174.8020806@garzik.org>
References: <fa.7B5oGGPZtkIAG9trDHdybt+z9Qg@ifi.uio.no> <fa.lh2GEsFivC+TeMBqgRXU+5p7ySM@ifi.uio.no> <fa.tqIC/0YXN2BDEJQ7WBFuJ0EEUrI@ifi.uio.no> <fa.Q/HeymU0u7VpG+dN5Lc1DraTos0@ifi.uio.no> <46F98E09.70805@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51402 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375AbXIZBKR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Sep 2007 21:10:17 -0400
In-Reply-To: <46F98E09.70805@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: "Berck E. Nash" <flyboy@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

Robert Hancock wrote:
> ATA spec says "The device shall return command aborted if the device 
> does not support the Power Management feature set." Whereas TEST UNIT 
> READY is required for SCSI. It seems the SAT authors didn't consider 
> this case.


Dumb me -- I misread that as mandatory.

	Jeff


