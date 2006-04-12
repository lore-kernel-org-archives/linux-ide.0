From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata-pata works on ICH4-M
Date: Wed, 12 Apr 2006 15:38:22 +0100
Message-ID: <1144852703.1952.36.camel@localhost.localdomain>
References: <443B9EBB.6010607@gmx.net>
	 <Pine.LNX.4.61.0604112044340.25940@yvahk01.tjqt.qr>
	 <1144832990.1952.20.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0604121153060.12544@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:13706 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751171AbWDLO3U (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Apr 2006 10:29:20 -0400
In-Reply-To: <Pine.LNX.4.61.0604121153060.12544@yvahk01.tjqt.qr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mer, 2006-04-12 at 11:55 +0200, Jan Engelhardt wrote:
> That sounds nice, but does hdparm also work with it? The last time I 
> tried to hdparm a SCSI-style device (usb flash disk, /dev/sda), it did 
> not work, only sdparm did the job. Will this also be the case with libata?

Ask the hdparm maintainers. Its mostly obsoleted by blktool and the like
which are generic

> (BTW, did you mean LBA48?)

No I meant LBA28. An LBA48 command takes far longer to issue than LBA28

