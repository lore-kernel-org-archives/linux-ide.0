From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide: move ide_config_drive_speed() calls to upper
 layers
Date: Fri, 27 Jul 2007 12:27:23 +0100
Message-ID: <20070727122723.35b379d9@the-village.bc.nu>
References: <200707270222.28230.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52164 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755404AbXG0LUV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jul 2007 07:20:21 -0400
In-Reply-To: <200707270222.28230.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

On Fri, 27 Jul 2007 02:22:27 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> 
> * Convert {ide_hwif_t,ide_pci_device_t}->host_flag to be u16.
> 
> * Add IDE_HFLAG_POST_SET_MODE host to indicate the need to program the
>   host for the transfer mode after programming the device.  Set it in
>   au1xxx-ide/cs5530/cs5535/pdc202xx_new/sc1200/via82cxxx host drivers.

The CS5530 at least shouldn't care what order changes are done. I don't
think the SC1200 does either but I don't have the docs to hand.

For libata we went the post_set_mode way and then junked it. Instead
there is a ->set_mode method which defaults to the usual order and
actions. IT821x and similar override it to do very little, post_set_mode
people call the default method and then do their stuff, and some of the
crazier cases do stuff both before and after the default.

Much more flexible and it can do anything unlike flags for the cases you
have.
