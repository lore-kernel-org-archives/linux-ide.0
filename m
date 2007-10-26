From: Tejun Heo <htejun@gmail.com>
Subject: Re: Re-enabling Serial ATA ports possible?
Date: Fri, 26 Oct 2007 18:48:27 +0900
Message-ID: <4721B7EB.7010209@gmail.com>
References: <200710171251.l9HCpCv7021811@harpo.it.uu.se> <47214F9F.50306@gmail.com> <200710261118.47736.openembedded@haerwu.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:6678 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898AbXJZJsg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Oct 2007 05:48:36 -0400
Received: by rv-out-0910.google.com with SMTP id k20so741266rvb
        for <linux-ide@vger.kernel.org>; Fri, 26 Oct 2007 02:48:36 -0700 (PDT)
In-Reply-To: <200710261118.47736.openembedded@haerwu.biz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marcin Juszkiewicz <openembedded@haerwu.biz>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Marcin Juszkiewicz wrote:
> /dev/sr0:
> 
> ATAPI CD-ROM, with removable media
>         Model Number:       TSSTcorpCD/DVDW SH-S183A
>         Serial Number:
>         Firmware Revision:  SB02
> Standards:
>         Likely used CD-ROM ATAPI-1
> Configuration:
>         DRQ response: 50us.
>         Packet size: 12 bytes
> Capabilities:
>         LBA, IORDY(can be disabled)
>         DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2
>              Cycle time: min=120ns recommended=120ns
>         PIO: pio0 pio1 pio2 pio3 pio4
>              Cycle time: no flow control=120ns  IORDY flow control=120ns
> Commands/features:
>         Enabled Supported:
>            *    SATA-I signaling speed (1.5Gb/s)
>            *    Host-initiated interface power management
>            *    Phy event counters
>                 Device-initiated interface power management
>                 Asynchronous notification (eg. media change)
>            *    Software settings preservation

I have the same one.  Do you have a reliable scenario to trigger the
problem so that I can try to reproduce it here?

>> Also, you can trigger rescan by "echo - - - /sys/class/scsi_host/hostX/scan".
> 
> This does not worked here - I mean it found only online drives not offline
> dvd/rw drive.

>From the log, it seems PHY went down completely.  The device probably
needs power removed and reapplied to get out of the lock up.  Nothing
much software can do.

-- 
tejun
