From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Remove Asus EEE UDMA/33 limitation.
Date: Sat, 3 May 2008 10:58:17 +0100
Message-ID: <20080503095817.GA22208@srcf.ucam.org>
References: <20080502154458.GA10567@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mjg.x.mythic-beasts.com ([93.93.128.6]:59708 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1759125AbYECJ63 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 May 2008 05:58:29 -0400
Content-Disposition: inline
In-Reply-To: <20080502154458.GA10567@codemonkey.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Jones <davej@codemonkey.org.uk>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

On Fri, May 02, 2008 at 11:44:58AM -0400, Dave Jones wrote:

>  static const struct ich_laptop ich_laptop[] = {
>  	/* devid, subvendor, subdev */
> +	{ 0x2653, 0x1043, 0x82d8 },	/* ICH6M on Asus Eee PC */
>  	{ 0x27DF, 0x0005, 0x0280 },	/* ICH7 on Acer 5602WLMi */
>  	{ 0x27DF, 0x1025, 0x0102 },	/* ICH7 on Acer 5602aWLMi */
>  	{ 0x27DF, 0x1025, 0x0110 },	/* ICH7 on Acer 3682WLMi */

Don't the ACPI timing methods let us work this out without requiring 
machine specific knowledge? Or is the concern that some firmware will 
let us program high modes even if the cabling isn't up to it?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
