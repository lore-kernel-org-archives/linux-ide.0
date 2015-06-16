From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v5 0/2] ahci: Add generic MSI-X support for single
 interrupts to SATA PCI
Date: Tue, 16 Jun 2015 16:13:41 -0400
Message-ID: <20150616201341.GD22637@mtj.duckdns.org>
References: <1433526566-21136-1-git-send-email-rric@kernel.org>
 <20150616132434.GO10428@rric.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yh0-f47.google.com ([209.85.213.47]:32981 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157AbbFPUNp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Jun 2015 16:13:45 -0400
Content-Disposition: inline
In-Reply-To: <20150616132434.GO10428@rric.localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Richter <robert.richter@caviumnetworks.com>
Cc: Robert Richter <rric@kernel.org>, Sunil Goutham <sgoutham@cavium.com>, Jiang Liu <jiang.liu@linux.intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jun 16, 2015 at 03:24:34PM +0200, Robert Richter wrote:
> On 05.06.15 19:49:24, Robert Richter wrote:
> > From: Robert Richter <rrichter@cavium.com>
> > 
> > This patch set adds generic support for MSI-X interrupts to the SATA
> > PCI driver.
> > 
> > One patch does the generic change, the other add support for Cavium's
> > ThunderX host controller.
> 
> Tejun,
> 
> any comment on this?

Oops, sorry, the thread fell through the crack somehow.  I applied the
two patches to libata/for-4.2 with some comment edits on the first
patch.

Thanks!

-- 
tejun
