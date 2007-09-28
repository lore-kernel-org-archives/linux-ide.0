From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 with port multiplier
Date: Fri, 28 Sep 2007 03:24:15 -0700
Message-ID: <46FCD64F.9080805@gmail.com>
References: <FD6311B7ED175B4480F31633F6098B4D911D02@ffpglobal_mail.corp.ffplus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.231]:25986 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755411AbXI1KZ4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Sep 2007 06:25:56 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2346991wxd
        for <linux-ide@vger.kernel.org>; Fri, 28 Sep 2007 03:25:55 -0700 (PDT)
In-Reply-To: <FD6311B7ED175B4480F31633F6098B4D911D02@ffpglobal_mail.corp.ffplus.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jon Chelton <jchelton@ffpglobal.com>
Cc: linux-ide@vger.kernel.org

Jon Chelton wrote:
> After applying the patches you sent, I had not received any additional
> errors until today.  Below is an output from dmesg.
> 
> ata1.15: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata1.15: irq_stat 0x00020002, PMP DMA CS errata
> ata1.00: exception Emask 0x100 SAct 0x18084200 SErr 0x0 action 0x6
> frozen
> ata1.00: cmd 60/00:48:3f:8f:fa/01:00:0a:00:00/40 tag 9 cdb 0x0 data
> 131072 in
>          res 50/00:3c:3f:ff:67/00:00:00:00:00/40 Emask 0x100 (unknown
> error)

Hmmm... So, when did the above error occur?  Can you reproduce it?

-- 
tejun
