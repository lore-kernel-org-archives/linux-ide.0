From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 08/12] libata: convert drivers with combined SATA/PATA
 ports to new init model
Date: Fri, 09 Mar 2007 06:55:06 -0500
Message-ID: <45F14B1A.5020605@garzik.org>
References: <1173438935540-git-send-email-htejun@gmail.com>	<11734389362943-git-send-email-htejun@gmail.com> <20070309124630.50f1471c@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55238 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965182AbXCILzJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 06:55:09 -0500
In-Reply-To: <20070309124630.50f1471c@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
>> * promise: SATA/PATA branches are converted into separate ops.
>>   Remaining ones are converted to more standard ap->cbl ==
>>   ATA_CBL_SATA check.
> 
> NAK this specifically
> 
> I've got some pending and needed patches to spot where drives report SATA
> and the host is doing PATA cables. This is needed for various warped PATA
> controller and glue variants and means that the PATA port probe may end
> up returning with ap->cbl == ATA_CBL_SATA if it finds SATA devices on a
> supposedly PATA port.

Indeed.

With the new init model, testing for ATA_FLAG_SATA should be the 
preferred test, as it makes all the mixed PATA/SATA ->port_start hackery 
and tests go away.

With the new init model, the LLDD and core should now /always/ know 
whether the port is PATA or SATA.  The LLDD will set it up that way.

Now that different ->ops for PATA and SATA is supported (with Tejun's 
patches), I would expect the number of "is this port SATA?" tests to 
drop dramatically, for reasons mentioned in the previous paragraph and 
also because you can create separate hooks for PATA and SATA that 
permits the killing of "is this SATA?" or "is this PATA?" tests.

	Jeff



