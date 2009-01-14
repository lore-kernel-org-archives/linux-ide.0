From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Wed, 14 Jan 2009 13:58:32 +0100
Message-ID: <20090114135832.7718055f@hskinnemoen-d830>
References: <200901141345.42583.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nat-132.atmel.no ([80.232.32.132]:61262 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752723AbZANM6m (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Jan 2009 07:58:42 -0500
In-Reply-To: <200901141345.42583.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-ide@vger.kernel.org

Stanislaw Gruszka wrote:
> Some issues with driver:
> 
> * Why not platform driver
> Generic pata/ide_platform driver will not work with AT91 as we need to 
> do special things before access Task File and Data Register (functions 
> set_8bit_mode() and set_16bit_mode()). Also extra things needs to be
> done when changing PIO mode.

Why not use libata? There's already a pata_at32 driver there which
should be usable on at91 with perhaps a few minor changes.

> * Maintenance
> After inclusion, when I finish the driver, I hope someone from Atmel: 
> Nicolas or Haavard could take maintenance of it.

I'm not really involved with AT91 in any way except that I want to
share as many drivers as possible between AT91 and AVR32. So I don't
think I can take responsibility for an AT91-only driver.

Haavard
