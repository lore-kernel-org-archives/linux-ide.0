From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.24 found 5 exceptions in dmesg after not using the system
 for while
Date: Tue, 12 Feb 2008 10:40:00 +0900
Message-ID: <47B0F8F0.4000902@gmail.com>
References: <76366b180802091514k23cc5b0dw875386427eacf881@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:37795 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbYBLBkI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Feb 2008 20:40:08 -0500
Received: by wr-out-0506.google.com with SMTP id c48so4314587wra.23
        for <linux-ide@vger.kernel.org>; Mon, 11 Feb 2008 17:40:07 -0800 (PST)
In-Reply-To: <76366b180802091514k23cc5b0dw875386427eacf881@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Paprocki <andrew@ishiboo.com>
Cc: linux-ide@vger.kernel.org

Andrew Paprocki wrote:
> I haven't used the system with these errors in a day or two and I came
> back and noticed 5 exceptions in dmesg. These are all the same:
> 
> ata1: exception Emask 0x10 SAct 0x0 SErr 0x90200 action 0xe frozen
> ata1: irq_stat 0x00400000, PHY RDY changed
> ata1: SError: { Persist PHYRdyChg 10B8B }

That's link going down and up again.  Reseat/replace cable and see
whether the problem goes away.  Connecting the drive to different port
is also worth trying.  If none helps, the most likely cause is power.
After boot, record the result of 'smartctl -a' on the drive.  After the
above conditions occur, do the same and compare the result.  If
Start_Stop_Count increased, your power is having problem keeping the
drive spun up and if writes were in progress during such events, you'll
lose data.

-- 
tejun
