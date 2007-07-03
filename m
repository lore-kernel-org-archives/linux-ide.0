From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 02/12] libata: implement AC_ERR_NCQ
Date: Tue, 03 Jul 2007 23:58:57 +0900
Message-ID: <468A6431.2060401@gmail.com>
References: <11832836172598-git-send-email-htejun@gmail.com> <468A5C3B.7040508@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:63090 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757814AbXGCO7L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 10:59:11 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1243927nze
        for <linux-ide@vger.kernel.org>; Tue, 03 Jul 2007 07:59:10 -0700 (PDT)
In-Reply-To: <468A5C3B.7040508@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> +++ b/include/linux/libata.h
>> @@ -322,7 +322,8 @@ enum ata_completion_errors {
>>      AC_ERR_SYSTEM        = (1 << 6), /* system error */
>>      AC_ERR_INVALID        = (1 << 7), /* invalid argument */
>>      AC_ERR_OTHER        = (1 << 8), /* unknown */
>> -    AC_ERR_NODEV_HINT    = (1 << 9), /* polling device detection hint */
>> +    AC_ERR_NCQ        = (1 << 9), /* marker for offending NCQ qc */
>> +    AC_ERR_NODEV_HINT    = (1 << 10), /* polling device detection
>> hint */
> 
> 
> patch is OK, except for the above very-minor flaw:  to remind, do not
> re-arrange bit numbers in the same patch you are adding bits.  it makes
> the patch more difficult to read.  Just add the new bit at the end.
> 
> If you wish to re-arrange the bits, do it in a separate patch (though I
> see no need for re-arranging)

Indeed, I didn't mean to rearrange them.  Probably just slipped through
while editing.  Will fix.

-- 
tejun
