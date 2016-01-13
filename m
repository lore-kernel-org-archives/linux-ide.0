From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ata: add AMD Seattle platform driver
Date: Wed, 13 Jan 2016 21:39:48 +0100
Message-ID: <10776629.UCmL1lPAav@wuerfel>
References: <1452200002-31590-1-git-send-email-brijesh.singh@amd.com> <4689728.Nn3Rl2cUeP@wuerfel> <56968168.4010606@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:54478 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932213AbcAMUka (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jan 2016 15:40:30 -0500
In-Reply-To: <56968168.4010606@amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux-ide@vger.kernel.org, robh+dt@kernel.org, galak@codeaurora.org, tj@kernel.org

On Wednesday 13 January 2016 10:55:04 Brijesh Singh wrote:
> On 01/12/2016 08:24 AM, Arnd Bergmann wrote:

> > c) calling into the ACPI interpreter to do platform specific hacks
> 
> Thanks for explaining. Now I understood your comment on AML however we need to consider the following:
> 
> a) activity LED blinking routines are called very frequent (10 to 100ms based on emp->state) and executing AML method that often would introduces its own overhead.
> 
> b) all BIOS vendors need to implement a new methods in their DSDT and release a new BIOS.
> 
> c) other OS'es (mainly Windows) driver need to be updated.
> 
> 
> We don't know how many other SoC's have similar hacky implementation which can take advantage of extending generic
> AHCI driver to call into AML methods for LED blink. Given some of these causes I think having a platform driver is much cleaner. I can drop DT binding part from this driver and keep just ACPI binding.
> 
> Thoughts ?

I don't care what you do with ACPI, just make sure we can use the generic
driver without any platform specific hacks for the DT case.

For ACPI, please talk to the respective maintainers about whether they want
to have a custom driver for this case, or a proper abstraction in the generic
driver.

	Arnd
