From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCHSET] libata: various fixes related to EH, take #4
Date: Fri, 10 Feb 2006 07:00:55 -0500
Message-ID: <43EC8077.4080003@pobox.com>
References: <11395518482722-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:17088 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751093AbWBJMBC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Feb 2006 07:01:02 -0500
In-Reply-To: <11395518482722-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello, Jeff.
> 
> This patchset is the fourth take of 'various fixes related to EH'
> patchset.  From the previous take[1], %01 and %02 made into the tree
> and %03 got nacked and #04 acked but didn't make into the tree due to
> dependency to %03.  (% denotes patch numbers in the previous take, #
> in this take)

Applied all four patches to 'upstream', but with comments:

* Given your current implementation, ata_qc_complete() should be inline, 
defined in a header somewhere.  And __ata_qc_complete() should be 
un-inlined.

* Is ATA_FLAG_IN_EH needed in future patches?  It's not used ATM.



