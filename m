From: Mark Lord <liml@rtr.ca>
Subject: Re: hdparm-9.17 released, with experimental trim/wiper scripts for
 SSDs
Date: Thu, 30 Jul 2009 14:43:02 -0400
Message-ID: <4A71E9B6.1050504@rtr.ca>
References: <4A70DCB8.9000909@rtr.ca> <4A70DDC5.3000607@rtr.ca> <4A7149C6.4030508@gmail.com> <4A719820.20900@rtr.ca> <4A71E623.7030205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:42693 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751387AbZG3SnD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Jul 2009 14:43:03 -0400
In-Reply-To: <4A71E623.7030205@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>

Robert Hancock wrote:
> On 07/30/2009 06:54 AM, Mark Lord wrote:
>>> Yeah, according to the datasheet "The SiI3124 will decode the 8-bit ATA
>>> command at PRB offset 0x0a and automatically execute the default
>>> protocol for the command. In certain cases it might be desirable to
>>> specify a non-default protocol to be used, such as with vendor
>>> specific device commands." The DSM command seems to be DMA data-out
>>> and the chip likely doesn't know that command. I have to wonder why
>>> they decided to use that design instead of just making the driver
>>> indicate the protocol explicitly. In any case, it looks like the
>>> driver needs code to override the protocol setting for this command.
>>> (Maybe we should just set the protocol override for what we know the
>>> command is supposed to be in all cases?)
>> ..
>>
>> If you can puzzle out how to do that, and post a quick(?) patch,
>> it would certainly make testing SSDs easier for me here.
>>
>> I would like to use the Sil3124 ExpressCard controller with my notebook
>> for this stuff, rather than having to power up one of the noisy
>> full-size systems under the table.  ;)
> 
> You can try this patch (totally untested) which basically just bludgeons it
> into doing what we want for all non-packet commands:
> 
> diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
> index 77aa8d7..e6946fc 100644
> --- a/drivers/ata/sata_sil24.c
> +++ b/drivers/ata/sata_sil24.c
> @@ -846,6 +846,17 @@ static void sil24_qc_prep(struct ata_queued_cmd *qc)
>  	if (!ata_is_atapi(qc->tf.protocol)) {
..

Mmm.. that test is failing.  I'll see if I can find where
those bits should be getting set.

Also, the driver now never recovers from a failed TRIM.
It just sits there retrying it over and over and over and over,
even after I unplug the drive, or unplug the controller.
But that might be old behaviour.  :)

Cheers
