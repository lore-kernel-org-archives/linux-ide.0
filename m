From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: move ide_config_drive_speed() calls to upper layers
Date: Fri, 27 Jul 2007 21:19:19 +0200
Message-ID: <200707272119.19438.bzolnier@gmail.com>
References: <200707270222.28230.bzolnier@gmail.com> <20070727122723.35b379d9@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:33657 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755232AbXG1Lwu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Jul 2007 07:52:50 -0400
Received: by nf-out-0910.google.com with SMTP id g13so80873nfb
        for <linux-ide@vger.kernel.org>; Sat, 28 Jul 2007 04:52:49 -0700 (PDT)
In-Reply-To: <20070727122723.35b379d9@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Friday 27 July 2007, Alan Cox wrote:
> On Fri, 27 Jul 2007 02:22:27 +0200
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > 
> > * Convert {ide_hwif_t,ide_pci_device_t}->host_flag to be u16.
> > 
> > * Add IDE_HFLAG_POST_SET_MODE host to indicate the need to program the
> >   host for the transfer mode after programming the device.  Set it in
> >   au1xxx-ide/cs5530/cs5535/pdc202xx_new/sc1200/via82cxxx host drivers.
> 
> The CS5530 at least shouldn't care what order changes are done. I don't
> think the SC1200 does either but I don't have the docs to hand.

Thanks, I will make a follow up patch to remove this flag from
cs5530 host driver (unless of course somebody beats me to it).

> For libata we went the post_set_mode way and then junked it. Instead
> there is a ->set_mode method which defaults to the usual order and
> actions. IT821x and similar override it to do very little, post_set_mode
> people call the default method and then do their stuff, and some of the
> crazier cases do stuff both before and after the default.
> 
> Much more flexible and it can do anything unlike flags for the cases you
> have.

I view this patch as an intermediate step in ->set_mode direction. 

Thanks,
Bart
