From: Tejun Heo <htejun@gmail.com>
Subject: Re: JMicron - hard resetting link
Date: Fri, 15 Feb 2008 08:32:01 +0900
Message-ID: <47B4CF71.5070408@gmail.com>
References: <009401c86d5c$5eb57bf0$4d0fa8c0@M2007> <47B19997.1010404@gmail.com> <003801c86d84$fdae0510$4d0fa8c0@M2007> <47B1B299.3010208@gmail.com> <002f01c86d9c$94542f50$4d0fa8c0@M2007> <47B230CA.9060506@gmail.com> <005c01c86f5d$b050b4e0$4d0fa8c0@M2007>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:20305 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765604AbYBNXcL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 18:32:11 -0500
Received: by wa-out-1112.google.com with SMTP id v27so846212wah.23
        for <linux-ide@vger.kernel.org>; Thu, 14 Feb 2008 15:32:08 -0800 (PST)
In-Reply-To: <005c01c86f5d$b050b4e0$4d0fa8c0@M2007>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gabor FUNK <FUNK.Gabor@hunetkft.hu>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Gabor FUNK wrote:
> To be honest, I didn't believe that doing anything with the PSU
> would do something.
> However, seemingly it did.
> I have also updated the BIOS, but I guess this has not much
> to do with it.

I too am amazed at the number of PSU problems getting reported here.  It
seems most hardware problems turn out to be power related.

> So a different brand PSU was additionally installed, and this
> one got the motherboard and the 4 disk which were failing.
> The "old" PSU got the second 4 hdds and the 2 other system
> HDDs.
> Test was started yesterday (Feb 13) about 16:30 CET including
> array building up and file copies. About today (14) 20:22 the
> problem appeared, but seemingly "moved" with the PSU to the
> other 4 disks bunch (on nvidia controller) - more precisely, only
> 2 of them (array is still operational).

Hmmm..

> So it seems that there is definitely something with the "old" PSU.
> 
> Also, I tried to mount the failed drives, without success.
> 
> Thought I let you know.
> Now I will try with the only one, "new" PSU to see what happens...

Yeah, please keep us posted.  Thanks.

-- 
tejun
