From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC] AHCI: Remove conflicting Intel Lewisburg 3rd-party SATA
 RAID device IDs
Date: Sat, 27 Feb 2016 06:20:33 -0500
Message-ID: <20160227112033.GX3965@htj.duckdns.org>
References: <1456510169-27138-1-git-send-email-scott.lawson@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:35083 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756176AbcB0LUf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Feb 2016 06:20:35 -0500
Content-Disposition: inline
In-Reply-To: <1456510169-27138-1-git-send-email-scott.lawson@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: scott.lawson@intel.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Feb 26, 2016 at 10:09:29AM -0800, scott.lawson@intel.com wrote:
> From: Scott Lawson <scott.lawson@intel.com>
> 
> These PCI device IDs in the AHCI driver conflict with proprietary drivers,
> preventing them from loading.

So, the default ahci driver can't attach if these PCI IDs are in use?
I don't think breaking the upstream kernel for a proprietary driver is
a good idea.

Thanks.

-- 
tejun
