From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] libata: various fixes related to EH, take #4
Date: Fri, 10 Feb 2006 21:16:45 +0900
Message-ID: <43EC842D.2070601@gmail.com>
References: <11395518482722-git-send-email-htejun@gmail.com> <43EC8077.4080003@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.183]:35132 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751158AbWBJMQt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Feb 2006 07:16:49 -0500
Received: by pproxy.gmail.com with SMTP id o67so234740pye
        for <linux-ide@vger.kernel.org>; Fri, 10 Feb 2006 04:16:48 -0800 (PST)
In-Reply-To: <43EC8077.4080003@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> Hello, Jeff.
>>
>> This patchset is the fourth take of 'various fixes related to EH'
>> patchset.  From the previous take[1], %01 and %02 made into the tree
>> and %03 got nacked and #04 acked but didn't make into the tree due to
>> dependency to %03.  (% denotes patch numbers in the previous take, #
>> in this take)
> 
> 
> Applied all four patches to 'upstream', but with comments:
> 
> * Given your current implementation, ata_qc_complete() should be inline, 
> defined in a header somewhere.  And __ata_qc_complete() should be 
> un-inlined.

Will submit a patch ASAP.

> * Is ATA_FLAG_IN_EH needed in future patches?  It's not used ATM.

I don't know it depends on how we'll do EH <-> irq/pio synchronization, 
but my bet is on ATA_FLAG_IN_EH being used.

Thanks.

-- 
tejun
