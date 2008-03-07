From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA HDD password problem
Date: Fri, 07 Mar 2008 12:54:02 +0900
Message-ID: <47D0BC5A.9000208@gmail.com>
References: <Pine.LNX.4.64.0803051143450.27209@Soyuz-KT.TeNet.Odessa.UA> <47CE9264.1010600@garzik.org> <Pine.LNX.4.64.0803051443500.28213@Soyuz-KT.TeNet.Odessa.UA> <47CFBDB6.8040400@gmail.com> <Pine.LNX.4.64.0803061417540.5200@Soyuz-KT.TeNet.Odessa.UA>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.177]:14478 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762058AbYCGDyM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Mar 2008 22:54:12 -0500
Received: by el-out-1112.google.com with SMTP id v27so366335ele.17
        for <linux-ide@vger.kernel.org>; Thu, 06 Mar 2008 19:54:09 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0803061417540.5200@Soyuz-KT.TeNet.Odessa.UA>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rus V. Brushkoff" <rus@SoyuzKT.Od.UA>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

Hello, Rus.

Rus V. Brushkoff wrote:
>  Controller is SATA controller [0106]: ATI Technologies Inc SB600 
> Non-Raid-5 SATA (1002:4380). dmesg attached. hdparm -I /dev/sda :

Ah.. okay.  ahci uses SRST for probing the AHCI controller
initialization sequence involves controller-wide reset which results in
PHY reset.

> ATA device, with non-removable media
> 	Model Number:       WDC WD2500BEVS-22UST0                   
> 	Serial Number:      WD-WXEX07G90288
> 	Firmware Revision:  01.01A01
<---snip--->
> 	   *	Software settings preservation
>
> Seems like SSP supported for this unit. But issuing hdparm -k/-K gives :

Yeap, SSP is supported and enabled.  If supported, SSP is turned on by
default unless explicitly disabled and is supposed to preserve security
mode state.

> [Hors]:root:~ # hdparm -k /dev/sda
> 
> /dev/sda:
>  HDIO_GET_KEEPSETTINGS failed: Inappropriate ioctl for device
> [Hors]:root:~ # hdparm -K 1 /dev/sda
> 
> /dev/sda:
>  setting drive keep features to 1 (on)
>  HDIO_DRIVE_CMD(keepsettings) failed: Input/output error
> .....

Those two are different ones.  These are to keep software setting over
soft resets and doesn't have much to do with SSP.  Mark, maybe we need
to add a feature to hdparm to configure SSP?

> :As SATA PHY events can happen at any time and PHY events mean COMRESET
> :which is hardreset for the device and resets most configurations, it's a
> :bit difficult.  Basically, OS should record all relevant configurations
> :and reprogram the drive after such event.  OS can also do thing which
> :are BIOS dependent via ACPI _GTF but the problem is that _GTF can only
> :issue no-data command and SECURITY_UNLOCK isn't one of them.  Even if
> :that wasn't the problem, it's pretty dumb to pass clear text to OS via
> :ACPI method.
> :
> :To solve the problem, ATA added Software Setting Preservation
> :featureset, which makes the drive remember configurations over
> :hardresets but it's an optional feature and not all drives implement it.
> : I think having SSP support in the drive is the only sane way to support
> :password locking on SATA; otherwise, the drive can just go away while
> :the system is running.  That said, it would be nice to have a parameter
> :to force SRST or no reset at all for odd cases.
> 
>  Hmm, if someone enable SSP in the drive after password unlock - does this 
> mean that it will be unlocked forever ? Or drive can distinguish between 
> power-on and hard-reset states ?

SSP by default stays on, so once unlocked it will stay unlocked as long
as power stays applied.  On power loss, it gets locked again.  On
reboots, the BIOS can always lock it again if it wants to.

This is weird.  The drive should have stayed unlocked over
initialization sequence as SSP is in effect.  Either the BIOS is turning
off SSP during POST or the drive isn't preserving security mode state
although SSP is in effect.  Testing who's to blame can be a bit
cumbersome and involves removing power from the drive while the rest of
the system is running.  Can you do that?

Thanks.

-- 
tejun
