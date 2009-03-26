From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: bug in use-ide_pio_bytes patch?
Date: Thu, 26 Mar 2009 21:19:58 +0100
Message-ID: <200903262119.58966.bzolnier@gmail.com>
References: <49C72C1B.5080601@kernel.org> <200903231243.51078.bzolnier@gmail.com> <20090325091555.GA5073@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:64377 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754622AbZCZVTU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2009 17:19:20 -0400
Received: by mail-bw0-f169.google.com with SMTP id 17so746159bwz.37
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2009 14:19:18 -0700 (PDT)
In-Reply-To: <20090325091555.GA5073@liondog.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: Tejun Heo <tj@kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Wednesday 25 March 2009, Borislav Petkov wrote:
> On Mon, Mar 23, 2009 at 12:43:50PM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> > It seems like we really should remove "1:" but it would be best to retest
> > ide-floppy with this change.  Borislav, could you add this to your queue?
> 
> Done.
> 
> ---
> From: Borislav Petkov <petkovbb@gmail.com>
> Date: Wed, 25 Mar 2009 10:10:18 +0100
> Subject: [PATCH] ide-floppy: do not complete rq's prematurely
> 
> ... and access them afterwards. Simplify rq completing code while at it.
> 
> Spotted-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied, thanks!
