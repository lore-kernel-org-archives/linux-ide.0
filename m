From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] drivers/ata/libata-eh.c: fix unused variable warning
Date: Fri, 23 Apr 2010 08:30:28 +0200
Message-ID: <4BD13E84.2040204@kernel.org>
References: <1271858846-1706-1-git-send-email-antonf@turbolinux.com.cn> <20100421152404.62699040@lxorguk.ukuu.org.uk> <4BCF1247.8080508@gmail.com> <4BCFA50E.80800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51999 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753629Ab0DWGbI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Apr 2010 02:31:08 -0400
In-Reply-To: <4BCFA50E.80800@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fang Wenqi <anton.fang@gmail.com>
Cc: jgarzik@redhat.com, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, antonf@turbolinux.com.cn

On 04/22/2010 03:23 AM, Fang Wenqi wrote:
> Sorry that the title should be:
>  "fix uninitialized variable warning"
> 
> not
> "fix unused variable warning"
> 
> Need I re-send the patch mail ?

Yes, please do so.  gcc 4.4.1 generates a spurious warning on it too.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
