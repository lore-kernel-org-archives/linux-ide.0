From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream] ahci: add HFLAG_YES_FBS and apply it to 88SE9128
Date: Wed, 08 Dec 2010 13:09:20 -0500
Message-ID: <4CFFC9D0.2090803@garzik.org>
References: <4C4AFE7C.5070506@kernel.org> <4CF45BC0.2030701@iki.fi> <4CF4FCBE.2060406@kernel.org> <4CF55A4B.1020402@iki.fi> <4CFE8EE2.1060908@iki.fi> <4CFF67B6.7090805@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46501 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755801Ab0LHSJ0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2010 13:09:26 -0500
Received: by vws16 with SMTP id 16so1261976vws.19
        for <linux-ide@vger.kernel.org>; Wed, 08 Dec 2010 10:09:25 -0800 (PST)
In-Reply-To: <4CFF67B6.7090805@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Anssi Hannula <anssi.hannula@iki.fi>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Mark Lord <kernel@teksavvy.com>

On 12/08/2010 06:10 AM, Tejun Heo wrote:
> Hello,
>
> On 12/07/2010 08:45 PM, Anssi Hannula wrote:
>>>>> Attached is a patch to make the id entry class-specific. The patch is
>>>>> untested (the issue happens in a production machine).
>>>>
>>>> Thanks a lot for the patch.  It looks correct but it would be great if
>>>> it can be veified.
>>>
>>> I think I can do that later, but probably not this week or so.
>>
>> I've now verified that the patch works on a system with 1b4b:9123
>> controller.
>
> Thanks for verifying.  Can you please post the kernel log?  Also, do
> all ports seem to work?
>
>>>> Also, there's a pending patch to add another PCI
>>>> ID for similar marvell controller.  I wonder whether similar
>>>> workaround should be applied.  Hmmm... ISTR the other one reporting
>>>> IDE class even though it works in IDE mode.
>>>
>>> IDE class in IDE mode? Isn't that kind of expected? :)
>
> Oh, the latter should have been ahci.
>
> I'm not completely comfortable with going ahead with the patch tho.
> It probably is okay but it's still a shot in the dark.  Is there
> anyone with marvell contact?

I have docs for most Marvell models, but not this one; and no 
contacts...  Presumably it is some variant of their existing Marvell 
AHCI line of chips, but beyond that, you and I are both just guessing.

	Jeff



