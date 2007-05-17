From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide.c: microscopic size and readability optimization
Date: Thu, 17 May 2007 13:06:43 +0100
Message-ID: <20070517130643.39fbfe29@the-village.bc.nu>
References: <20070517112554.GA32183@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55523 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754962AbXEQMCJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 May 2007 08:02:09 -0400
In-Reply-To: <20070517112554.GA32183@zmei.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bbpetkov@yahoo.de
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

On Thu, 17 May 2007 13:25:54 +0200
Borislav Petkov <bbpetkov@yahoo.de> wrote:

> -----
> From: bbpetkov@yahoo.de
> 
> A very small size (object file 432 bytes smaller) and readability optimization of ide.c
> 
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>

Bad idea. Now you won't know which of the conditions caused the BUG() to
occur.

