From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] AHCI: Remove obsolete Intel Lewisburg SATA RAID device
 IDs
Date: Sat, 27 Feb 2016 06:18:55 -0500
Message-ID: <20160227111855.GW3965@htj.duckdns.org>
References: <1456510192-27184-1-git-send-email-scott.lawson@intel.com>
 <20160227085154.GB26010@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:33520 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756315AbcB0LS4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Feb 2016 06:18:56 -0500
Content-Disposition: inline
In-Reply-To: <20160227085154.GB26010@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: scott.lawson@intel.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Feb 27, 2016 at 12:51:54AM -0800, Christoph Hellwig wrote:
> On Fri, Feb 26, 2016 at 10:09:52AM -0800, scott.lawson@intel.com wrote:
> > From: Scott Lawson <scott.lawson@intel.com>
> > 
> > These PCI device IDs have been removed from the Intel Lewisburg design
> > specification. They are no longer needed.
> 
> Let's keep them just in case..

Out of curiosity, any specific reasons to do so?

-- 
tejun
