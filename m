From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Re: [PATCH] : IDE-CS Add additional id string (corsair, 1GB)
Date: Tue, 16 Oct 2007 23:37:27 -0700
Message-ID: <20071016233727.bd36bcbf.Kristoffer.ericson@gmail.com>
References: <20071014210403.13d6f560.Kristoffer.Ericson@Gmail.com>
	<200710162135.51149.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.231]:25786 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934491AbXJPVhZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Oct 2007 17:37:25 -0400
Received: by qb-out-0506.google.com with SMTP id e11so2245520qbe
        for <linux-ide@vger.kernel.org>; Tue, 16 Oct 2007 14:37:23 -0700 (PDT)
In-Reply-To: <200710162135.51149.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 16 Oct 2007 21:35:51 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> On Monday 15 October 2007, Kristoffer Ericson wrote:
> > Greetings,
> > 
> > The manf string looks weird (0x0 + 0x0), but I assume its correct. Also,
> > whitespaces seems almost intentional, so am I missing something? 
> 
> Nope, thanks for cleaning this.
Ah, good.

> 
> > Shortlog:
> > This patch adds id strings for Corsair 1GB (identified as Hyperstone Model1)
> > inside legacy/ide-cs.c 
> > 
> > It also includes some minor whitespace cleanups.
> > 
> > Signed-off-by: Kristoffer Ericson <kristoffer.ericson@gmail.com>
> 
> applied
Thanks.
