From: Mark Lord <mlord@pobox.com>
Subject: Re: SATL support for hdparm?
Date: Sat, 14 Feb 2009 19:09:12 -0500
Message-ID: <49975D28.4050101@pobox.com>
References: <20090214222114.GI17914@xi.wantstofly.org>
 <49975A6D.4010608@pobox.com> <20090215000603.GK17914@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36771 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbZBOAJT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Feb 2009 19:09:19 -0500
In-Reply-To: <20090215000603.GK17914@xi.wantstofly.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-ide@vger.kernel.org, dgilbert@interlog.com

Lennert Buytenhek wrote:
> On Sat, Feb 14, 2009 at 06:57:33PM -0500, Mark Lord wrote:
> 
>>> I have a bunch of SATA disks hanging off a SAS expander on which I
>>> would like to disable APM (using hdparm -B).  This doesn't work as-is,
>>> and from reading:
>>>
>>> 	http://smartmontools.sourceforge.net/smartmontools_scsi.html
>>>
>>> it appears that I'd need to hack hdparm to use the ATA PASS THROUGH
>>> SCSI command to make it talk to SATA disks behind a SAS expander, as
>>> was already done for smartctl.  Did anyone implement something like
>>> this for hdparm yet by any chance?
>> It actually does that already.  What version are you trying with?
> 
> I tried with 9.10.  Ah yes, now I see that the man page mentions SAT,
> but it doesn't appear to be detecting that it needs to do that.
> 
> 
>> Grab the latest from sourceforge (9.10 or 9.11) and try again.
>>
>> If it still doesn't work with that, then let me know and we'll sort
>> it out.
> 
> I get this when trying to set -B 254 (in an attempt to turn off head
> unload/load -- these are WD drives that do that quite frequently):
> 
> 	[root@heth hdparm-9.10]# ./hdparm -B 254 /dev/sdb
> 
> 	/dev/sdb:
> 	 setting Advanced Power Management level to 0xfe (254)
> 	 HDIO_DRIVE_CMD failed: Input/output error
> 	[root@heth hdparm-9.10]# 
> 
> I don't see it issuing any SG_IO ioctls with command byte being 0xA1
> or 0xA5 -- I don't see it issuing SG_IO at all:
..

That would be because it didn't see SG_IO defined in the header files
against which it was compiled.  Have a look at your /usr/include/scsi/sg.h
file and ensure it has SG_IO defined in there.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
