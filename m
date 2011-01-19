From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream] ahci: add HFLAG_YES_FBS and apply it to 88SE9128
Date: Tue, 18 Jan 2011 20:07:37 -0500
Message-ID: <4D363959.6090203@garzik.org>
References: <4C4AFE7C.5070506@kernel.org> <4CF45BC0.2030701@iki.fi> <4CF4FCBE.2060406@kernel.org> <4CF55A4B.1020402@iki.fi> <4CFE8EE2.1060908@iki.fi> <4CFF67B6.7090805@kernel.org> <4CFFC9D0.2090803@garzik.org> <4CFFCAE3.1090106@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42880 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564Ab1ASBHm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Jan 2011 20:07:42 -0500
Received: by vws16 with SMTP id 16so133229vws.19
        for <linux-ide@vger.kernel.org>; Tue, 18 Jan 2011 17:07:41 -0800 (PST)
In-Reply-To: <4CFFCAE3.1090106@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Anssi Hannula <anssi.hannula@iki.fi>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Mark Lord <kernel@teksavvy.com>

On 12/08/2010 01:13 PM, Tejun Heo wrote:
> Hello,
>
> On 12/08/2010 07:09 PM, Jeff Garzik wrote:
>>> I'm not completely comfortable with going ahead with the patch tho.
>>> It probably is okay but it's still a shot in the dark.  Is there
>>> anyone with marvell contact?
>>
>> I have docs for most Marvell models, but not this one; and no
>> contacts...  Presumably it is some variant of their existing Marvell
>> AHCI line of chips, but beyond that, you and I are both just
>> guessing.
>
> Eh, well, in that case as it's a fix one way or the other,
>
> Acked-by: Tejun Heo<tj@kernel.org>

It's ugly, and maybe it will go away in the future.  But I don't think 
it will harm existing installations to add the additional class match, 
so I'm applying it.

	Jeff



