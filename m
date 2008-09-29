From: Tejun Heo <tj@kernel.org>
Subject: Re: Frequent head unloads  info
Date: Mon, 29 Sep 2008 16:30:09 +0900
Message-ID: <48E08401.6060808@kernel.org>
References: <op.uhjrgs2b70fqr1@blacktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41718 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207AbYI2Hbw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Sep 2008 03:31:52 -0400
In-Reply-To: <op.uhjrgs2b70fqr1@blacktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Vaselaar <andrew.vaselaar@trinity.edu>
Cc: linux-ide@vger.kernel.org

Andy Vaselaar wrote:
> 
> hdparm -B255 /dev/sda
> 
> seems to stop it from unloading the heads.

How much does the load_cycle_count increase per hour without the adjustment?

Thanks.

-- 
tejun
