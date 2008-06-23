From: Tejun Heo <tj@kernel.org>
Subject: Re: FW: ICH10R PMP support
Date: Mon, 23 Jun 2008 18:56:38 +0900
Message-ID: <485F7356.5050605@kernel.org>
References: <023701c8d4dd$d737fa10$85a7ee30$@com> <485F6830.1040000@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41088 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752904AbYFWJ5E (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Jun 2008 05:57:04 -0400
In-Reply-To: <485F6830.1040000@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Milo Medin <medin@m2znetworks.com>, linux-ide@vger.kernel.org

Mark Lord wrote:
> I don't know anything about the 88SE6145 (isn't that an AHCI clone?),
> but the 7042 chip under Linux is *now* a very safe (and good) bet.
> 
> It has full kernel support for hot-plug, PMP with FIS-based switching,
> and employs a decent host command queue mechansim.  I believe all of the
> errata workarounds are now in place for this chip.
> 
> Performance is about as good as it gets under Linux,
> though there's still another microsecond or so to be shaved
> away from the IRQ handling in the next cycle.
> 
> Message-Switched-Interrupts (MSI) is there, but not fully supported yet.
> This also will likely get cleaned up in the next cycle.
> 
> The 7042 is the best of the Marvell chips, for Linux.

How high does it go bandwidth-wise?

Thanks.

-- 
tejun
