From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Re: 2.6.19.1, sata_sil: sata dvd writer doesn't work
Date: Fri, 11 May 2007 10:33:28 +0200
Message-ID: <46442A58.4040304@gmail.com>
References: <46362672.7080103@gmx.net> <4636EA85.40809@t-online.de> <46371628.9060905@gmail.com> <46379CA1.601@t-online.de> <463AEAF9.3000103@gmail.com> <463B6E3F.5000300@t-online.de> <463EFF88.7050308@gmail.com> <463F6E45.504@t-online.de> <464088BF.5070106@gmail.com> <464206DB.1010506@t-online.de> <4643176A.80809@gmail.com> <4643803F.5040808@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.227]:14940 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758851AbXEKIdw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 04:33:52 -0400
Received: by nz-out-0506.google.com with SMTP id o1so913689nzf
        for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 01:33:51 -0700 (PDT)
In-Reply-To: <4643803F.5040808@t-online.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: linux-ide@vger.kernel.org, Daniel Beichl <daniel_beichl@gmx.net>

Hello,

Harald Dunkel wrote:
> Hi Tejun,
> 
> Setting the timeout to 15 did not help, either :-(. All your patches
> are still in, of course.

Hmm... I'm out of ideas.  I'll try it when I get back home.

> May 10 22:15:55 pluto kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
> 0x0 action 0x2 frozen
> May 10 22:15:55 pluto kernel: ata2.00: cmd
> a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0xad data 2052 in
> May 10 22:15:55 pluto kernel:          res
> 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
> May 10 22:15:55 pluto kernel: ata2: soft resetting port
> May 10 22:15:55 pluto kernel: CLASSIFY TF 00/01:01:01:14:eb/a0 <6>ata2:
> SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> May 10 22:15:55 pluto kernel: ata2.00: XXX: IDENTIFY
> May 10 22:15:55 pluto kernel: 00: 3b38 13ed f880 edbe  8013 bef8 13ed f880
[--snip--]
> May 10 22:15:55 pluto kernel: ata2.00: failed to IDENTIFY (device
> reports illegal type, err_mask=0x0)
> May 10 22:15:55 pluto kernel: ata2.00: revalidation failed (errno=-22)
> May 10 22:15:55 pluto kernel: ata2.00: limiting speed to UDMA/33:PIO3
> May 10 22:15:55 pluto kernel: ata2: failed to recover some devices,
> retrying in 5 secs
> May 10 22:16:00 pluto kernel: ata2: hard resetting port
> May 10 22:16:01 pluto kernel: CLASSIFY TF 00/01:01:01:14:eb/a0 <6>ata2:
> SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> May 10 22:16:01 pluto kernel: ata2.00: XXX: IDENTIFY
> May 10 22:16:01 pluto kernel: 00: 85c0 0000 0000 0000  0000 0000 0000 0000
[--snip--]
> May 10 22:16:01 pluto kernel: ata2.00: configured for UDMA/33
> May 10 22:16:01 pluto kernel: ata2: EH complete

Well, at least one thing worked.  I'll push the patch upstream soon.

Thanks.

-- 
tejun
