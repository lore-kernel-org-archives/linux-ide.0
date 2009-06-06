From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 0/2] ide-tape: fix flags
Date: Sat, 6 Jun 2009 19:58:36 +0200
Message-ID: <20090606175836.GA12865@liondog.tnic>
References: <1243926308-32385-1-git-send-email-petkovbb@gmail.com> <200906052034.06668.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:23012 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218AbZFFR6k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 6 Jun 2009 13:58:40 -0400
Content-Disposition: inline
In-Reply-To: <200906052034.06668.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jun 05, 2009 at 08:34:06PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 02 June 2009 09:05:06 Borislav Petkov wrote:
> > Hi Bart,
> > 
> > those fix a stupid flags misuse that got spotted by Jiri Slaby. Please
> > pay special attention to the first patch. FWIW, those can go as hot
> > fixes right away and we might catch 30-rc8 since it's not out yet.
> 
> The problem is that patches seem to be against ide-2.6.git/for-next...

Sh*t, this is hitting the broken buffer allocation that Tejun removed
(I'm getting the same OOM-kill as the one Tejun's mentioning here
http://marc.info/?l=linux-ide&m=124191711928890) so even with those
patches, ide-tape is still broken.

I'm guessing backport all of Tejun's ide-tape cleanup stuff after Linus
pulls them into 31-rc1?

-- 
Regards/Gruss,
    Boris.
