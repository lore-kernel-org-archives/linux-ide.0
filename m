From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [2.6 patch] remove the broken ETRAX_IDE driver
Date: Tue, 15 Apr 2008 23:35:20 +0200
Message-ID: <200804152335.21101.bzolnier@gmail.com>
References: <20080413183629.GA21204@cs181133002.pp.htv.fi> <4BEA3FF3CAA35E408EA55C7BE2E61D050D3FB020@xmail3.se.axis.com> <20080414184213.GB6695@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:30303 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765601AbYDOVT5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Apr 2008 17:19:57 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2140250fgb.17
        for <linux-ide@vger.kernel.org>; Tue, 15 Apr 2008 14:19:56 -0700 (PDT)
In-Reply-To: <20080414184213.GB6695@cs181133002.pp.htv.fi>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Mikael Starvik <mikael.starvik@axis.com>, Jesper Nilsson <Jesper.Nilsson@axis.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Monday 14 April 2008, Adrian Bunk wrote:
> On Mon, Apr 14, 2008 at 02:50:19PM +0200, Mikael Starvik wrote:
> > You can remove it for now and we will resubmit a new if/when we get around
> > to fix it.
> 
> Thanks for the confirmation.
> 
> > /Mikael
> 
> cu
> Adrian
> 
> BTW: If/When you'll get around to work on it, please consider using
>      libata instead.
> 
> 
> <--  snip  -->
> 
> 
> ETRAX_IDE was marked as broken last year with the comment
> "it doesn't even compile currently".
> 
> Remove it since it won't get fixed in the near future.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

applied

[ I ported the patch over IDE tree (it becomes honorable patch #250)
  so it deletes the most recent ide-cris version - even though the
  driver was marked as BROKEN I kept updating it and it is the best
  starting point if somebody would like to revive it in the future
  (or port it to libata). ]
