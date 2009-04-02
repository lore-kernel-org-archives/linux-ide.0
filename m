From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] tx4939ide: remove wmb()
Date: Thu, 2 Apr 2009 21:18:52 +0200
Message-ID: <200904022118.52909.bzolnier@gmail.com>
References: <1238516136-15852-1-git-send-email-anemo@mba.ocn.ne.jp> <da824cf30903310936p75469518j9bb28421b1ee81b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:46047 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761155AbZDBTgk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Apr 2009 15:36:40 -0400
In-Reply-To: <da824cf30903310936p75469518j9bb28421b1ee81b8@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-ide@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org

On Tuesday 31 March 2009, Grant Grundler wrote:
> On Tue, Mar 31, 2009 at 9:15 AM, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > * define CHECK_DMA_MASK
> > * remove use of wmb()
> >
> > Suggested-by: Grant Grundler <grundler@google.com>
> 
> Thank you for the attribution!
> 
> But I think proper header would be:
>     Reported-by: Grant Grundler <grundler@google.com>
> 
> But in this case, since i've looked at the code and am under the
> illusion I understand it, I'm comfortable with:
>     Reviewed-by: Grant Grundler <grundler@google.com>

Well, you can have both! ;)
