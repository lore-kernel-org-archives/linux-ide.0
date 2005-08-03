From: Matthias Schniedermeyer <ms@citd.de>
Subject: Re: ahci, SActive flag, and the HD activity LED
Date: Wed, 03 Aug 2005 21:21:23 +0200
Message-ID: <42F11933.7050607@citd.de>
References: <42EF93F8.8050601@fujitsu-siemens.com> <20050802163519.GB3710@suse.de> <42F05359.7030006@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dsw2k3.info ([195.71.86.227]:16328 "EHLO dsw2k3.info")
	by vger.kernel.org with ESMTP id S262440AbVHCTVb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Aug 2005 15:21:31 -0400
In-Reply-To: <42F05359.7030006@fujitsu-siemens.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org

Martin Wilck wrote:
> Jens Axboe wrote:
> 
>>> If I am reading the specs correctly, that'd mean the ahci driver is 
>>> wrong in setting the SActive bit.
>>
>>
>> I completely agree, that was my reading of the spec as well and hence my
>> original posts about this in the NCQ thread.
> 
> Have you (or has anybody else) also seen the wrong behavior of the 
> activity LED?

925X-Chipset
Lspci says: 8086:2652
Intel Corp. 82801FR/FRW (ICH6R/ICH6RW) SATA Controller (rev 03)
HDD:
Western Digital WD2000JD-00H, i believe this HDD is non-NCQ.

Kernels: 2.6.10 - 2.6.12
The Activity-LED has burned like a light-bulb every since i have that 
computer. (Excluding the few seconds before booting Linux. :-) )



Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated,
cryptic, powerful, unforgiving, dangerous.

