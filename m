From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH #upstream-fixes] libata: assume no device is attached
 if both IDENTIFYs are aborted
Date: Wed, 26 Mar 2008 10:48:16 -0400
Message-ID: <47EA6230.1090301@rtr.ca>
References: <47E5F5D5.6050203@gmail.com> <47EA583C.8070501@rtr.ca> <47EA6128.9000006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2079 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755170AbYCZOsR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 26 Mar 2008 10:48:17 -0400
In-Reply-To: <47EA6128.9000006@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, jb.faq@gmx.de, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> Mark Lord wrote:
>> Tejun Heo wrote:
>> ..
>>> Modify EH such that it assumes no device is attached if both flavors
>>> of IDENTIFY are aborted by the device.  There really isn't much point
>>> in retrying when the device actively aborts the commands.
>> ..
>>
>> And thus dies support for the few very early IDE drives that lacked
>> IDENTIFY.
>>
>> R.I.P.  :)
>>
>> (not that they would have worked with libata in the first place)
> 
> How did they work anyway?  By specifying geometry manually to the
> driver?  I think we can do that.  We just need another cute HORKAGE.
> ATA_HORKAGE_NO_IDENITFY and some massaging around EH to handle it.
> Heh... That's gonna be a silly but fun project.  :-)
..

Geometry from CMOS, BIOS, partition table, or kernel command line.

But I haven't owned one for perhaps 15 years or more,
and they really are NOT WORTH IT in libata -- all of those
nice little ata_id_* macros would be affected.

If one did want to do it, I think the best approach would be to
generate a fake drive ID block, and populate it with suitably
pre-ATA1 era default values.  Then the rest of libata would not
require modifications.

Cheers

