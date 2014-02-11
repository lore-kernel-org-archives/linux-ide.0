From: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH 1/1] libata: Get rid of ata_port::qc_allocated bitmask
Date: Tue, 11 Feb 2014 09:40:40 +0100
Message-ID: <20140211084039.GC16680@dhcp-26-207.brq.redhat.com>
References: <cover.1390315528.git.agordeev@redhat.com>
 <b6f797f22591ef592bf17aefa0b359bd03953a2e.1390315528.git.agordeev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:22712 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbaBKIiq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Feb 2014 03:38:46 -0500
Content-Disposition: inline
In-Reply-To: <b6f797f22591ef592bf17aefa0b359bd03953a2e.1390315528.git.agordeev@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, "Nicholas A. Bellinger" <nab@linux-iscsi.org>

On Tue, Jan 21, 2014 at 04:02:26PM +0100, Alexander Gordeev wrote:
> Scanning ata_port::qc_allocated bitmask for free tags has
> been a performance bottleneck due to the cache line bouncing.
> This update replaces ata_port::qc_allocated bitmask with
> optimized for parallel access percpu_ida tags allocator.

Hi Tejun,

There is a discussion about imperfect percpu_ida handling of low nr of tags.
I think this change is too early to bring.

Thanks!

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
