From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 7/9] libata-acpi: improve _GTF execution error handling
 and reporting
Date: Fri, 14 Dec 2007 09:54:59 -0500
Message-ID: <47629943.2010408@rtr.ca>
References: <11976129411285-git-send-email-htejun@gmail.com> <11976129433239-git-send-email-htejun@gmail.com> <47628F3A.1060806@rtr.ca> <47629004.4040701@gmail.com> <47629720.4010602@rtr.ca> <4762982F.2060701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2569 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752812AbXLNOzA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 Dec 2007 09:55:00 -0500
In-Reply-To: <4762982F.2060701@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, hancockr@shaw.ca, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Mark Lord wrote:
>> Tejun Heo wrote:
>>> Mark Lord wrote:
>>>> Tejun Heo wrote:
>>>>> As _GTF commands can't transfer data, device error never signals
>>>>> transfer error.  It indicates that the device vetoed the operation, so
>>>>> it's meaningless to retry.
>>>> ..
>>>>
>>>> The SECURITY commands may pass a data block to the drive,
>>>> containing the password required to unlock/freeze a drive.
>>>> I suspect ACPI on many machines will issue such a command,
>>>> and it does indeed transfer data (512 bytes).
>>> Surprise, ACPI _GTF can't do that.  Don't ask me why.  :-)
>> ..
>>
>> Then why are we (going to be) filtering those op's (one of your patches) ?
> 
> Filtered ones are not LOCK / FREEZE LOCK commands which prevent further
> changes.  e.g. SET MAX FREEZE LOCK will prevent further size changes
> using SET MAX [EXT].  It's bad for three reasons 1. it locks down drive
> feature without user consent (e.g. can't unlock HPA) 2. it makes
> debugging difficult by putting drives into different states 3. it just
> doesn't serve any good.
..

Okay-dokey.  I think I mis-read which FREEZE command was in the patch.

Cheers!

