From: <Stuart_Hayes@Dell.com>
Subject: RE: [patch 1/3] libata: change drive ready wait after hard reset to 5s
Date: Wed, 11 Mar 2009 11:45:50 -0500
Message-ID: <DFEF91B22ED07447AB6AA4B237F913F902185BDA@ausx3mpc125.aus.amer.dell.com>
References: <200903041959.n24Jxl2X028532@imap1.linux-foundation.org> <49B76AA9.2030707@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ausxippc101.us.dell.com ([143.166.85.207]:11865 "EHLO
	ausxippc101.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbZCKQpx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Mar 2009 12:45:53 -0400
Content-class: urn:content-classes:message
In-Reply-To: <49B76AA9.2030707@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, akpm@linux-foundation.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello,
> 
> akpm@linux-foundation.org wrote:
>> From: Stuart Hayes <stuart_hayes@dell.com>
>> 
>> This fixes problems during resume with drives that take longer than
>> 1s to be ready.  The ATA-6 spec appears to allow 5 seconds for a
>> drive to be ready. 
>> 
>> On one affected system, this patch changes "PM: resume devices
>> took..." message from 17 seconds to 4 seconds, and gets rid of a lot
>> of ugly timeout/error messages.
> 
> Can you please attach log for this?  Which controller was it?
> 

And the controller is nVidia Corporation MCP79 AHCI Controller (rev b1).

>> Without this patch, the libata code moves on after 1s, tries to send
>> a soft reset (which the drive doesn't see because it isn't ready)
>> which also times out, then an IDENTIFY command is sent to the drive
>> which times out, and finally the error handler will try to send
>> another hard reset which will finally get things working.
> 
> This adds 5s delays to common detection paths.  That said, 1s could
> be too short. 
> 
>> diff -puN
>>
include/linux/libata.h~libata-change-drive-ready-wait-after-hard-reset
>> -to-5s include/linux/libata.h
>> ---
>>
a/include/linux/libata.h~libata-change-drive-ready-wait-after-hard-res
>> et-to-5s +++ a/include/linux/libata.h
>> @@ -275,7 +275,7 @@ enum {
>>  	 * advised to wait only for the following duration before
>>  	 * doing SRST.
>>  	 */
>> -	ATA_TMOUT_PMP_SRST_WAIT	= 1000,
>> +	ATA_TMOUT_PMP_SRST_WAIT	= 5000,
> 
> Okay, it's already merged but this will add a lot of delay to device
> probing.  I think we better be a bit smarter here. 
> 
> Thanks.

