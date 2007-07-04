From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 9/15] ide: add PIO masks
Date: Wed, 4 Jul 2007 21:02:38 +0200
Message-ID: <200707042102.39090.bzolnier@gmail.com>
References: <200706302107.42458.bzolnier@gmail.com> <468BAD97.2030904@ru.mvista.com> <20070704153125.771f9a79@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:49036 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756040AbXGDSqH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 14:46:07 -0400
Received: by mu-out-0910.google.com with SMTP id i10so3324201mue
        for <linux-ide@vger.kernel.org>; Wed, 04 Jul 2007 11:46:06 -0700 (PDT)
In-Reply-To: <20070704153125.771f9a79@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

On Wednesday 04 July 2007, Alan Cox wrote:
> > > It doesn't need to do anything. 
> > 
> >     Not true. It should call ide_config_drive_speed() at least, else PIO 
> > autotuning won't actually work.
> 
> Indeed - I forgot that old-ide doesn't do this itself but leaves it up to
> the driver to forget 8)

OK, now that you both agree on the issue, could somebody please fix it? :-)

Thanks,
Bart
