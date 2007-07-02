From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: add ide_dev_has_iordy() helper (take 4)
Date: Mon, 2 Jul 2007 19:52:38 +0200
Message-ID: <200707021952.38761.bzolnier@gmail.com>
References: <200707010044.55052.bzolnier@gmail.com> <46890B4D.7050604@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:3281 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353AbXGBRul (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jul 2007 13:50:41 -0400
Received: by mu-out-0910.google.com with SMTP id i10so2467484mue
        for <linux-ide@vger.kernel.org>; Mon, 02 Jul 2007 10:50:39 -0700 (PDT)
In-Reply-To: <46890B4D.7050604@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>


Hello,

On Monday 02 July 2007, you wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> > * Add ide_dev_has_iordy() helper and use it sl82c105 host driver.
> 
> > * Remove no longer needed ide_pio_data_t.use_iordy field.
> 
> > v2/v3:
> > * Fix issues noticed by Sergei:
> >   - correct patch description
> >   - fix comment in ide_get_best_pio_mode()
> 
> > v4:
> > * Fix "ata_" prefix (Noticed by Jeff).
> 
>     I've noticed it first! ;-)

Yeah, but IIRC you didn't mention that "ata_" prefix is actually harmful!

Or you did but the message didn't get through... ;-)

Bart
