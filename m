From: "Allen Martin" <AMartin@nvidia.com>
Subject: RE: [PATCH] Add quirk to set AHCI mode on ICH boards
Date: Mon, 12 Nov 2007 23:27:55 -0800
Message-ID: <F72FA20C31DD4F4C997B91C5B3690A095054A2@hqemmail07.nvidia.com>
References: <20071109020235.GA2031@ceren>	<20071109023129.GA25581@havoc.gtf.org>	<4733D421.7000505@rtr.ca>	<20071109034622.GB25581@havoc.gtf.org> <20071109120425.543971bf@the-village.bc.nu> <47351FE1.4000001@garzik.org> <DBFABB80F7FD3143A911F9E6CFD477B0329351A3@hqemmail02.nvidia.com> <473600B6.5070103@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.112.152]:7586 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490AbXKMH2f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Nov 2007 02:28:35 -0500
In-Reply-To: <473600B6.5070103@garzik.org>
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, Riki Oktarianto <rkoktarianto@gmail.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-ide@vger.kernel.org

> Allen Martin wrote:
> > At least for NVIDIA controllers, loading the AHCI driver 
> when the BIOS
> > is set to IDE mode is not recommended by NVIDIA.  Any AHCI 
> workarounds
> > in the BIOS are likely to be disabled when set to IDE mode. 
>  In practice
> 
> What workarounds, if any, are needed?
> 
> We need those in the driver not BIOS anyway, in order to 
> fully support 
> suspend/resume and host controller reset during runtime operation.

What I'm worred about is SMI traps implemented in the SBIOS for AHCI
workarounds that may be disabled when in IDE mode.

> In Linux at least, we have a bunch of open sata_nv issues, so forcing 
> users' interface into AHCI mode as a default future policy seems like 
> the most stable choice on NVIDIA AHCI platforms.

I believe most of the issues with sata_nv have been due to lack of
documentation of ADMA and swNCQ.  The NVIDA AHCI controllers that
operate in IDE mode are straight up PATA emulation ANSI/INCITS 370
interface, no hotplug, no NCQ.  So I would expect there to not be a lot
of issues.

I'm with you that AHCI mode is superior and should be used whenever
possible, but it probably comes as no suprise that almost all the
hardware/BIOS testing is done with Windows, and operating the hardware
in a mode that Windows doesn't (enabling AHCI in classcode 0101) seems
like asking for trouble.

-Allen
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
