From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: add support for READ/WRITE LONG
Date: Fri, 16 Mar 2007 17:21:18 -0400
Message-ID: <45FB0A4E.40904@rtr.ca>
References: <3aac340703102322p362998b9labedc13503702d2b@mail.gmail.com> <45FAE7F3.7050201@pobox.com> <45FAFB24.2050800@rtr.ca> <200703162209.13411.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ottawa-hs-64-26-128-89.s-ip.magma.ca ([64.26.128.89]:2432 "EHLO
	mail.rtr.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965956AbXCPVVU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Mar 2007 17:21:20 -0400
In-Reply-To: <200703162209.13411.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Vitaliyi <imgrey@gmail.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Mikael Pettersson <mikpe@it.uu.se>

Bartlomiej Zolnierkiewicz wrote:
> On Friday 16 March 2007, Mark Lord wrote:
..
>> I've tested ATA1 and newer PATA drives, and various SATA drives
>> with these commands without bothering to drop to PIO0,
>> and none of them had issues.
> 
> This is what really matters wrt libata READ/WRITE LONG support.
> 
> These commands are not supposed to be used by normal users anyway
> so patch while not being "perfect" is "good enough" to be merged IMO.

Heh.. I have a similar patch for IDE as well,
but not up-to-date for the latest kernels.

Cheers
