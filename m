From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] sata_via: restore vt*_prepare_host error handling
Date: Mon, 03 Nov 2008 11:47:36 +0900
Message-ID: <490E6648.4020503@kernel.org>
References: <20081102211848.GA20785@joi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35123 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754150AbYKCCry (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Nov 2008 21:47:54 -0500
In-Reply-To: <20081102211848.GA20785@joi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marcin Slusarz <marcin.slusarz@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joseph Chan <JosephChan@via.com.tw>, Jeff Garzik <jgarzik@redhat.com>, linux-ide@vger.kernel.org

Marcin Slusarz wrote:
> commit b9d5b89b487517cbd4cb4702da829e07ef9e4432 (sata_via: fix support
> for 5287) accidently (?) removed vt*_prepare_host error handling - restore it
> 
> catched by gcc:
> drivers/ata/sata_via.c: In function 'svia_init_one':
> drivers/ata/sata_via.c:567: warning: 'host' may be used uninitialized in this function
> 
> Signed-off-by: Marcin Slusarz <marcin.slusarz@gmail.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Joseph Chan <JosephChan@via.com.tw>
> Cc: Jeff Garzik <jgarzik@redhat.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thank you.

-- 
tejun
