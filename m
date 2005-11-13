From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: libata-passthrough problem.
Date: Sun, 13 Nov 2005 15:13:25 +0000
Message-ID: <43775815.2090204@superbug.demon.co.uk>
References: <4375CA38.9000905@superbug.demon.co.uk> <437607B5.7060605@rtr.ca> <43762CEF.2070704@pobox.com> <43764853.5050306@rtr.ca> <4376786F.2090503@pobox.com> <43767D75.6090204@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:33286 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S964924AbVKMQNT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 13 Nov 2005 11:13:19 -0500
In-Reply-To: <43767D75.6090204@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
> 
>>
>> ata_tf_init() in include/linux/libata.h.
>>
>> I admit with guilt that I had to search around a bit for it, too :)
> 
> 
> Thanks, Jeff.
> 
> In that case, the bug with passthru is obvious:
> 
> static unsigned int
> ata_scsi_pass_thru(struct ata_queued_cmd *qc, const u8 *scsicmd)
> {
> ...
>         tf->device = scsicmd[13];    <<--- always forces ATA "master" 
> unit 0
> ...
>         tf->device = scsicmd[13];    <<--- always forces ATA "master" 
> unit 0
> ...
> 
> 
> Those lines should each do this instead:
> 
>         tf->device = qc->dev->devno ? (scsicmd[13] |  ATA_DEV1)
>                         : (scsicmd[13] & ~ATA_DEV1);
> 
> I'll see about a patch for that shortly.
> 
> Cheers
> 
> 

Please tell me when you have fixed this, so that I could try it.
Please tell me where the fix will go, git libata-dev or linux-2.6

James

