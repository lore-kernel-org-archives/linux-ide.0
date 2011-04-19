From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 0/2] fix libata-sff and pata_cmd64x to not crash on boot
 on parisc
Date: Wed, 20 Apr 2011 00:59:04 +0400
Message-ID: <4DADF798.6010705@ru.mvista.com>
References: <1303152147.7167.12.camel@mulgrave.site>	<20110418205203.56bbdb14@lxorguk.ukuu.org.uk>	<1303159802.7167.30.camel@mulgrave.site> <20110418222017.4e77fe05@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <20110418222017.4e77fe05@lxorguk.ukuu.org.uk>
Sender: linux-parisc-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, linux-ide <linux-ide@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hello.

On 19-04-2011 1:20, Alan Cox wrote:

>> +	}
>> +	if (!(reg&  ENPORT_SECONDARY)) {
>> +		dev_printk(KERN_NOTICE,&pdev->dev, "Secondary port is disabled\n");
>> +		ppi[1] =&ata_dummy_port_info;
>> +	}

> And you just broke split bridge setups. Also need to check if the bits
> are valid for this chipset in native mode officialy - Sergei probably
> knows the answer to that.

    The PCI-649 spec. doesn't say anything about legacy/native mode WRT the 
channel enable bits.

> We can detect the Mobility electronics split bridges at least (and I
> suspect they are the only 'common' CMD64x hot plug device indeed possibly
> the only one) because the parent bridge of the CMD64x will have a PCI
> vendor id of 0x14f2 and a device id 0x0001, 0x0002, or 0x0120.

    What's the issue with these brodges anyway? Why the enable bits are not 
valid for them?

WBR, Sergei
