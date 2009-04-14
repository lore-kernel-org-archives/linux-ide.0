From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes] libata: handle SEMB signature better
Date: Wed, 15 Apr 2009 06:03:15 +0900
Message-ID: <49E4FA13.1090400@kernel.org>
References: <49E466DE.7020701@kernel.org> <49E47DBF.9060502@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39686 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752731AbZDNVEY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Apr 2009 17:04:24 -0400
In-Reply-To: <49E47DBF.9060502@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, David Haun <drhaun88@gmail.com>, liw@liw.fi, jmcarranza@gmail.com

Hello, Jeff.

Jeff Garzik wrote:
>>      switch (class) {
>> +    case ATA_DEV_SEMB:
>> +        class = ATA_DEV_ATA;    /* some hard drives report SEMB sig */
>>      case ATA_DEV_ATA:
>>          tf.command = ATA_CMD_ID_ATA;
>>          break;
> 
> Why assign class now, as opposed to after IDENTIFY DEVICE succeeds / fails?

The class variable indicates which class the code is gonna try not the
one which is discovered, so it's more consistent to set it before
trying it out.

> 
>> @@ -2119,6 +2125,7 @@ retry:
>>      else
>>          err_mask = ata_do_dev_read_id(dev, &tf, id);
>>  
>> +    err_mask |= AC_ERR_DEV;
>>      if (err_mask) {
>>          if (err_mask & AC_ERR_NODEV_HINT) {
>>              ata_dev_printk(dev, KERN_DEBUG,
> 
> Why is err_mask being unconditionally set?

Oh.. c**p, that's debug code I forgot to remove.  Thanks for spotting
it.  :-)

> I would think this would make more sense:
> 
>     if (!err_mask && class == ATA_DEV_SEMB)
>         class = ATA_DEV_ATA;
>     else if (err_mask) {
>         if (err_mask & AC_ERR_NODEV_HINT) {
>         ...

I made the code a fast exit path because I didn't know how an actual
SEMB device would respond to it.  If the device timeouts IDENTIFYs,
retrying can be quite painful.  ATA drives w/ SEMB signature being
extrmemely rare, I think it's better to trade their slight chance of
detection failure but then again it's not like we have a lot of SEMB
devices.  What do you think?

Thanks.

-- 
tejun
