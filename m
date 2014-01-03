From: Felix Miata <mrmazda@earthlink.net>
Subject: Re: HD filesystem integrity issues
Date: Thu, 02 Jan 2014 22:34:50 -0500
Message-ID: <52C62FDA.8080904@earthlink.net>
References: <52C49A1C.1000104@earthlink.net> <52C628C7.6040407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from elasmtp-galgo.atl.sa.earthlink.net ([209.86.89.61]:44805 "EHLO
	elasmtp-galgo.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753109AbaACDfG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Jan 2014 22:35:06 -0500
Received: from [24.144.107.66] (helo=[192.168.0.11])
	by elasmtp-galgo.atl.sa.earthlink.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.67)
	(envelope-from <mrmazda@earthlink.net>)
	id 1VyvX9-0001d4-MR
	for linux-ide@vger.kernel.org; Thu, 02 Jan 2014 22:34:51 -0500
In-Reply-To: <52C628C7.6040407@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On 2014-01-02 21:04 (GMT-0600) Robert Hancock composed:

> Felix Miata wrote:

>> http://fm.no-ip.com/Tmp/Linux/dmsgAZBHD201401.txt is dmesg from a STB

> Have you checked the dmesg output? There would likely be some indication
> of what happened.

Checked for what exactly? That's why I gave it to the list to look at. The 
only thing I recognized as a problem indication was "running e2fsck is 
recommended".

> Given that this thing only has 100MB or so of memory,
> it seems quite likely that the out-of-memory killer kicked in.

As another responder replied within minutes of my post, and you seem to have 
confirmed. It's what I suspected, but I was able to find any way to confirm 
other than to ask somewhere outside the device's so-called support forum.

> This isn't really related to linux-ide, the main Linux kernel mailing
> list would likely be more suitable.

I was thinking a generic filesystem list, but don't know of one about 
ext2/3/4, and thought this better than a high traffic generic list.
-- 
"The wise are known for their understanding, and pleasant
words are persuasive." Proverbs 16:21 (New Living Translation)

  Team OS/2 ** Reg. Linux User #211409 ** a11y rocks!

Felix Miata  ***  http://fm.no-ip.com/
