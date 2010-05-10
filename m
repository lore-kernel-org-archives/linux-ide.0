From: Graeme Russ <graeme.russ@gmail.com>
Subject: Re: [PATCH] Add hook for custom xfer function in PATA Platform driver
Date: Mon, 10 May 2010 10:10:22 +1000
Message-ID: <4BE74EEE.5060307@gmail.com>
References: <1273382493-5859-1-git-send-email-graeme.russ@gmail.com> <4BE6910D.9070504@ru.mvista.com> <4BE69C81.2070703@gmail.com> <4BE6BA74.10200@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f217.google.com ([209.85.217.217]:43142 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab0EJAK3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 May 2010 20:10:29 -0400
Received: by gxk9 with SMTP id 9so2341437gxk.8
        for <linux-ide@vger.kernel.org>; Sun, 09 May 2010 17:10:28 -0700 (PDT)
In-Reply-To: <4BE6BA74.10200@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-ide@vger.kernel.org

Sergei Shtylyov wrote:
> Hello.
> 
> Graeme Russ wrote:
> 
>> [Added linux-ide back onto distribution list]
>>   
> 
>   Right, I didn't intend to exclude it -- probably didn't press all the
> keys at once for the reply-to-all function.
> 
> [...]
>>
>>>   You should have also taught the symmetric ide-platfrom driver the same
>>> trick. However, IDE core's data transfer methods has a different
>>> prototype.
>>>     
>>
>> I did think about the other drivers (OF Platform etc) but I have no
>> way of
>> testing them.
>>   
> 
>   pata_of_platform is not easily extensible in this way. It gets all the
> information about the device from the device tree -- and you can't
> encode all your complications there, unless you invent a new OF device.
> 
>>> I suggest to rather add a new flag, indicating 8-bit data I/O, and have
>>> the alternate sff_data_xfer() method defined inside the driver.

The vast majority of implementations are 16-bit (no one has complained
about the lack of 8-bit support to date). I don't think the majority of
users should be carrying around the extra code for a tiny minority. Yes, it
could be wrapped around an #ifdef but then things start to get ugly (why
not just ditch the flag and #ifdef the 8-bit transfers entirely, hack
Kconfig etc) eeewwwww....

>> other devices on the bus). By overriding the data transfer function I can
>> arbitrate access to the bus and switch the bus timings based on the
>> peripheral being accessed. This cannot be done be a generic data transfer
>> function.
>>   
> 
>   I disagree with your approach of overriding the libata methods at the
> board level, so I suggest to write a new driver. This is too complicated
> stuff for poor old pata_platform. :-)

My custom function to date looks like:

unsigned int ata_enet_data_xfer(struct ata_device *dev, unsigned char *buf,
			       unsigned int buflen, int rw)
{
	struct ata_port *ap = dev->link->ap;
	void __iomem *data_addr = ap->ioaddr.data_addr;

	set_gp_bus_slow();
	/* Transfer bytes */
	if (rw == READ)
		ioread8_rep(data_addr, buf, buflen);
	else
		iowrite8_rep(data_addr, buf, buflen);

	set_gp_bus_fast();
	return buflen;
}

set_gp_bus_slow() and set_gp_bus_fast() (at the moment) simply set a few
config registers to set the GP bus timing (no arbitration yet, but these
functions will also handle that using a mutex). I don't see the point in
re-writing the entire PATA Platform driver when the existing driver appears
to be perfectly capable with a very minor extension hook.

Regards,

Graeme

