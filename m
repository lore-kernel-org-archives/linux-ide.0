From: Tejun Heo <htejun@gmail.com>
Subject: Re: Port Multiplier Patch 2.6.22.1 on Alpha
Date: Sat, 08 Sep 2007 22:53:30 +0200
Message-ID: <46E30BCA.1070705@gmail.com>
References: <46D638A3.2030704@23palmer.net> <46D64290.2010306@garzik.org> <46E22817.9080200@23palmer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:7940 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265AbXIHUzG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Sep 2007 16:55:06 -0400
Received: by wa-out-1112.google.com with SMTP id v27so992373wah
        for <linux-ide@vger.kernel.org>; Sat, 08 Sep 2007 13:55:06 -0700 (PDT)
In-Reply-To: <46E22817.9080200@23palmer.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom Evans <tom@23palmer.net>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Tom Evans wrote:
> 
> I decided to put the Norco 4618 card into the first PCI slot of my DS20.
> 
> It and the PMP support seem to like that location much better - I'm
> successfully creating an array at the moment.
> 
> The system still responds, but accessing currently running filesystems
> (another array and the local scsi boot disk) seems to "freeze" for 20-30
> seconds.

Does kernel complain anything during the freeze?

> I was able to move the graphics card to another slot (which for a period
> in the past was also limited to the first PCI slot).
> 
> Maybe this will make sense to some folks out there - thanks!

To me, not much yet.  :-(

-- 
tejun
