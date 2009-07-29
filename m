From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] Add AMD SB900 SATA/IDE controller device IDs
Date: Wed, 29 Jul 2009 13:02:03 +0900
Message-ID: <4A6FC9BB.5010107@kernel.org>
References: <1248838489.3470.7.camel@zm-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35318 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750701AbZG2EAF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Jul 2009 00:00:05 -0400
In-Reply-To: <1248838489.3470.7.camel@zm-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shane.huang@amd.com
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Shane Huang wrote:
> Update the patch with Tejun's request to add RAID comment.
> === CUT HERE ===

You usually put explanations like above which shouldn't go into commit
message below ---.

> Add AMD SB900 SATA/IDE controller device IDs.
> 
> Signed-off-by: Shane Huang <shane.huang@amd.com>
---
Like this.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
