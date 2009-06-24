From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [patch 6/6] ide: improve handling of Power Management requests
Date: Wed, 24 Jun 2009 03:36:33 +0200
Message-ID: <200906240336.33702.bzolnier@gmail.com>
References: <200906232335.57161.bzolnier@gmail.com> <20090623.162402.125952364.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:36042 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844AbZFXBsk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jun 2009 21:48:40 -0400
In-Reply-To: <20090623.162402.125952364.davem@davemloft.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 24 June 2009 01:24:02 David Miller wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date: Tue, 23 Jun 2009 23:35:56 +0200
> 
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] ide: improve handling of Power Management requests
> > 
> > Make hwif->rq point to PM request during PM sequence and do not allow
> > any other types of requests to slip in (the old comment was never correct
> > as there should be no such requests generated during PM sequence).
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> > This was tested in the past (with an additional testing from Borislav)
> > however there were block layer changes in the meantime so you may want
> > to give it some more testing time just to be sure.
> 
> In looking at this change, it occurs to me that this queue blocking
> facility could also be used to solve the user SET_XFER race.
> 
> Couldn't it?

Probably.  This is software, almost everything is possible.. ;)
