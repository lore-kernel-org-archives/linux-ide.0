From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.24-rc1, sata_sil: access to SH-S183A broken again?
Date: Mon, 29 Oct 2007 11:54:31 +0900
Message-ID: <47254B67.2050301@gmail.com>
References: <4724845D.4020903@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:38671 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbXJ2Cyp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Oct 2007 22:54:45 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1431128rvb
        for <linux-ide@vger.kernel.org>; Sun, 28 Oct 2007 19:54:44 -0700 (PDT)
In-Reply-To: <4724845D.4020903@t-online.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harri <harald.dunkel@t-online.de>
Cc: linux-ide@vger.kernel.org

Harri wrote:
> Hi Tejun,
> 
> Is it possible that the DMA workaround for sata_sil and the
> Samsung SH-S183A DVD writer was lost for 2.6.24-rc1? I found

No, I don't think we ever had workaround for sata_sil + SH-S183A
combination.  Do you have any specific patch/commit in mind?

> this in syslog:
[--snip--]
> Oct 28 11:29:26 pluto kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr
> 0x0 action 0x2 frozen
> Oct 28 11:29:26 pluto kernel: ata4.00: cmd
> a0/01:00:00:10:00/00:00:00:00:00/a0 tag 0 cdb 0xa4 data 16 in
> Oct 28 11:29:26 pluto kernel:          res
> 40/00:02:00:0c:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
> Oct 28 11:29:26 pluto kernel: ata4.00: status: { DRDY }
> Oct 28 11:29:27 pluto kernel: ata4: soft resetting link
> Oct 28 11:29:32 pluto kernel: ata4: port is slow to respond, please be
> patient (Status 0xf8)
> Oct 28 11:29:37 pluto kernel: ata4: SRST failed (errno=-16)
> Oct 28 11:29:37 pluto kernel: ata4: hard resetting link
> Oct 28 11:29:37 pluto kernel: ata4: SATA link up 1.5 Gbps (SStatus 113
> SControl 310)
> Oct 28 11:29:38 pluto kernel: ata4.00: configured for UDMA/33
> Oct 28 11:29:38 pluto kernel: ata4: EH complete
> Oct 28 11:29:38 pluto kernel: sr0: disc change detected.
> 
> Its difficult to reproduce, though.

The failing command is REPORT_KEY.  What were you doing when you saw
this error?

Not being reproducible indicates that it's unlikely to be a DMA issue
and more likely a temporary glitch in media recognition.

Thanks.

-- 
tejun
