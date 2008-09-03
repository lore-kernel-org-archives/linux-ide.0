From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide/Kconfig: mark ide-scsi as deprecated
Date: Wed, 3 Sep 2008 19:43:55 +0200
Message-ID: <200809031943.55605.bzolnier@gmail.com>
References: <200808192111.45351.bzolnier@gmail.com> <20080903094402G.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:12899 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756163AbYICSPs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Sep 2008 14:15:48 -0400
Received: by mu-out-0910.google.com with SMTP id g7so2855816muf.1
        for <linux-ide@vger.kernel.org>; Wed, 03 Sep 2008 11:15:46 -0700 (PDT)
In-Reply-To: <20080903094402G.fujita.tomonori@lab.ntt.co.jp>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 03 September 2008, FUJITA Tomonori wrote:
> On Tue, 19 Aug 2008 21:11:44 +0200
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > Mark ide-scsi as deprecated and remove stale/bogus documentation.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> >  drivers/ide/Kconfig |   16 +---------------
> >  1 file changed, 1 insertion(+), 15 deletions(-)
> 
> Can we add ide-scsi to Documentation/feature-removal-schedule.txt?

Sure, care to send a patch?
