From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/3] ide: add at91_ide driver
Date: Fri, 06 Feb 2009 13:36:44 +0300
Message-ID: <498C12BC.9080200@ru.mvista.com>
References: <200902031147.22827.stf_xl@wp.pl> <498987E6.7040909@ru.mvista.com> <200902061030.11427.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:16033 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751776AbZBFKgs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 6 Feb 2009 05:36:48 -0500
In-Reply-To: <200902061030.11427.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.arm.linux.org.uk

Hello.

Stanislaw Gruszka wrote:

>>> +	host->ports[0]->extra_base = board->chipselect;
>>>   
>>>       
>>    BTW, we have 2 fields in the struct hwif_s that fit this case better: 
>> config_data and select_data. It's a bit stange that you've selected 
>> extra_base...
>>     
> config_data is in use by IDE core,

   Hm, it shouldn't be. These fields are exclusively for drivers' use.

MBR, Sergei


