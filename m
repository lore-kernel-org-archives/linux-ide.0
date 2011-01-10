From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v2] pata_hpt37x: coding style cleanup
Date: Mon, 10 Jan 2011 18:45:34 +0300
Message-ID: <4D2B299E.9000809@ru.mvista.com>
References: <201101081901.37479.sshtylyov@ru.mvista.com> <4D28C965.8070008@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48214 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266Ab1AJPq6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Jan 2011 10:46:58 -0500
Received: by eye27 with SMTP id 27so8596495eye.19
        for <linux-ide@vger.kernel.org>; Mon, 10 Jan 2011 07:46:56 -0800 (PST)
In-Reply-To: <4D28C965.8070008@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Hello.

Jeff Garzik wrote:

>> Changes from the previous version:
>> - fixed several cases of a line over 80 chars that checkpatch.pl 
>> didn't report.

> And for pata_hpt366 you also wrote:

>> Changes from the previous version:
>> - fixed one case of a line over 80 chars that checkpatch.pl didn't 
>> report.

    Looks like checkpatch.pl now doesn't report the lines with printk() messages 
as being too long, thanks to the previous discussions on the topic. Though those 
could be made shorter without breaking the messages in this case anyway...

> These will need to be on top of your patches applied last night (and 
> just sent to Linus).

   I think I will join these changes to the 2 patches that I've generated on 
Saturday. Looks like the idea of creating v2 of the coding style clean-up 
patches wasn't really good as those extra long lines would have been truncated 
by that 2-patch series anyway...

> FWIW, it is ok to combine such changes into a single patch.  You don't 
> have to separate our pata_hpt37x and pata_hpt366 coding style cleanups. 
>  The main goal with separate patches is separating classes of changes, 
> so that human reviewers and 'git bisect' may notice breakage at a 
> useful, fine-grained level.  Separating patches at the driver boundary 
> is less useful from that perspective (though permissible, if that is 
> your preferred method of working).

    I've preferred to give the exact error/warning statistics and the list of 
changes for each driver in this case.

>     Jeff

WBR, Sergei
