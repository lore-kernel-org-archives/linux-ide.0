From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] libata: remove experimental tag on PATA drivers
Date: Sat, 14 Nov 2009 02:29:51 +0000
Message-ID: <20091114022951.GA9796@srcf.ucam.org>
References: <4AFCC0D4.9020708@gmail.com> <200911131715.24377.bzolnier@gmail.com> <20091113182515.38fb3793@lxorguk.ukuu.org.uk> <200911140046.29450.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:40515 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755217AbZKNC37 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Nov 2009 21:29:59 -0500
Content-Disposition: inline
In-Reply-To: <200911140046.29450.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Hancock <hancockrwd@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Jonathan Corbet <corbet@lwn.net>

On Sat, Nov 14, 2009 at 12:46:29AM +0100, Bartlomiej Zolnierkiewicz wrote:

> Skipping the technical merit of the quoted text for the moment -- I find
> the fact that you keep calling the present IDE host drivers (that many
> developers helped to fix) as "old" ones or "buggy" ones rather degrading
> for their (this includes me of course) hard work.

Without making any judgement about the relative quality of the drivers 
in their role as IDE drivers, the fact that ACPI hotplug works with 
libata and doesn't work with drivers/ide means that, rationally, 
distributions need to use the libata stack for the more common parts. 
There simply isn't the same level of integration between drivers/ide and 
the rest of the OS.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
