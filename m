From: Kel Modderman <kel@otaku42.de>
Subject: Re: [PATCH 5/5] storage-fixup: a Makefile
Date: Mon, 17 Nov 2008 03:43:59 +1000
Message-ID: <200811170343.59740.kel@otaku42.de>
References: <200810290911.51961.kel@otaku42.de> <491A697F.8090808@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from venema.h4ckr.net ([217.24.1.135]:35791 "EHLO venema.h4ckr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751802AbYKPRoG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Nov 2008 12:44:06 -0500
In-Reply-To: <491A697F.8090808@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Wednesday 12 November 2008 15:28:31 Tejun Heo wrote:
> Kel Modderman wrote:
> > +dist: clean
> > +	git-archive --format=tar --prefix=$(NAME)-$(VERSION)/ HEAD \
> > +		$(FILES) | tar -C.. -xf -
> > +	tar -czvf ../$(NAME)-$(VERSION).tar.gz -C.. $(NAME)-$(VERSION)/
> > +	$(RM) -r ../$(NAME)-$(VERSION)/
> 
> Why untar and tar again?
> 

Don't have a reason. This is probably better:
---
dist: clean
	git-archive --format=tar --prefix=$(NAME)-$(VERSION)/ HEAD \
		$(FILES) | gzip > ../$(NAME)-$(VERSION).tar.gz
---

Thanks, Kel.
