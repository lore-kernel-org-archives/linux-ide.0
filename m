From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] ahci: Use pci_enable_msi_exact() instead of
 pci_enable_msi_range()
Date: Wed, 16 Apr 2014 16:02:52 -0400
Message-ID: <20140416200252.GH22569@htj.dyndns.org>
References: <cover.1396426390.git.agordeev@redhat.com>
 <aabd5aabbbbc79e5534a9922240c341c153d2156.1396426390.git.agordeev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:61805 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbaDPUC6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2014 16:02:58 -0400
Content-Disposition: inline
In-Reply-To: <aabd5aabbbbc79e5534a9922240c341c153d2156.1396426390.git.agordeev@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, Apr 02, 2014 at 10:19:57AM +0200, Alexander Gordeev wrote:
> The driver calls pci_enable_msi_range() function with the
> range of [nvec..nvec] which what pci_enable_msi_exact()
> function is for.
> 
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> Cc: linux-ide@vger.kernel.org

Please refresh this one after updating the first patch.

Thanks.

-- 
tejun
