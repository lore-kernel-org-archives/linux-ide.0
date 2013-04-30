From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata updates
Date: Tue, 30 Apr 2013 16:18:10 -0700
Message-ID: <CA+55aFyGauCogyZojMp542kDJOMzumkjm3bR9iXP7=+4_aKs8g@mail.gmail.com>
References: <20130430222654.GA16716@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:48089 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933786Ab3D3XSL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Apr 2013 19:18:11 -0400
In-Reply-To: <20130430222654.GA16716@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, IDE-ML <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Tue, Apr 30, 2013 at 3:26 PM, Jeff Garzik <jeff@garzik.org> wrote:
>
> Summary:

return -EMISSINGDIFFSTAT;

I've pulled, but *please* make sure to fix your broken script. I
really do want to see the diffstat, partly because I want to know what
to expect even before pulling, partly just to verify that what I
pulled actually matches what you expected me to pull (iow, hopefully
you actually read your own diffstat and anything surprising would have
jumped out at you).

               Linus
