From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Remove Asus EEE UDMA/33 limitation.
Date: Sat, 3 May 2008 15:51:24 +0100
Message-ID: <20080503155124.004e27a7@core>
References: <20080502154458.GA10567@codemonkey.org.uk>
	<20080503095817.GA22208@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37041 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752961AbYECPAL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 May 2008 11:00:11 -0400
In-Reply-To: <20080503095817.GA22208@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Dave Jones <davej@codemonkey.org.uk>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

On Sat, 3 May 2008 10:58:17 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Fri, May 02, 2008 at 11:44:58AM -0400, Dave Jones wrote:
> 
> >  static const struct ich_laptop ich_laptop[] = {
> >  	/* devid, subvendor, subdev */
> > +	{ 0x2653, 0x1043, 0x82d8 },	/* ICH6M on Asus Eee PC */
> >  	{ 0x27DF, 0x0005, 0x0280 },	/* ICH7 on Acer 5602WLMi */
> >  	{ 0x27DF, 0x1025, 0x0102 },	/* ICH7 on Acer 5602aWLMi */
> >  	{ 0x27DF, 0x1025, 0x0110 },	/* ICH7 on Acer 3682WLMi */
> 
> Don't the ACPI timing methods let us work this out without requiring 
> machine specific knowledge? 

We don't currently sniff the ACPI timing data on Intel boxes - we can do
so and there is a library routine but I'd be worried about the usual
standard of BIOS code. Right now we only do it for chipsets which are so
braindamaged we have no other choice or where the vendor specifically
implemented and intended the ACPI data to be used for this (eg Nvidia)
