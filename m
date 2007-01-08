From: Tejun Heo <htejun@gmail.com>
Subject: Re: Norco DS-1220 (sil3726+sil3124) / libata-tj bug report
Date: Mon, 08 Jan 2007 11:33:40 +0900
Message-ID: <45A1AD84.5060202@gmail.com>
References: <Pine.LNX.4.58.0701050332200.26166@mailx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.230]:37277 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030457AbXAHCdr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Jan 2007 21:33:47 -0500
Received: by wx-out-0506.google.com with SMTP id h27so7878725wxd
        for <linux-ide@vger.kernel.org>; Sun, 07 Jan 2007 18:33:46 -0800 (PST)
In-Reply-To: <Pine.LNX.4.58.0701050332200.26166@mailx>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brad Fitzpatrick <brad@danga.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Brad Fitzpatrick wrote:
> Tejun,
> 
> (I wanted to send this to linux-ide, but vger's majordomo isn't replying
> to me.  Feel free to cc: the list...)

Just cc'ing linux-ide@vger.kernel.org is enough.  (done)

> Disks in DS-1220 show up, kinda, but don't work.  Errors reading /
> writing blocks.  Tried a single disk in both a PMP port and a direct
> (non-sil3726) port.

>From full dmesg...

The following is when the drive is attached via PMP.

18:29:55 ata3.01: (irq_stat 0x00020002, device error via D2H FIS)
18:29:55 ata3.01: tag 0 cmd 0xc8 Emask 0x1 stat 0x50 err 0x0 (device error)

And directly.

19:30:23 ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
19:30:23 ata6.00: (irq_stat 0x00060002, device error via D2H FIS)
19:30:23 ata6.00: tag 0 cmd 0xc4 Emask 0x1 stat 0x50 err 0x0 (device error)
19:30:23 ata6: EH complete

Looks like a dead drive to me.  Care to post the result of 'smartctl -d
ata -a /dev/sdX' and test other drives?

-- 
tejun
