From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 3/3] AHCI: Add generic MSI-X interrupt support to SATA
 PCI driver
Date: Fri, 5 Jun 2015 06:22:42 +0900
Message-ID: <20150604212242.GW20091@mtj.duckdns.org>
References: <1433073319-13796-1-git-send-email-rric@kernel.org>
 <1433073319-13796-4-git-send-email-rric@kernel.org>
 <20150603054422.GD20091@mtj.duckdns.org>
 <20150604090355.GC10428@rric.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150604090355.GC10428@rric.localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Richter <robert.richter@caviumnetworks.com>
Cc: Robert Richter <rric@kernel.org>, Sunil Goutham <sgoutham@cavium.com>, Jiang Liu <jiang.liu@linux.intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Hello, Robert.

On Thu, Jun 04, 2015 at 11:03:55AM +0200, Robert Richter wrote:
> I can't estimate the impact to other devices of this change (option
> 2). If you think this will be ok I will remove the check. But we could
> leave it in for the first time and remove it later once tested on such
> a device. Please let me know your opinion on this.

Yeah, let's just enable msix if supported.  If some devices are
broken, they need to be blacklisted anyway.

Thanks.

-- 
tejun
