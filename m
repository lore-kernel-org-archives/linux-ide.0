From: Tejun Heo <htejun@gmail.com>
Subject: Re: ICH8 CF timeout (regression)...
Date: Fri, 03 Aug 2007 01:59:23 +0900
Message-ID: <46B20D6B.1060506@gmail.com>
References: <6278d2220708020348k26ac2293v648442f2281eca70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:53592 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758948AbXHBQ7b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Aug 2007 12:59:31 -0400
Received: by wa-out-1112.google.com with SMTP id v27so575893wah
        for <linux-ide@vger.kernel.org>; Thu, 02 Aug 2007 09:59:30 -0700 (PDT)
In-Reply-To: <6278d2220708020348k26ac2293v648442f2281eca70@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel J Blueman <daniel.blueman@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

Daniel J Blueman wrote:
> I'll grab kernel logs from the legacy ATA boot; what else can help
> debug this issue? No problem testing patches too.

Yeap, please post the old log.

> --- [2]
> ata2.00: limiting speed to UDMA/33:PIO4
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata2: soft resetting port
> ata2.00: configured for UDMA/33
> ata2: EH complete

What happens after this?

-- 
tejun
