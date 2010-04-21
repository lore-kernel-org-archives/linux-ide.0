From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] 2.6.34-rc3 v2 Disable R_OK (Early ACK) on SII 3726 PMP
Date: Wed, 21 Apr 2010 12:42:57 +0200
Message-ID: <4BCED6B1.8060006@kernel.org>
References: <g2ida824cf31004141843p41f7b21fz25927e3c6faeeed7@mail.gmail.com> <l2jda824cf31004201352y5fcdfa40g2ecb5dbb1706bf88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39136 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751789Ab0DVIab (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Apr 2010 04:30:31 -0400
In-Reply-To: <l2jda824cf31004201352y5fcdfa40g2ecb5dbb1706bf88@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Linux IDE mailing list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>

Hello,

On 04/20/2010 10:52 PM, Grant Grundler wrote:
> ping? Can this patch please be applied?
> 
> I was assuming this will show up here:
>    http://git.kernel.org/?p=linux/kernel/git/jgarzik/libata-dev.git;a=shortlog;h=refs/heads/upstream-linus

This one should be applied to libata-dev.git/upstream which will be
merged into mainline during the next merge window.  I don't think
anything has changed in the PMP area since the merge window, so that
patch should apply to #upstream without too much problem (can't check
now).  Jeff, can you please apply this to #upstream?

Thanks.

-- 
tejun
