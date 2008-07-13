From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_it821x completely broken
Date: Sun, 13 Jul 2008 12:35:10 +0100
Message-ID: <20080713123510.6f47ffdc@lxorguk.ukuu.org.uk>
References: <200807042153.56644.linux@rainbow-software.org>
	<20080711211409.2eef4ddb@lxorguk.ukuu.org.uk>
	<200807122342.12841.linux@rainbow-software.org>
	<200807131347.14045.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:46116 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752493AbYGMLyz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Jul 2008 07:54:55 -0400
In-Reply-To: <200807131347.14045.linux@rainbow-software.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Alan Cox <alan@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

> The patch below fixes the IDENTIFY problem for me and makes the RAID array accessible.
> Is it OK or is there a better way to do it?

Probably better to fix it in driver. Right now we don't have a way to
override the identify reading or post process it cleanly at it821x hacks
around that but if that was fixed then the special cases can all hide in
the driver where they belong.

> +	/* Has LBA48 but advertises neither LBA nor LBA48 */
> +	{ "Integrated Technology Express Inc", NULL, ATA_HORKAGE_LBA48_FORCE, },

That depends on the firmware revision it seems. Mine are fine

