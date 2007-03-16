From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] libata: add support for READ/WRITE LONG
Date: Fri, 16 Mar 2007 22:40:36 +0100
Message-ID: <200703162240.36687.bzolnier@gmail.com>
References: <3aac340703102322p362998b9labedc13503702d2b@mail.gmail.com> <200703162209.13411.bzolnier@gmail.com> <45FB0A4E.40904@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:11261 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbXCPVdU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Mar 2007 17:33:20 -0400
Received: by ug-out-1314.google.com with SMTP id 44so809270uga
        for <linux-ide@vger.kernel.org>; Fri, 16 Mar 2007 14:33:18 -0700 (PDT)
In-Reply-To: <45FB0A4E.40904@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Vitaliyi <imgrey@gmail.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Mikael Pettersson <mikpe@it.uu.se>


On Friday 16 March 2007, Mark Lord wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > On Friday 16 March 2007, Mark Lord wrote:
> ..
> >> I've tested ATA1 and newer PATA drives, and various SATA drives
> >> with these commands without bothering to drop to PIO0,
> >> and none of them had issues.
> > 
> > This is what really matters wrt libata READ/WRITE LONG support.
> > 
> > These commands are not supposed to be used by normal users anyway
> > so patch while not being "perfect" is "good enough" to be merged IMO.
> 
> Heh.. I have a similar patch for IDE as well,

Please send it out, I will happily apply it.

> but not up-to-date for the latest kernels.

The most changes recently have been in host drivers so probably
the patch should apply/work fine (or require minimal fixups)...

Thanks,
Bart
