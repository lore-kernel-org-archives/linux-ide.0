From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: does AHCI work on intel 915 ICH6 controllers? Is it supposed
   to?
Date: Mon, 13 Jun 2005 11:52:37 +0800
Message-ID: <42AD0305.5060705@tw.ibm.com>
References: <d87q4j$d37$1@sea.gmane.org> <42A7A191.7040700@pobox.com> <d89hcm$7ej$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:3563 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261348AbVFMDxB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 12 Jun 2005 23:53:01 -0400
In-Reply-To: <d89hcm$7ej$1@sea.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sean <seandarcy2@gmail.com>
Cc: linux-ide@vger.kernel.org



sean wrote:
> Jeff Garzik wrote:
> [...........]
> 
>> Plain vanilla ICH6 does not support AHCI, but other ICH6 variants such 
>> as ICH6-R do.  If your chip does support AHCI, then your BIOS is not 
>> enabling it.
>>
>> AHCI support is clearly indicated by Region 5, a memory (MMIO) region:
>>
>>>         Region 0: I/O ports at e880 [size=8]
>>>         Region 1: I/O ports at e800 [size=4]
>>>         Region 2: I/O ports at e480 [size=8]
>>>         Region 3: I/O ports at e400 [size=4]
>>>         Region 4: I/O ports at e080 [size=32]
>>>         Region 5: Memory at feb3fc00 (32-bit, non-prefetchable) 
>>> [size=1K]
>>
>>
>>
>> Regards,
>>
>>     Jeff
>>
> 
> Thanks for the quick response. I've sent another request to gigabyte for 
> a BIOS update.  Fat chance.
> 
> sean
> 

Hi Sean,

I also have a 915G based system (AOpen EZ915) and I'm interested to try the
AHCI support. So I checked whether AHCI could be used on my 915G box.
The PCI device ID for my ICH6 is 0x2651.
=> So, no AHCI support. :(
(Only ICH6-R 0x2652 and ICH6-M 0x2653 have AHCI support. Not plain ICH6.
http://download.intel.com/design/chipsets/specupdt/30147411.pdf )

 From your previous post
"00:1f.2 IDE interface: Intel Corp. 82801FB/FW (ICH6/ICH6W) "
I guess your box is the same as mine, plain ICH6 without AHCI support.
(You can check the PCI device ID by "lspci -n".)

If so, update BIOS won't help since there is no AHCI support on the hardware.

Albert



