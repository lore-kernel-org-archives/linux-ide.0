From: Miah Gregory <mace@darksilence.net>
Subject: Re: SATA errors
Date: Sun, 09 Aug 2009 22:11:30 +0100
Message-ID: <1249852290.17536.10.camel@meteotsunami.darksilence.net>
References: <1249814200.13927.65.camel@meteotsunami.darksilence.net>
	 <19071.10817.664277.813057@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:13507 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751260AbZHIVLy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Aug 2009 17:11:54 -0400
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20090809211140.QEJA5579.mtaout03-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>
          for <linux-ide@vger.kernel.org>; Sun, 9 Aug 2009 22:11:40 +0100
Received: from acks.darksilence.net ([82.3.111.150])
          by aamtaout01-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with SMTP
          id <20090809211140.XJVU13254.aamtaout01-winn.ispmail.ntl.com@acks.darksilence.net>
          for <linux-ide@vger.kernel.org>; Sun, 9 Aug 2009 22:11:40 +0100
In-Reply-To: <19071.10817.664277.813057@pilspetsen.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>

On Sun, 2009-08-09 at 21:57 +0200, Mikael Pettersson wrote:
> Miah Gregory writes:

>  > One of my servers has started to log slightly odd errors following one
>  > of the software RAID arrays having been degraded due to an error on sdb.
> ...

> 1. Did these problems start spontaneously, or did they follow some
>    system change like installing more disks or booting a newer kernel?

Spontaneously; the machine has been running the current kernel since the
end of January, with some brief excursions to newer kernels which were
reverted due to the XFS/NFS interaction problems which haven't yet been
pinned down. No hardware changes etc. Current uptime just over 61 days.

> 2. If there's reason to suspect a kernel issue, the disk-to-controller
>    mapping in this machine will tell us which driver may be at fault.
>    Please post a complete kernel boot log from e.g. `dmesg'.

That will need a reboot, as the logs from the previous boot are long
since rotated; will organise this as time permits.

> 3. If the disks are attached to the Promise controller, please try this patch:
>    <http://user.it.uu.se/~mikpe/linux/patches/sata_promise/2.6.28/patch-sata_promise-reset-updates-v1-2.6.28>
>    It improved error recovery in a case where smart commands to a sleeping
>    disk of a particular model timed out.

Could you clarify sleeping in this context? None of the disks are being
spun down, if that is what is meant?

Cheers.

ps. am subscribed to list, no need to cc

-- 
Miah Gregory

