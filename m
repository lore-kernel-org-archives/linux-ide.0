From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] IDE: fix PCI must_checks
Date: Thu, 05 Apr 2007 22:05:54 -0700
Message-ID: <4615D532.1070704@oracle.com>
References: <20070404213704.224128ec.randy.dunlap@oracle.com>	<20070405121302.1206e748@the-village.bc.nu>	<20070405130330.f5f8a2a6.akpm@linux-foundation.org>	<20070405211609.5263d627@the-village.bc.nu> <20070405142001.6610749a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:24597 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbXDFFE6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Apr 2007 01:04:58 -0400
In-Reply-To: <20070405142001.6610749a.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, ide <linux-ide@vger.kernel.org>, bzolnier@gmail.com

Andrew Morton wrote:
> On Thu, 5 Apr 2007 21:16:09 +0100
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
>>> pci_set_mwi() is an advisory thing, and on certain platforms it might fail
>>> to set the cacheline size to the desired number.  This is not a fatal error
>>> and the driver can successfully run at a lesser performance level.
>> Correct.
>>
>>> If that description is accurate then I'd contend that pci_set_mwi() is
>>> misdesigned.  It should not be returning a negative error code for
>>> something which is not an error.
>> It is an error to *some* drivers but not all. Kind of like setting some
>> of the other features may be essential for some chips and not others.
>>
>>> And we *need* to be excessively anal in the PCI setup code.  We have metric
>>> shitloads of bugs due to problems in that area, and the more formality and
>>> error handling and error reporting we can get in there the better off we
>>> will be.
>> No argument there
>>
>> If we want to deal with some of the mess we should also remove all direct
>> writing of PCI latency timers and replace them with a function to stop
>> drivers setting unsafe values and ignoring chip errata the core knows
>> about but they dont
> 
> hm. Well, what to do?
> 
> How about we prevail upon Randy to:
> 
> - rename pci_set_mwi() to pci_try_set_mwi()
> 
> - make it return 0 on success, 1 if the "try" failed
> 
> - make it return -EFOO on error (presently unimplemented)
> 
> - review callers
> 
> - remove __must_check
> 
> ?

That's fine with me.  Any comments on that, Alan?

I'm not sure that I like the proposed return values of
pci_try_set_mwi(), but I'm easy.

> I have a feeling that this is "still wrong": even things like
> pci_read_config_foo() can get errors, and there are various PCI-bus error
> handling proposals floating about which might require that callers be more
> careful in what they accept.


-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
