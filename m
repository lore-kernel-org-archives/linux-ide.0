From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 5/5] storage-fixup: a Makefile
Date: Mon, 17 Nov 2008 11:18:30 +0900
Message-ID: <4920D476.1060101@kernel.org>
References: <200810290911.51961.kel@otaku42.de> <491A697F.8090808@kernel.org> <200811170343.59740.kel@otaku42.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43951 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754906AbYKQCSv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Nov 2008 21:18:51 -0500
In-Reply-To: <200811170343.59740.kel@otaku42.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kel Modderman <kel@otaku42.de>
Cc: linux-ide@vger.kernel.org

Kel Modderman wrote:
> On Wednesday 12 November 2008 15:28:31 Tejun Heo wrote:
>> Kel Modderman wrote:
>>> +dist: clean
>>> +	git-archive --format=tar --prefix=$(NAME)-$(VERSION)/ HEAD \
>>> +		$(FILES) | tar -C.. -xf -
>>> +	tar -czvf ../$(NAME)-$(VERSION).tar.gz -C.. $(NAME)-$(VERSION)/
>>> +	$(RM) -r ../$(NAME)-$(VERSION)/
>> Why untar and tar again?
>>
> 
> Don't have a reason. This is probably better:
> ---
> dist: clean
> 	git-archive --format=tar --prefix=$(NAME)-$(VERSION)/ HEAD \
> 		$(FILES) | gzip > ../$(NAME)-$(VERSION).tar.gz

Updated to create tarball in the source directory as you never know
you'll have write access to .. && git-archive doesn't mind having extra
files lying around anyway.

Thanks.

-- 
tejun
