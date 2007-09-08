From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Remove sync waiting code from libata
Date: Sat, 08 Sep 2007 22:33:33 +0200
Message-ID: <46E3071D.8010202@gmail.com>
References: <20070907024632.GH27404@parisc-linux.org>	<46E259DD.5090609@gmail.com>	<20070908171731.GB6809@parisc-linux.org> <20070908194714.5915dd10@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:37662 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590AbXIHUfL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Sep 2007 16:35:11 -0400
Received: by wa-out-1112.google.com with SMTP id v27so987845wah
        for <linux-ide@vger.kernel.org>; Sat, 08 Sep 2007 13:35:10 -0700 (PDT)
In-Reply-To: <20070908194714.5915dd10@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthew Wilcox <matthew@wil.cx>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Alan Cox wrote:
>> async probing also keeps device numbering stable.  As long as the device
>> responds within ten seconds (and the current code has half a second as
>> the timeout), it'll get the same number it would have had, even though
>> other hosts have successfully completed their probes during that time.
> 
> The usual probe time for a device which is spun down is nearer 30 seconds.

libata probing is done differently tho.  It goes like...

1. libata EH probes all hardware.  Things can take quite long here but
SCSI isn't really involved.

2. After libata EH is finished, SCSI host scan is invoked.  It doesn't
do much.  When SCSI probing command reaches libata-scsi, it just fakes
the replies from the information gathered in #1 - No actual ATA reset or
command is issued.  If there are multiple devices on a host (ATA port),
this rapid probing makes SCSI host scan code fail GFP_ATOMIC allocation
from time to time.  This is why the @sync hack was used.

Thanks.

-- 
tejun
