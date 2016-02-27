From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC] AHCI: Remove conflicting Intel Lewisburg 3rd-party SATA
 RAID device IDs
Date: Sat, 27 Feb 2016 00:51:29 -0800
Message-ID: <20160227085129.GA26010@infradead.org>
References: <1456510169-27138-1-git-send-email-scott.lawson@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:41914 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316AbcB0Ivb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Feb 2016 03:51:31 -0500
Content-Disposition: inline
In-Reply-To: <1456510169-27138-1-git-send-email-scott.lawson@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: scott.lawson@intel.com
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Feb 26, 2016 at 10:09:29AM -0800, scott.lawson@intel.com wrote:
> From: Scott Lawson <scott.lawson@intel.com>
> 
> These PCI device IDs in the AHCI driver conflict with proprietary drivers,
> preventing them from loading.

And that's a good thing!
