From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] drivers/ata/libata-eh.c: fix unused variable warning
Date: Fri, 23 Apr 2010 16:02:37 +0200
Message-ID: <4BD1A87D.6090101@kernel.org>
References: <1271858846-1706-1-git-send-email-antonf@turbolinux.com.cn> <20100421152404.62699040@lxorguk.ukuu.org.uk> <4BCF1247.8080508@gmail.com> <4BCFA50E.80800@gmail.com> <4BD13E84.2040204@kernel.org> <20100423064332.GA22988@shell.devel.redhat.com> <4BD145B0.8080102@kernel.org> <4BD1A62E.5070602@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56826 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757414Ab0DWODY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Apr 2010 10:03:24 -0400
In-Reply-To: <4BD1A62E.5070602@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Jeff Garzik <jgarzik@redhat.com>, Fang Wenqi <anton.fang@gmail.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, antonf@turbolinux.com.cn

On 04/23/2010 03:52 PM, Jeff Garzik wrote:
> Sorry, I should have also pointed out that a fix went upstream to Linus
> in the last batch of fixes...

Oh, as long as the annoying warning goes away, there's nothing to be
sorry about.  :-)

Thanks.

-- 
tejun
