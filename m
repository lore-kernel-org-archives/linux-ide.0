From: Grant Grundler <grundler@google.com>
Subject: Re: 2.6.28: Is there a way to disable sata probing for certain ports?
Date: Tue, 30 Dec 2008 09:08:46 -0800
Message-ID: <da824cf30812300908x3ff6061cn569203d5163664ea@mail.gmail.com>
References: <alpine.DEB.1.10.0812300605250.11356@p34.internal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:50534 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbYL3RIv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Dec 2008 12:08:51 -0500
In-Reply-To: <alpine.DEB.1.10.0812300605250.11356@p34.internal.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tue, Dec 30, 2008 at 4:24 AM, Justin Piszcz <jpiszcz@lucidpixels.com> wrote:
> When I boot from an Intel X25-E SSD, it takes roughly a few seconds;
> however, items such as:
>
> $ dmesg|grep link\ down
> [    2.447030] ata4: SATA link down (SStatus 0 SControl 300)
> [    4.481288] ata5: SATA link down (SStatus 0 SControl 0)
> [    6.501288] ata6: SATA link down (SStatus 0 SControl 0)
> [    8.522038] ata7: SATA link down (SStatus 0 SControl 0)
> [   10.552288] ata8: SATA link down (SStatus 0 SControl 0)
>
> Scanning for devices on channels that have nothing connected adds to the
> boot time, is there anyway to turn off/disable scanning for certain ports to
> help speed the boot process?

Some BIOSs allow one to enable/disable each port individually.
Have you checked the BIOS config menus for such an option?

drivers/ata/libata-core.c declares "ata_force_param_buf" but I don't
see any documentation for it despite the reference to
Documentation/kernel-parameters.txt .

hth,
grant
