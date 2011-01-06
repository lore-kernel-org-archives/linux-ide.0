From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Is there a reliable way to ID a SSD?
Date: Thu, 06 Jan 2011 13:55:30 -0500
Message-ID: <4D261022.3030902@garzik.org>
References: <AANLkTimRUqg4cJzV1O1-Cf+KsX6sRjYrz48Ty1-qMX-c@mail.gmail.com> <4D2223BF.8090901@canonical.com> <AANLkTinbFHFv-x6VWxAmuCn0o8BSzvUmXoeTv1XGq7A+@mail.gmail.com> <4D2247A3.2060506@canonical.com> <4D25E96D.10400@computer.org> <AANLkTin1ZjPmbk1M=9-SGStU7zLUozwxX7Ddtu53xNE2@mail.gmail.com> <AANLkTim=AxrJybApL-5oG7+i08tkKofk0eyP+3XhjhBJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:40214 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129Ab1AFSzf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jan 2011 13:55:35 -0500
Received: by qyk12 with SMTP id 12so18877762qyk.19
        for <linux-ide@vger.kernel.org>; Thu, 06 Jan 2011 10:55:34 -0800 (PST)
In-Reply-To: <AANLkTim=AxrJybApL-5oG7+i08tkKofk0eyP+3XhjhBJ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Jan Ceuleers <jan.ceuleers@computer.org>, "Peter M. Petrakis" <peter.petrakis@canonical.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>

On 01/06/2011 01:40 PM, Greg Freemyer wrote:
> (resend, sorry for the duplicate)
>
> Jeff,
>
> As the maintainer, can you provide direction as to how quirks should
> be maintained for the rotating disk flag (as reflected in
> /sys/block/sda/queue/rotational).
>
> There is Bart's patch, Peter's patch, and Martin says it can be
> overridden from userspace (I'm not sure which tool,  nor do I know if
> there is already a userspace quirks table to add to.).
>
> Bart's atang PATCH: http://marc.info/?l=linux-ide&m=126677421807814&w=2
>
> Peter's patch: http://www.spinics.net/lists/linux-ide/msg38944.html

There are a long list of non-rotational devices that were produced 
before the ATA standard grew a standard method of reporting that device 
attribute.

That implies any approach individually listing products will create a 
very, very long horkage list containing all ATA flash drives that anyone 
ever produced.

Alternately, scanning for the "SSD" string does not seem very useful, 
because it will only match a tiny minority of first-run products that 
(a) call themselves "SSD" in marketing literature but (b) do not 
indicate proper rotational attributes in the IDENTIFY page.  Because 
while non-rotational products have been around for a very long time, 
"SSDs" as they are a currently known are new.

It seems like a project to retroactively identify ATA non-rotational 
products will be long and on-going, and would be better suited to a 
userspace package such as Tejun's storage-fixup: 
http://git.kernel.org/?p=linux/kernel/git/tj/storage-fixup.git

	Jeff



