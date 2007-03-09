From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 08/12] libata: convert drivers with combined SATA/PATA
 ports to new init model
Date: Fri, 09 Mar 2007 22:04:45 +0900
Message-ID: <45F15B6D.90207@gmail.com>
References: <1173438935540-git-send-email-htejun@gmail.com>	<11734389362943-git-send-email-htejun@gmail.com> <20070309124630.50f1471c@lxorguk.ukuu.org.uk> <45F14B1A.5020605@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.238]:65053 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767258AbXCINEp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 08:04:45 -0500
Received: by wx-out-0506.google.com with SMTP id h31so850728wxd
        for <linux-ide@vger.kernel.org>; Fri, 09 Mar 2007 05:04:44 -0800 (PST)
In-Reply-To: <45F14B1A.5020605@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Alan Cox wrote:
>>> * promise: SATA/PATA branches are converted into separate ops.
>>>   Remaining ones are converted to more standard ap->cbl ==
>>>   ATA_CBL_SATA check.
>>
>> NAK this specifically
>>
>> I've got some pending and needed patches to spot where drives report SATA
>> and the host is doing PATA cables. This is needed for various warped PATA
>> controller and glue variants and means that the PATA port probe may end
>> up returning with ap->cbl == ATA_CBL_SATA if it finds SATA devices on a
>> supposedly PATA port.
> 
> Indeed.
> 
> With the new init model, testing for ATA_FLAG_SATA should be the
> preferred test, as it makes all the mixed PATA/SATA ->port_start hackery
> and tests go away.
> 
> With the new init model, the LLDD and core should now /always/ know
> whether the port is PATA or SATA.  The LLDD will set it up that way.
> 
> Now that different ->ops for PATA and SATA is supported (with Tejun's
> patches), I would expect the number of "is this port SATA?" tests to
> drop dramatically, for reasons mentioned in the previous paragraph and
> also because you can create separate hooks for PATA and SATA that
> permits the killing of "is this SATA?" or "is this PATA?" tests.

I see.  I'll drop that part.

Thanks.

-- 
tejun
