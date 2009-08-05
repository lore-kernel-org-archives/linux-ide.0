From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] Soften up the dmesg on SB600 PMP softreset failure recovery
Date: Wed, 05 Aug 2009 11:20:57 +0900
Message-ID: <4A78EC89.7070609@kernel.org>
References: <1249438241.3583.5.camel@zm-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37366 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933041AbZHECVs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Aug 2009 22:21:48 -0400
In-Reply-To: <1249438241.3583.5.camel@zm-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shane.huang@amd.com
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, pgnet.dev@gmail.com

Shane Huang wrote:
> Too strong words led to spurious bug reports: Novell bugzilla #527748,
> RedHat bugzilla #468800. This patch is used to soften up the dmesg on
> SB600 PMP softreset failure recovery, so as to remove the scariness and
> concern from community.
> 
> Reported-by: pgnet Dev <pgnet.dev@gmail.com>
> Signed-off-by: Shane Huang <shane.huang@amd.com>
> Cc: Tejun Heo <tj@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
