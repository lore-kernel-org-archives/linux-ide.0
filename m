From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/5] powerpc: remove mpc8xx-ide driver
Date: Tue, 10 Jun 2008 21:01:19 +0200
Message-ID: <200806102101.20156.bzolnier@gmail.com>
References: <20080610142702.354823071@arndb.de> <20080610142947.711491620@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:26534 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756723AbYFJTPw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jun 2008 15:15:52 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1893375mue.1
        for <linux-ide@vger.kernel.org>; Tue, 10 Jun 2008 12:15:51 -0700 (PDT)
In-Reply-To: <20080610142947.711491620@arndb.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: arnd@arndb.de
Cc: paulus@samba.org, linuxppc-dev@vger.kernel.org, Kumar Gala <galak@kernel.crashing.org>, linux-ide@vger.kernel.org


Hi,

On Tuesday 10 June 2008, arnd@arndb.de wrote:
> This driver was only used by arch/ppc code and is obsolete
> now with the move to common arch/powerpc code.
> 
> Cc: linux-ide@vger.kernel.org
> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/ide/Kconfig      |   10 -
>  drivers/ide/ppc/Makefile |    1 -
>  drivers/ide/ppc/mpc8xx.c |  847 ----------------------------------------------
>  3 files changed, 0 insertions(+), 858 deletions(-)
>  delete mode 100644 drivers/ide/ppc/mpc8xx.c

Thanks, applied.

[ there is a couple of patches in IDE tree touching this driver so I needed
  to refresh the patch - IOW it now removes the "freshest" mpc8xx.c version ]

Paul/Kumar: I hope you are fine with this.

Bart
