From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [IDE] Fix build bug
Date: Thu, 25 Oct 2007 15:47:16 +0100 (BST)
Message-ID: <Pine.LNX.4.64N.0710251545300.24086@blysk.ds.pg.gda.pl>
References: <20071025135334.GA23272@linux-mips.org> <20071025141305.GA11698@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:38040 "EHLO
	cerber.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755399AbXJYOrZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 10:47:25 -0400
In-Reply-To: <20071025141305.GA11698@uranus.ravnborg.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-mips@linux-mips.org

On Thu, 25 Oct 2007, Sam Ravnborg wrote:

> So we can avoid this if we invent a __constinitdata tag that uses
> a new section?

 That would do.

> I ask mainly to understand this error - not that I am that found
> of the idea.

 Somebody wants to mix up read-only and read/write data in the same 
section and GCC quite legitimately complains about it.  You cannot have 
both at a time.

  Maciej
