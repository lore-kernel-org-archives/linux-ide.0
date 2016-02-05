From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] AHCI: Workaround for ThunderX Errata#22536
Date: Fri, 5 Feb 2016 12:04:23 -0500
Message-ID: <20160205170423.GE4401@htj.duckdns.org>
References: <1454539065-16891-1-git-send-email-tchalamarla@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:33071 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557AbcBEREY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Feb 2016 12:04:24 -0500
Content-Disposition: inline
In-Reply-To: <1454539065-16891-1-git-send-email-tchalamarla@caviumnetworks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tchalamarla@caviumnetworks.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello, Tirumalesh.

On Wed, Feb 03, 2016 at 02:37:45PM -0800, tchalamarla@caviumnetworks.com wrote:
> From: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
> 
> Due to Errata in some versions of ThunderX,
> HOST_IRQ_STAT is neither EDGE nor LEVEL,
> ThunderX needs a special sequence for handling interrupt.
> The patch attempts to satisfy the need.

Please take a look at the following patchset and coordinate with
Suman.

 http://lkml.kernel.org/g/1454620826-22554-2-git-send-email-stripathi@apm.com

Thanks.

-- 
tejun
