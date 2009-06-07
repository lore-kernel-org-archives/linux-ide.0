From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git pull] IDE fixes
Date: Sun, 7 Jun 2009 17:03:43 +0200
Message-ID: <200906071703.43285.bzolnier@gmail.com>
References: <200906071444.33047.bzolnier@gmail.com> <200906071632.30914.bzolnier@gmail.com> <20090607154048.07a7fb65@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:56176 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054AbZFGO6d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Jun 2009 10:58:33 -0400
In-Reply-To: <20090607154048.07a7fb65@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 07 June 2009 16:40:48 Alan Cox wrote:
> > If you want to discuss any code that I push upstream then *please* quote
> > it in your mails so we all can see what parts you question and discuss it
> > based on technical merits.
> 
> This isn't about technical merits - it is about *risk*. You don't submit

fs/partitions/check.c change doesn't influence anything other that behavior
of ide-gd driver and has been ACK-ed by Al Viro.

> patches to core code to add new features just before the final release.

This is not a feature but really a bug fix (requested by you along other
people in the past).
