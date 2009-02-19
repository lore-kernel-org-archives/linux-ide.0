From: Tejun Heo <tj@kernel.org>
Subject: Re: Add to storage-fixup.conf
Date: Thu, 19 Feb 2009 18:21:51 +0900
Message-ID: <499D24AF.2010408@kernel.org>
References: <200902111737.38582.fuhrmann.silvia@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55536 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752495AbZBSJVj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Feb 2009 04:21:39 -0500
In-Reply-To: <200902111737.38582.fuhrmann.silvia@t-online.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Silvia Fuhrmann <fuhrmann.silvia@t-online.de>
Cc: linux-ide@vger.kernel.org

Hello,

1. Which -B value works?

2. Can you please attach the output of smartctl -a on the drive?

3.  Can you please measure how much start_stop_count increases per
    hour if you don't change the configuration?

Thanks.

-- 
tejun
