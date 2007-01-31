From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] iomap: iomap should be in obj-y not in lib-y
Date: Wed, 31 Jan 2007 10:10:40 -0500
Message-ID: <45C0B170.8050901@pobox.com>
References: <20070131134806.GJ8606@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57398 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964852AbXAaPKn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Jan 2007 10:10:43 -0500
In-Reply-To: <20070131134806.GJ8606@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> devres change moved iomap.o from obj-$(CONFIG_GENERIC_IOMAP) to lib-y
> making it not linked if no in-kernel driver uses it.  Fix it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied

BTW can you update your scripts to email jeff@garzik.org ?  That's the 
primary email address I signoff with, etc.

jgarzik@pobox.com will continue to work for all eternity, but it makes 
Mozilla Thunderbird stupidly add an unneeded CC.

	Jeff



