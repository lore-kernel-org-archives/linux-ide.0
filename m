From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes 2/2] libata: implement ATAPI_HORKAGE_NOPIO
 	and apply it to GGW-H10N
Date: Tue, 17 Nov 2009 21:14:36 -0500
Message-ID: <4B03588C.7050708@garzik.org>
References: <4857313A.1000405@kernel.org>	 <20080617094354.338e186b@lxorguk.ukuu.org.uk>	 <48578080.5030605@kernel.org> <20080617095439.GA9359@lukeross.name>	 <20080617110450.668f37e2@lxorguk.ukuu.org.uk>	 <4857ADC3.3040106@kernel.org> <20080618114828.GB19903@lukeross.name>	 <4858F894.6030409@garzik.org> <4AFDF5A8.1050005@gmail.com>	 <4AFFB8ED.9050404@kernel.org> <51f3faa70911151022g53be8a38g9252edece084e7b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33957 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756362AbZKRCOn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Nov 2009 21:14:43 -0500
In-Reply-To: <51f3faa70911151022g53be8a38g9252edece084e7b4@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Luke Ross <luke@lukeross.name>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 11/15/2009 01:22 PM, Robert Hancock wrote:
> On Sun, Nov 15, 2009 at 2:16 AM, Tejun Heo<tj@kernel.org>  wrote:
>> Hello,
>>
>> 11/14/2009 09:11 AM, Robert Hancock wrote:
>>> Luke/Tejun, do you have some error output from those wodim or growisofs
>>> errors? It would be useful to know what commands those were that failed
>>> and whether they were also an unusual data size.
>>
>> I don't have anything.  For some reason, ahci works fine on the setups
>> here.  :-(
>>
>> I'm waiting for Dan's further report.  I still am not sure whether
>> we're actually seeing a lot of ahci ATAPI failures or it's just that a
>> lot of reports are on ahci because it's the most often used driver
>> now.  I don't think anything fundamental is broken.  The reports are
>> too infrequent for that to be true.  It might have something to do
>> with the buffer padding / draining we do or how the controller and
>> driver react.
>
>> From the bug 10091 it looks like the failing command was a MODE SELECT
> with data transfer length of 66 bytes which is definitely odd..
>
> My suspicion is that we're either padding out the data buffer and the
> indicated PRD length to a longer length than the drive actually wants
> to transfer, and the controller isn't happy with that, OR maybe
> vice-versa (i.e. we don't pad out the length and it wants us to). It's
> not clear if this and Jeff's issue are actually the same thing as the
> response is fairly different (interface fatal error and SError
> indications on the NV vs. a timeout on whatever chipset Jeff's using),
> but that may just be a chipset difference.
>
> If Jeff has a repeatable test case then that's likely the most
> promising place to start poking at things..

Nope, I replied to that original thread, well after the fact, noting my 
hardware likely flaky.  Unable to reproduce the problem anymore, 
unfortunately.

	Jeff




