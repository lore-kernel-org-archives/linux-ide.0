From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA HDD password problem
Date: Thu, 06 Mar 2008 18:47:34 +0900
Message-ID: <47CFBDB6.8040400@gmail.com>
References: <Pine.LNX.4.64.0803051143450.27209@Soyuz-KT.TeNet.Odessa.UA> <47CE9264.1010600@garzik.org> <Pine.LNX.4.64.0803051443500.28213@Soyuz-KT.TeNet.Odessa.UA>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.191]:9669 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbYCFJrp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Mar 2008 04:47:45 -0500
Received: by rn-out-0910.google.com with SMTP id v46so856572rnb.15
        for <linux-ide@vger.kernel.org>; Thu, 06 Mar 2008 01:47:42 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0803051443500.28213@Soyuz-KT.TeNet.Odessa.UA>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rus V. Brushkoff" <rus@SoyuzKT.Od.UA>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Hello,

Rus V. Brushkoff wrote:
> :> kernel, kernel send RESET to SATA drive and password need to be entered 
> :again > - so the kernel panics because it cant mount rootfs. How this 
> :problem can be solved ?

Which controller are you on?  Can you please post full successful boot
log and the result of "hdparm -I /dev/sda"?

As SATA PHY events can happen at any time and PHY events mean COMRESET
which is hardreset for the device and resets most configurations, it's a
bit difficult.  Basically, OS should record all relevant configurations
and reprogram the drive after such event.  OS can also do thing which
are BIOS dependent via ACPI _GTF but the problem is that _GTF can only
issue no-data command and SECURITY_UNLOCK isn't one of them.  Even if
that wasn't the problem, it's pretty dumb to pass clear text to OS via
ACPI method.

To solve the problem, ATA added Software Setting Preservation
featureset, which makes the drive remember configurations over
hardresets but it's an optional feature and not all drives implement it.
 I think having SSP support in the drive is the only sane way to support
password locking on SATA; otherwise, the drive can just go away while
the system is running.  That said, it would be nice to have a parameter
to force SRST or no reset at all for odd cases.

Thanks.

-- 
tejun
