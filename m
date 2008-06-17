From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes 2/2] libata: implement ATAPI_HORKAGE_NOPIO
 and apply it to GGW-H10N
Date: Tue, 17 Jun 2008 18:31:10 +0900
Message-ID: <4857845E.2060504@kernel.org>
References: <4857313A.1000405@kernel.org>	<48573174.9050103@kernel.org> <20080617094354.338e186b@lxorguk.ukuu.org.uk> <48578080.5030605@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43729 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756055AbYFQJb3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Jun 2008 05:31:29 -0400
In-Reply-To: <48578080.5030605@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, luke@lukeross.name

Tejun Heo wrote:
> Alan Cox wrote:
>> On Tue, 17 Jun 2008 12:37:24 +0900
>> Tejun Heo <tj@kernel.org> wrote:
>>
>>> LG blueray drive GGW-H10N can't do ATAPI PIO.  Implement
>>> ATAPI_HORKAGE_NOPIO and apply it to the drive.  If the horkage is
>>> active, atapi_check_dma() always returns 0 and warns if the controller
>>> needs ATAPI PIO for certain commands.
>> This all seems wildly improbable as a drive with such a bug would not
>> appear to be going to work in Windows. I'd like to know more and see more
>> than one bug report for that drive before it goes in
>>
>> You might even be looking at a single drive with a one off wiring flaw or
>> chip fault at this point.
> 
> I thought it was improbable too but it's a brand new relatively cheap
> blueray writer so it's quite possible that they screwed up the firmware
> on this one as are often the cases for first gen devices.
> 
> Relatively cheap it may be, it's still around $300, so I don't think
> I'll get one for testing.  The high price could probably explain low
> error report rate.

Ah.. one more thing to note.  The drive doesn't choke on all PIO
commands, so it's quite possible that windows just luckily dodged bullet
and we're taking the fall instead && the reporter says that the
controller worked fine with a dvd writer.

Is there anyone who is willing to shell out $300 in the name of penguin?

-- 
tejun
