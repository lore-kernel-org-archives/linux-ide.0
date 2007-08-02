From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] cs5530: always tune PIO
Date: Fri, 3 Aug 2007 00:51:59 +0100
Message-ID: <20070803005159.38ffb135@the-village.bc.nu>
References: <200708030046.27538.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48346 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757665AbXHBXoq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Aug 2007 19:44:46 -0400
In-Reply-To: <200708030046.27538.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

On Fri, 3 Aug 2007 00:46:27 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ide/pci/cs5530.c |   19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> Index: b/drivers/ide/pci/cs5530.c
> ===================================================================
> --- a/drivers/ide/pci/cs5530.c
> +++ b/drivers/ide/pci/cs5530.c
> @@ -1,5 +1,5 @@
>  /*
> - * linux/drivers/ide/pci/cs5530.c		Version 0.74	Jul 28 2007
> + * linux/drivers/ide/pci/cs5530.c		Version 0.75	Aug 2 2007

Looks good but if you've got BIOS set timings and you override them you
might want to copy the Palmax handler from the libata one. Basically the
Palmax has the CDROM in the docking station and the link between the two
is not good enough for the highest mode the drive and cd can do but must
be run PIO.
