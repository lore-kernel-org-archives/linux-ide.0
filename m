From: Tejun Heo <htejun@gmail.com>
Subject: Re: [smartmontools-support] inactive SATA drives won't stay in standby
 or sleep, PATA models did. (fwd)
Date: Mon, 13 Oct 2008 14:16:24 +0900
Message-ID: <48F2D9A8.1030502@gmail.com>
References: <D73D40172004714D95D7A84AC3E68EC802282133@wdscexbe03.sc.wdc.com>	<48EBFE9B.9070503@gmail.com> <18674.4081.839329.116533@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.191]:19066 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbYJMFSX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Oct 2008 01:18:23 -0400
Received: by ti-out-0910.google.com with SMTP id b6so777943tic.23
        for <linux-ide@vger.kernel.org>; Sun, 12 Oct 2008 22:18:19 -0700 (PDT)
In-Reply-To: <18674.4081.839329.116533@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Christian Mueller <Christian.Mueller@wdc.com>, Bruce Allen <ballen@gravity.phys.uwm.edu>, Smartmontools Mailing List <smartmontools-support@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mikael Pettersson wrote:
> - smartctl -n standby waking Linda's disks from standby is probably
>   a disk firmware issue or a smartctl issue. I see no evidence that
>   sata_promise is to blame for that.

/me agrees.  I think it's most likely a problem in the firmware.

> - hardreset in sata_promise seems broken. I'll take a closer look
>   at that in about a week's time (I'll be busy with other work the
>   next couple of days).

This looks like a rather serious problem, so please take a look at
this.  Also, after the drive went down, does unplugging and replugging
the signal cable fix the problem, if not does doing the same thing
with the power cable make any difference?

Thanks.

-- 
tejun
