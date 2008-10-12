From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH 0/7] ide: locking improvements
Date: Sat, 11 Oct 2008 19:38:55 -0600
Message-ID: <48F1552F.7090600@shaw.ca>
References: <fa.Ke90oacfRjgiI4x5LejzjssRBEg@ifi.uio.no> <200810111756.37278.bzolnier@gmail.com> <20081011175617.GX19428@kernel.dk> <200810112046.23557.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:59499 "EHLO
	idcmail-mo1so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbYJLBjE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Oct 2008 21:39:04 -0400
In-Reply-To: <200810112046.23557.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, petkovbb@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> The work has already been done and it is a wortwhile work.  The risk is
> quite low (this is the statement based on rather deep understanding of
> IDE subsystem, the complete audit of all code-paths affected and all the
> testing experiences from Scalex86/me).
> 
> Moreover the patch won't be merged after few months of extra testing.
> 
> I feel that you still keep on questioning the point of improving IDE
> and insist on putting it into "bug-fixes only" mode.  If this is really
> the case I'm completely uninterested in discussing it any further.

What, exactly, is the point of making more than bug-fix-only changes to 
the IDE code today, when we have libata around which is a much better 
code base to work from? I'm afraid it still escapes me. I don't mean to 
denigrate the work that you and other people working on IDE are doing, 
but can't help but think there would be more productive outlets for it..
