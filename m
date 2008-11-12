From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 5/5] storage-fixup: a Makefile
Date: Wed, 12 Nov 2008 14:28:31 +0900
Message-ID: <491A697F.8090808@kernel.org>
References: <200810290911.51961.kel@otaku42.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53185 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961AbYKLF2i (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Nov 2008 00:28:38 -0500
In-Reply-To: <200810290911.51961.kel@otaku42.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kel Modderman <kel@otaku42.de>
Cc: linux-ide@vger.kernel.org

Kel Modderman wrote:
> +dist: clean
> +	git-archive --format=tar --prefix=$(NAME)-$(VERSION)/ HEAD \
> +		$(FILES) | tar -C.. -xf -
> +	tar -czvf ../$(NAME)-$(VERSION).tar.gz -C.. $(NAME)-$(VERSION)/
> +	$(RM) -r ../$(NAME)-$(VERSION)/

Why untar and tar again?

-- 
tejun
