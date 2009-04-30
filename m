From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide-cd: fix REQ_QUIET tests in cdrom_decode_status
Date: Thu, 30 Apr 2009 18:28:38 +0200
Message-ID: <200904301828.40957.bzolnier@gmail.com>
References: <49F6DC50.7000106@ru.mvista.com> <20090428213814.GA9462@liondog.tnic>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:55939 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755806AbZD3Qhv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Apr 2009 12:37:51 -0400
Received: by fxm2 with SMTP id 2so1928295fxm.37
        for <linux-ide@vger.kernel.org>; Thu, 30 Apr 2009 09:37:50 -0700 (PDT)
In-Reply-To: <20090428213814.GA9462@liondog.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-ide@vger.kernel.org, Helge Deller <deller@gmx.de>, Jens Axboe <jens.axboe@oracle.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

On Tuesday 28 April 2009 23:38:14 Borislav Petkov wrote:
> Here's a non-wrapped version, Sergei thanks for catching that.
> 
> --
> From: Borislav Petkov <petkovbb@gmail.com>
> Date: Mon, 27 Apr 2009 14:11:32 +0200
> Subject: [PATCH] ide-cd: fix REQ_QUIET tests in cdrom_decode_status
> 
> Original patch (dfa4411cc3a690011cab90e9a536938795366cf9) was buggy.
> This is a more proper fix which introduces blk_rq_quiet() macro
> alleviating the need for dumb, too short caching variables.
> 
> Thanks to Helge Deller and Bart for debugging this.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied to ide-2.6.git/for-linus branch

[ with "Reported-and-tested-by: Helge Deller <deller@gmx.de>" added ]
