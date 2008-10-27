From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: http://bugzilla.kernel.org/show_bug.cgi?id=11742
Date: Mon, 27 Oct 2008 20:46:18 +0100
Message-ID: <200810272046.19155.bzolnier@gmail.com>
References: <20081020112039W.fujita.tomonori@lab.ntt.co.jp> <200810262101.42874.valerio.passini@unicam.it> <20081027061556.GA17928@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.189]:27191 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754387AbYJ0Tv3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Oct 2008 15:51:29 -0400
Received: by gv-out-0910.google.com with SMTP id e6so300362gvc.37
        for <linux-ide@vger.kernel.org>; Mon, 27 Oct 2008 12:51:26 -0700 (PDT)
In-Reply-To: <20081027061556.GA17928@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: Valerio Passini <valerio.passini@unicam.it>, valerio.p@libero.it, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org

On Monday 27 October 2008, Borislav Petkov wrote:
> On Sun, Oct 26, 2008 at 09:01:42PM +0100, Valerio Passini wrote:
> 
> [.. ]
> 
> > Here I am, thus the patched kernel has been installed and tested.
> > Burning CD's and simulation work perfectly and everything seems fine.
> > :)
> 
> Well, nice to hear :). Thanks for your debugging effort and patience.
> 
> Bart, please apply.
> 
> ---
> From: Borislav Petkov <petkovbb@gmail.com>
> Date: Mon, 27 Oct 2008 06:59:14 +0100
> Subject: [PATCH] ide-cd: fix dma alignment regression
> 
> e5318b531b008c79d2a0c0df06a7b8628da38e2f introduced a regression which
> caused some ATAPI drives to turn off dma for REQ_TYPE_ATA_PC commands

I believe you meant REQ_TYPE_BLOCK_PC here.

> while burning and thus degrating performance and ultimately causing an
> excessive amount of underruns. The issue is documented also in
> http://bugzilla.kernel.org/show_bug.cgi?id=11742.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> CC: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Tested-by: Valerio Passini <valerio.passini@unicam.it>

applied (with patch description fixups suggested by Sergei)
