From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: add support for READ/WRITE LONG
Date: Mon, 12 Mar 2007 18:23:22 -0400
Message-ID: <45F5D2DA.20407@rtr.ca>
References: <3aac340703102322p362998b9labedc13503702d2b@mail.gmail.com>	<45F56800.3040104@rtr.ca>	<3aac340703121003l43685599t8dbffe6247879a91@mail.gmail.com>	<45F5A523.1080500@rtr.ca> <20070312221351.6c3db1fa@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:2283 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932932AbXCLWXZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Mar 2007 18:23:25 -0400
In-Reply-To: <20070312221351.6c3db1fa@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Vitaliyi <imgrey@gmail.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
> On Mon, 12 Mar 2007 15:08:19 -0400
> Mark Lord <liml@rtr.ca> wrote:
> 
>> The READ/WRITE LONG commands are theoretically obsolete,
>> but the majority of drives in existance still implement them.
>>
>> The WRITE_LONG and WRITE_LONG_ONCE commands are of particular
>> interest for fault injection testing -- eg. creating "media errors"
>> at specific locations on a disk.
> 
> Do you still get hangs with ata_piix if you use R/W LONG and these
> changes ?

Err.. I *never* got hangs with ata_piix and these patches.
Either that, or the Alzheimer's is getting worse.  ;)

???
