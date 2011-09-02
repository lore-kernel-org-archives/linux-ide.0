From: Mark Lord <mlord@pobox.com>
Subject: Re: Decoding marvel + Sil PMP errors / NCQ disabled due to excessive
 errors / 1.5G downgrade
Date: Fri, 02 Sep 2011 19:09:24 -0400
Message-ID: <4E616224.5040009@pobox.com>
References: <20110831022005.GI19892@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39519 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756464Ab1IBXJZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Sep 2011 19:09:25 -0400
In-Reply-To: <20110831022005.GI19892@merlins.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc MERLIN <marc@merlins.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>

On 11-08-30 10:20 PM, Marc MERLIN wrote:
> Hi Mark and Tejun,
> 
> Would you have any idea of what I'm seeing here?
> 
> This is with kernel 3.0.1,
> 02:00.0 SCSI storage controller: Marvell Technology Group Ltd. 88SX7042 PCI-e 4-port SATA-II (rev 02)
> 
> and a Sil PMP.
...

At present, I don't think either of my PMPs work with any of my SATA controllers
using recent kernels.  They all used to work back in the 2.6.2x kernels,
and I have not reloaded one of those to retest with (due to lack of ext4 in those).

Something's just not right in PMP land.
The same PMPs work fine on the same hardware in WinXP.

I wonder what we're missing?

I'm also travelling without internet access for the next month.  :)
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
