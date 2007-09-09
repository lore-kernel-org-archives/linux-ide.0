From: Tejun Heo <htejun@gmail.com>
Subject: Re: Port Multiplier Patch 2.6.22.1 on Alpha
Date: Sun, 09 Sep 2007 09:11:36 +0200
Message-ID: <46E39CA8.3020406@gmail.com>
References: <46D638A3.2030704@23palmer.net> <46D64290.2010306@garzik.org> <46E22817.9080200@23palmer.net> <46E30BCA.1070705@gmail.com> <46E37154.9010007@23palmer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:7070 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbXIIHNO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Sep 2007 03:13:14 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1127345wah
        for <linux-ide@vger.kernel.org>; Sun, 09 Sep 2007 00:13:13 -0700 (PDT)
In-Reply-To: <46E37154.9010007@23palmer.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom Evans <tom@23palmer.net>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Tom Evans wrote:
> I do not see any console or syslog messages at the time - perhaps I do
> not have a debug level set appropriately?

Executing dmesg after the event should give you the messages if the
kernel has spoken anything.

> Also, as an aside, I noticed that the device scan on the remote array
> shows this device:
> 
> Sep  8 00:15:12 chronictown kernel: [4194044.507921] ata4.05: ATA-6:
> Config  Disk, PLS12052, max UDMA/133
> Sep  8 00:15:12 chronictown kernel: [4194044.507921] ata4.05: 640
> sectors, multi 1: LBA
> Sep  8 00:15:12 chronictown kernel: [4194044.507921] ata4.05: device is
> on DMA blacklist, disabling DMA
> Sep  8 00:15:12 chronictown kernel: [4194044.507921] ata4.05: configured
> for PIO4
> 
> 
> I couldn't find any reference - is this firmware for the PMP or
> something like that?

That's the pseudo device for configuration.  It can be safely ignored
unless it causes problems.

Thanks.

-- 
tejun
