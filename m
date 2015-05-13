From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] AHCI: Add generic MSI-X interrupt support to SATA PCI
 driver
Date: Wed, 13 May 2015 14:10:54 -0400
Message-ID: <20150513181054.GB11388@htj.duckdns.org>
References: <20150513143353.GU11388@htj.duckdns.org>
 <20150513143906.GV11388@htj.duckdns.org>
 <20150513172828.GA8449@rric.localhost>
 <20150513174640.GZ11388@htj.duckdns.org>
 <20150513180705.GZ10428@rric.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:35966 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbbEMSK6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 May 2015 14:10:58 -0400
Content-Disposition: inline
In-Reply-To: <20150513180705.GZ10428@rric.localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Richter <robert.richter@caviumnetworks.com>
Cc: Robert Richter <rric@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Sunil Goutham <sgoutham@cavium.com>, Jiang Liu <jiang.liu@linux.intel.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Alexander Gordeev <agordeev@redhat.com>

Hello,

On Wed, May 13, 2015 at 08:07:05PM +0200, Robert Richter wrote:
> So I will move msix after msi then and mark it as a special case if
> msi is not supported. I don't want to move it after intx since this is
> the fallback if nothing else works, there is no explicit check for
> intx, I even don't know if that is possible at all.

Sure, that sounds good to me.

Thanks.

-- 
tejun
