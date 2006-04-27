From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCHSET 7/9] add NCQ support, take 2
Date: Thu, 27 Apr 2006 05:11:05 -0400
Message-ID: <44508AA9.7030702@pobox.com>
References: <1144763616819-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:17315 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964997AbWD0JLS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Apr 2006 05:11:18 -0400
In-Reply-To: <1144763616819-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello, again.
> 
> This is the second take of add-NCQ-support patchset.  Changes from the
> last take[L] are...
> 
> * ahci autopsy result is used to determine use_log_10h
> 
> * sata_sil24 NCQ support added

I've skipped ahead in the review order a bit, to this patchset.  Its 
fairly straightforward, so I ACK all 15 patches.

I'm worried cruft still remains related to ATA_MAX_QUEUE, but its a 
vague worry.   ATA_MAX_QUEUE magically changes a bunch of allocations 
and loops, when changed, and I didn't take the time to audit each use.

	Jeff



