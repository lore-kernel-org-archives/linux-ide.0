From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] [IDE] Platform IDE driver (was: MMIO IDE driver)
Date: Thu, 26 Jul 2007 21:28:18 +0200
Message-ID: <200707262128.18720.bzolnier@gmail.com>
References: <20070725165318.5331.23795.stgit@localhost.localdomain> <20070725184312.44ca7a8c@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:62760 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936117AbXGZT7r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jul 2007 15:59:47 -0400
Received: by ug-out-1314.google.com with SMTP id j3so591339ugf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jul 2007 12:59:46 -0700 (PDT)
In-Reply-To: <20070725184312.44ca7a8c@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Vitaly Bordug <vitb@kernel.crashing.org>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org

On Wednesday 25 July 2007, Alan Cox wrote:
> > pata_platform and ide_platform are carrying same driver names,
> > to easily switch between these drivers, without need to touch
> > platform code.
> > 
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
> 
> Acked-by: Alan Cox <alan@redhat.com>

added
