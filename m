From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] AHCI: Remove obsolete Intel Lewisburg SATA RAID device
 IDs
Date: Fri, 11 Mar 2016 12:32:36 -0500
Message-ID: <20160311173236.GF24046@htj.duckdns.org>
References: <1456510192-27184-1-git-send-email-scott.lawson@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:33122 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932124AbcCKRci (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Mar 2016 12:32:38 -0500
Content-Disposition: inline
In-Reply-To: <1456510192-27184-1-git-send-email-scott.lawson@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: scott.lawson@intel.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Feb 26, 2016 at 10:09:52AM -0800, scott.lawson@intel.com wrote:
> From: Scott Lawson <scott.lawson@intel.com>
> 
> These PCI device IDs have been removed from the Intel Lewisburg design
> specification. They are no longer needed.
> 
> Signed-off-by: Scott Lawson <scott.lawson@intel.com>

Applied to libata/for-4.6.

Thanks.

-- 
tejun
