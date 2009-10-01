From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: kernel BUG at drivers/ide/ide-disk.c:187 (2.6.31)
Date: Thu, 1 Oct 2009 11:25:40 +0200
Message-ID: <200910011125.40081.bzolnier@gmail.com>
References: <20090930110529.GA3676@dis.manty.net> <200910011026.17510.elendil@planet.nl> <20091001.013030.98262804.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:39912 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736AbZJAJXq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Oct 2009 05:23:46 -0400
In-Reply-To: <20091001.013030.98262804.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: elendil@planet.nl, manty@manty.net, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thursday 01 October 2009 10:30:30 David Miller wrote:
> From: Frans Pop <elendil@planet.nl>
> Date: Thu, 1 Oct 2009 10:26:14 +0200
> 
> > Question for IDE maintainers: should maybe the old printing of request info 
> > be reinstated, or can the request flags also be obtained from the BUG 
> > info?
> 
> Using a BUG for this doesn't make it any easier to track down the
> problem.  WARN_ON_ONCE() or similar is much more appropriate here.
> 
> BUG() is for situations where the system's state is completely
> irrecoverably corrupted, and we cannot continue, and that is not the
> case here at all.

The problem is that you simply cannot know what is the system state here.

Thus when the unknown block layer request is encountered the best thing
you can do is to BUG early instead of allowing the situation when some
requests are silently dropped and possibly causing the data corruption.
