From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [patch] move dereference after null check
Date: Tue, 10 Nov 2009 09:19:50 -0500
Message-ID: <1257862790.4184.203.camel@mulgrave.site>
References: <alpine.DEB.2.00.0911081949070.11108@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42505 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755393AbZKJOTw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Nov 2009 09:19:52 -0500
In-Reply-To: <alpine.DEB.2.00.0911081949070.11108@bicker>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: linux-ide@vger.kernel.org, davem@davemloft.net

On Tue, 2009-11-10 at 10:55 +0200, Dan Carpenter wrote:
> I moved the ops->inherits dereference below the null check.  I moved the 
> other assignment as well so that they would be together.
> 
> Found by smatch static checker.
> 
> regards,
> dan carpenter
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> --- orig/drivers/ata/libata-core.c	2009-11-08 19:40:18.000000000 +0200
> +++ devel/drivers/ata/libata-core.c	2009-11-08 19:42:06.000000000 +0200
> @@ -5938,13 +5938,14 @@
>  {
>  	static DEFINE_SPINLOCK(lock);
>  	const struct ata_port_operations *cur;
> -	void **begin = (void **)ops;
> -	void **end = (void **)&ops->inherits;

There's no problem here: this isn't a dereference.

James

