From: Tejun Heo <htejun@gmail.com>
Subject: Re: [smartmontools-support] inactive SATA drives won't stay in standby
 or sleep, PATA models did. (fwd)
Date: Wed, 08 Oct 2008 09:28:11 +0900
Message-ID: <48EBFE9B.9070503@gmail.com>
References: <D73D40172004714D95D7A84AC3E68EC802282133@wdscexbe03.sc.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:25207 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755238AbYJHAaF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Oct 2008 20:30:05 -0400
Received: by ti-out-0910.google.com with SMTP id b6so2074075tic.23
        for <linux-ide@vger.kernel.org>; Tue, 07 Oct 2008 17:30:02 -0700 (PDT)
In-Reply-To: <D73D40172004714D95D7A84AC3E68EC802282133@wdscexbe03.sc.wdc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christian Mueller <Christian.Mueller@wdc.com>
Cc: Bruce Allen <ballen@gravity.phys.uwm.edu>, Smartmontools Mailing List <smartmontools-support@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Mikael Pettersson <mikpe@it.uu.se>

(cc'ing linux-ide and Mikael Pettersson)

Christian Mueller wrote:
> The messages I saw on the screen.

If the drive doesn't wake up and times out the smart command while
suspended (which probably is a bug in the firmware but it also can be
the controller's fault), then after the timeout, the driver should kick
in and reset the drive which will wake up the device and retry the
command.  It's not the prettiest picture but it's still gonna work.  In
Linda's case, it looks like the controller (sata_promise) went bonkers
on hardreset and requires power cycle to get back to working state.
That's why I asked Linda to try another controller.

Anyways, if you're seeing a similar problem, the driver or controller
probably can't do proper reset after timeout and I can't really help
with SAS driver on FreeBSD.  :-P

Mikael, the original thread is the following.

  http://article.gmane.org/gmane.linux.utilities.smartmontools/5842

Any ideas why hardreset doesn't work after SMART command timed out?

Thanks.

-- 
tejun
