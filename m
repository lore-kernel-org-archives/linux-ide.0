From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata drive loosing connection/resetting port
Date: Thu, 16 Aug 2007 19:53:35 +0900
Message-ID: <46C42CAF.4040709@gmail.com>
References: <20070813220241.3f4b8df5@workstation64.home>	<6bffcb0e0708131311k51238bb0l63eeb2fce53e3481@mail.gmail.com>	<46C180D8.9060005@gmail.com>	<20070814221928.243949b6@workstation64.home>	<46C29AE8.5070903@gmail.com> <20070815154846.28b6b462@workstation64.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:56903 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762618AbXHPKxn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Aug 2007 06:53:43 -0400
Received: by wa-out-1112.google.com with SMTP id v27so241240wah
        for <linux-ide@vger.kernel.org>; Thu, 16 Aug 2007 03:53:43 -0700 (PDT)
In-Reply-To: <20070815154846.28b6b462@workstation64.home>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andreas Radke <a.radke@arcor.de>
Cc: linux-kernel@vger.kernel.org, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Andreas Radke wrote:
[on ahci]
> Aug 13 18:00:33 workstation64 ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x400101 action 0x2 frozen
> Aug 13 18:00:33 workstation64 ata1.00: (irq_stat 0x08000000, interface fatal error)
> Aug 13 18:00:33 workstation64 ata1.00: cmd ca/00:08:a0:cb:07/00:00:00:00:00/e8 tag 0 cdb 0x0 data 4096 out
> Aug 13 18:00:33 workstation64 res 50/00:00:bf:32:07/00:00:00:00:00/e8 Emask 0x10 (ATA bus error)

Errors are very consistent.  Data transfer from the host to the drive
fails and SError indicates Handshake Error, Non-recovered transient data
integrity error and often Recovered Data integrity error.  For some
reason, your drive doesn't like what it's hearing from the controller
and replies with R_ERR.

[on ata_piix]
> Aug 14 23:06:01 workstation64 ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
> Aug 14 23:06:01 workstation64 ata1.00: (BMDMA stat 0x26)
> Aug 14 23:06:01 workstation64 ata1.00: cmd ca/00:08:91:0d:45/00:00:00:00:00/e4 tag 0 cdb 0x0 data 4096 out
> Aug 14 23:06:01 workstation64 res 51/84:08:91:0d:45/00:00:00:00:00/e4 Emask 0x30 (host bus error)

As error reporting when using ata_piix is very limited.  It gets
reported as host bus error but I think it's basically the same problem.

I don't think this is driver issue.  I have the same controller and I've
never seen similar thing happening and I have plenty of drives and test
them often.  Error reports also point to transmission problems.  Your
drive just doesn't like what it's hearing.  Does 'smartctl -a /dev/sda'
tell anything special?

-- 
tejun
