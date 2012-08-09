From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 03/13] ide: Potential null pointer dereference in
 ide_queue_pc_tail()
Date: Thu, 9 Aug 2012 15:13:42 +0100
Message-ID: <20120809151342.2941f851@pyramind.ukuu.org.uk>
References: <1344520529-19164-1-git-send-email-makienko@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:39017 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932262Ab2HIOJN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2012 10:09:13 -0400
In-Reply-To: <1344520529-19164-1-git-send-email-makienko@ispras.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marina Makienko <makienko@ispras.ru>
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@ispras.ru

On Thu,  9 Aug 2012 17:55:20 +0400
Marina Makienko <makienko@ispras.ru> wrote:

> The function blk_get_request() can return NULL in some cases. There are
> checks on it if function is called with argumetns one of which is
> GFP_ATOMIC/GFP_NOIO/etc. If system couldn't find request
> blk_get_request() return NULL.

drivers/ide is obsolete and scheduled for removal. I'm not sure messing
with it is remotely useful at this point ?
