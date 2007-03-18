From: Tejun Heo <htejun@gmail.com>
Subject: Re: Add suport for Marvell 88SE6121 in ahci
Date: Sun, 18 Mar 2007 14:28:26 +0900
Message-ID: <45FCCDFA.8050800@gmail.com>
References: <200701311504.40277.jareguero@telefonica.net> <45C0AFB6.5010907@garzik.org> <200703161521.29461.jareguero@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.233]:31781 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbXCRF2c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Mar 2007 01:28:32 -0400
Received: by nz-out-0506.google.com with SMTP id s1so454538nze
        for <linux-ide@vger.kernel.org>; Sat, 17 Mar 2007 22:28:31 -0700 (PDT)
In-Reply-To: <200703161521.29461.jareguero@telefonica.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jose Alberto Reguero <jareguero@telefonica.net>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Jose Alberto Reguero wrote:
> I found that the driver work well for Marvel 6121 without the flag 
> ATA_FLAG_SKIP_D2H_BSY.
> What is the meaning of this flag?

This is usually meaningful with hotplug.  The problem is that, on some
SATA controllers including ahci and sata_sil24, the wait for the first
D2H Reg FIS indicating device readiness isn't reliable.  It's supposed
to work like the following (sata_sil behaves pretty good on this regard).

1. User hotplug device to port and PHY event interrupt raised, the
controller should set BSY status bit.

2. libata EH kicks in and waits for BSY to clear (current timeout 30s).
 Done by the first D2H Reg FIS.  Drives usually send this after spinup
is complete.

3. After BSY is cleared, the device is reset.

The problem with ahci and sata_sil24 is that there really is no TF
status register is non-existent or emulated in some way and they doesn't
let us reliably wait for !BSY after hotplug event.  This often makes the
wait in #2 timeout and that's 30 seconds.  :-(

So, the flag makes libata EH skip #2.  Post-reset waiting is reliable,
so there is no timeout.  But this causes problems on some devices (the
Quantum GoVault thing) which takes a looooong time to get ready and
don't respond correctly to phy reset while it's busy initializing.

The flag is there primarily for ICH ahci's.  Marvell might be different.
 Care to remove SKIP_D2H_BSY and test a LOT of hotplugging with several
different devices?  :-)

-- 
tejun
