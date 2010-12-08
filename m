From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream] ahci: add HFLAG_YES_FBS and apply it to 88SE9128
Date: Wed, 08 Dec 2010 12:10:46 +0100
Message-ID: <4CFF67B6.7090805@kernel.org>
References: <4C4AFE7C.5070506@kernel.org> <4CF45BC0.2030701@iki.fi> <4CF4FCBE.2060406@kernel.org> <4CF55A4B.1020402@iki.fi> <4CFE8EE2.1060908@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34237 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753625Ab0LHLKr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Dec 2010 06:10:47 -0500
In-Reply-To: <4CFE8EE2.1060908@iki.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Mark Lord <kernel@teksavvy.com>

Hello,

On 12/07/2010 08:45 PM, Anssi Hannula wrote:
>>>> Attached is a patch to make the id entry class-specific. The patch is
>>>> untested (the issue happens in a production machine).
>>>
>>> Thanks a lot for the patch.  It looks correct but it would be great if
>>> it can be veified.
>>
>> I think I can do that later, but probably not this week or so.
> 
> I've now verified that the patch works on a system with 1b4b:9123
> controller.

Thanks for verifying.  Can you please post the kernel log?  Also, do
all ports seem to work?

>>> Also, there's a pending patch to add another PCI
>>> ID for similar marvell controller.  I wonder whether similar
>>> workaround should be applied.  Hmmm... ISTR the other one reporting
>>> IDE class even though it works in IDE mode.
>>
>> IDE class in IDE mode? Isn't that kind of expected? :)

Oh, the latter should have been ahci.

I'm not completely comfortable with going ahead with the patch tho.
It probably is okay but it's still a shot in the dark.  Is there
anyone with marvell contact?

Thanks.

-- 
tejun
