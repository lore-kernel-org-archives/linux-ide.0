From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 8/8] sata_sil24: reimplement hardreset
Date: Thu, 06 Apr 2006 12:54:08 -0400
Message-ID: <443547B0.3020107@pobox.com>
References: <11442437423316-git-send-email-htejun@gmail.com> <4435456E.6060504@pobox.com> <20060406165311.GH31998@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33976 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932194AbWDFQyL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Apr 2006 12:54:11 -0400
In-Reply-To: <20060406165311.GH31998@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> On Thu, Apr 06, 2006 at 12:44:30PM -0400, Jeff Garzik wrote:
>>> +
>>> +	if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
>>> +		reason = "device not ready";
>>> +		goto err;
>>> +	}
>>> +
>>> +	/* SStatus is a bit sluggish (reports 0) on sil24, wait for it */
>>> +	sil24_poll_register(port + PORT_SSTATUS, 0xf, 0x0, 10, 100);
>> Its weird to poll BSY before polling SStatus.
>>
> 
> It turned out that the above delay is not enough.  SStatus oscillates
> between zero and valid status for short duration after hardreset
> resulting in weird messages like 'ata2: SATA link up <unknown>
> (SStatus 0 Scontrol 310)".  I've added unconditional msleep(100) right
> afer hardreset and removed this code.
> 
>>> +	/* no classification, just return */
>> bad comment?
> 
> How about...
> 
> 	/* Sil24 hardreset doesn't report device signature, leave
> 	 * classes[] alone.
> 	 */
> ?

Yes, my brain groks this much better :)

	Jeff



