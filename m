From: fdc-lide@cutlass.ping.de (Frank D. Cringle)
Subject: Re: AHCI backplane errors in 2.6.27
Date: Wed, 19 Nov 2008 10:42:46 +0100
Message-ID: <87abbw9hm1.fsf@cutlass.ping.de>
References: <efeafa350811180733h6115dbc9t5a33abf55e774388@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lilly.ping.de ([83.97.42.2]:2404 "HELO lilly.ping.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752443AbYKSJwB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 Nov 2008 04:52:01 -0500
In-Reply-To: <efeafa350811180733h6115dbc9t5a33abf55e774388@mail.gmail.com> (Lazy's message of "Tue, 18 Nov 2008 16:33:31 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Lazy <lazy404@gmail.com> writes:
> When booting 2.6.27-rc1 kernel on out intel SR1530HSH ( Quad core Xeon X3320)
> Sata controller is ICH9r running in AHCI mode with newest bios.
>
> After loading ahci driver backplane leds go amber which indicates a
> non fatal error according to my intel resseller.

I see the same effect on a "FUJITSU SIEMENS PRIMERGY TX150 S6" which
also has a ICH9r, running with the fake megaraid disabled in the bios.
This has 4 hotswap drive bays. When I boot from drive 0, the remaining
drives all blink their orange fault led.

It is possible to suppress the blinking with the boot parameter
ahci.ahci_em_messages=0.

-- 
Frank Cringle

