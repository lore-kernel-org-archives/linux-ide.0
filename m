From: Mark Lord <liml@rtr.ca>
Subject: Re: SATA timeout value
Date: Mon, 23 Apr 2007 18:07:13 -0400
Message-ID: <462D2E11.2010806@rtr.ca>
References: <32623559.31421177346818776.JavaMail.servlet@perfora>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3188 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754328AbXDWWHQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Apr 2007 18:07:16 -0400
In-Reply-To: <32623559.31421177346818776.JavaMail.servlet@perfora>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell Sloan <russell.sloan@lingua-data.com>
Cc: htejun@gmail.com, linux-ide@vger.kernel.org

Russell Sloan wrote:
> Russell Sloan wrote:
>> I'm using SG_IO and I'm curently passing in:
>>   sg_io_hdr_t.timeout = 5;
>>
>> This should be a 5 ms timeout, correct?  I've tried a few different values, 
> from 5 to 1000 and it still takes 90+ seconds for it to timeout and return to 
> my program.
>> I will try HDIO and see if that behaves any differently.
> 
> It might be retrying.  Can you post dmesg after the command?
> 

That command typically requires more than an hour to complete.
Using "hdparm -I" will (usually) report the minimum time required
for any specific drive.

-ml
