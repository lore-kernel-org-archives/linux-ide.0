From: Tejun Heo <htejun@gmail.com>
Subject: Re: Fw: 2.6.24.X: SATA/AHCI related boot delay. - not with 2.6.24.3
Date: Fri, 21 Mar 2008 18:56:10 +0900
Message-ID: <47E3863A.1010700@gmail.com>
References: <217535.99274.qm@web34505.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:40832 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443AbYCUJ4S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Mar 2008 05:56:18 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1554226wah.23
        for <linux-ide@vger.kernel.org>; Fri, 21 Mar 2008 02:56:15 -0700 (PDT)
In-Reply-To: <217535.99274.qm@web34505.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: osb972ww-linuxczmil@yahoo.com
Cc: linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello,

osb972ww-linuxczmil@yahoo.com wrote:
> setting irqpoll fixed both problems, and there are no "nasty grams"
> in dmesg now.   The original reason I was trying to use the hdparm -u
> on /dev/sda was because it was hanging for a few seconds when doing
> writes to the CFdisk, and in the past that was the kind of thing that
> hdparm -u would generally fix.

libata drivers don't need or support hdparm -u settings.

>  Now with the irqpoll kernel option,
> the /dev/sdb SATA drive was found, and I can mount it and write to
> it.  The CFcard /dev/sda is also responding to writes better than
> before.
> 
> Thanks for the suggestion to use irqpoll.    What is the problem
> within the driver(s) that is requiring irqpoll. ?

Well, IRQ 18 is taken offline during USB initialization.  The IRQ is
shared with the SATA controller, so SATA controller doesn't work either.
 It isn't clear why the IRQ handler is taken offline.  It could be the
USB controller but can also be the SATA controller.  Does not loading
usb driver make any difference?

-- 
tejun
