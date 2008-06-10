From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.25: sata_sil freezes, hard resets port.
Date: Tue, 10 Jun 2008 12:18:58 +0900
Message-ID: <484DF2A2.103@gmail.com>
References: <4846F3EA.2050408@bredband.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:63372 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585AbYFJDTF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jun 2008 23:19:05 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2392836wfd.4
        for <linux-ide@vger.kernel.org>; Mon, 09 Jun 2008 20:19:04 -0700 (PDT)
In-Reply-To: <4846F3EA.2050408@bredband.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Henry <adhenry@bredband.net>
Cc: linux-ide@vger.kernel.org

Andrew Henry wrote:
> Any news with this?  I start to understand that this really is a missing
> function in the sata_sil driver: driver does not work well with power
> saving modes/standby on eSATA drives.
> 
> I have created a cron script to 'ping' the drives usng sdparm -C start
> /dev/sdX every 3 minutes and the drives have been operating with RAID1
> and dmcrypt for 4 days non-stop without error.
> 
> It does seem that this fault I am experiencing is only caused by
> incomplete driver.  Can someone please acknowledge this?

It looks like bad interaction with link power saving to me.  libata
currently inhibits all link power saving and doesn't configure device
side power saving either, so the link should never enter powersaving
mode but some "green" drives are known to take extreme measures to cut
down on power.  At any rate, the drive and link should wake up when the
controller strobes the link w/ PHY reset no matter in which PS mode it's
in.  I can't think of any good solution at the moment.  Can you please
post the outputs of dmesg after the wake up failure (fdisk -l) and
"hdparm --Istdout /dev/sdX"?

-- 
tejun
