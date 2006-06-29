From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/9] libata: change debugging macros/adjust dbg levels
Date: Fri, 30 Jun 2006 03:09:16 +0900
Message-ID: <44A4174C.7020109@gmail.com>
References: <20060629160926.GB23122@zmei.tnic> <44A3FF72.8090404@gmail.com> <20060629172715.GA21339@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.233]:27845 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751230AbWF2SIy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jun 2006 14:08:54 -0400
Received: by wr-out-0506.google.com with SMTP id i21so126816wra
        for <linux-ide@vger.kernel.org>; Thu, 29 Jun 2006 11:08:54 -0700 (PDT)
In-Reply-To: <20060629172715.GA21339@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Borislav Petkov wrote:
> On Fri, Jun 30, 2006 at 01:27:30AM +0900, Tejun Heo wrote:
> <snip>
>>> @@ -805,11 +807,16 @@ extern void ata_do_eh(struct ata_port *a
>>> /*
>>>  * printk helpers
>>>  */
>>> -#define ata_port_printk(ap, lv, fmt, args...) \
>>> -	printk(lv"ata%u: "fmt, (ap)->id , ##args)
>>> +#define ata_port_printk(ap, lv, fmt, args...) do { \
>>> +	if (unlikely((ap)->msg_enable & (0xFF & (lv)))) \
>>                                          ^^^^why?
> Because the decimal value of ATA_MSG_TRACE, for example, is 128 (hex 0x80) and
> when i shift a 1 128 time to the left, the datatype, in our case an int, i
> think (dunno what gcc does exactly here) is too small for the shift. Besides,
> ap->msg_enable is an u32 so that if would never be true for something bigger
> than 0x20.

Please make

+	ATA_MSG_ERR	= 0,
+	ATA_MSG_WARN	= 1,
+	ATA_MSG_DRV	= 2,
+	ATA_MSG_INFO	= 3, /* revalidation messages, EH progress */
+	ATA_MSG_VDEBUG	= 4, /* verbose hot path */
+	ATA_MSG_CMD	= 5, /* issue / completion */
+	ATA_MSG_SG	= 6, /* SG map/unmap handling */
+	ATA_MSG_TRACE	= 7, /* function tracing, e.g. enter/exit */

And test for msg_enable & (1 << (lv)).  Otherwise the array will be 
unnecessarily large.

-- 
tejun
