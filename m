From: Mark Lord <liml@rtr.ca>
Subject: Re: hdparm-9.17 released, with experimental trim/wiper scripts for
 SSDs
Date: Thu, 30 Jul 2009 15:15:31 -0400
Message-ID: <4A71F153.8050807@rtr.ca>
References: <4A70DCB8.9000909@rtr.ca> <4A70DDC5.3000607@rtr.ca> <4A7149C6.4030508@gmail.com> <4A719820.20900@rtr.ca> <4A71E623.7030205@gmail.com> <4A71E9B6.1050504@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:45119 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750786AbZG3TPc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Jul 2009 15:15:32 -0400
In-Reply-To: <4A71E9B6.1050504@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>

Mark Lord wrote:
>
>> @@ -846,6 +846,17 @@ static void sil24_qc_prep(struct ata_queued_cmd *qc)
>>      if (!ata_is_atapi(qc->tf.protocol)) {
> ..
> 
> Mmm.. that test is failing.  I'll see if I can find where
> those bits should be getting set.
..

Pilot error.  Rebuilding the kernel again now.  :)

Thanks!
