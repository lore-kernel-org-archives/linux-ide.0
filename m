From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Wed, 14 Jan 2009 20:05:34 +0300
Message-ID: <496E1B5E.2010106@ru.mvista.com>
References: <200901141345.42583.stf_xl@wp.pl> <20090114135832.7718055f@hskinnemoen-d830>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:45417 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1764679AbZANRFB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Jan 2009 12:05:01 -0500
In-Reply-To: <20090114135832.7718055f@hskinnemoen-d830>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-ide@vger.kernel.org

Hello.

Haavard Skinnemoen wrote:

>>* Why not platform driver
>>Generic pata/ide_platform driver will not work with AT91 as we need to 
>>do special things before access Task File and Data Register (functions 
>>set_8bit_mode() and set_16bit_mode()). Also extra things needs to be
>>done when changing PIO mode.

> Why not use libata?

    Why libata? You absolutely need the larger code footprint with the added 
"bonus" of SCSI disk emulation? :-)

> There's already a pata_at32 driver there which
> should be usable on at91 with perhaps a few minor changes.

    Well, if there's already close driver, it changes the matter...

MBR, Sergei
