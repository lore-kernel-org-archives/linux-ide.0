From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: remove pmp link online check in FBS EH
Date: Sun, 9 Jun 2013 14:59:00 -0700
Message-ID: <20130609215900.GB8045@mtj.dyndns.org>
References: <1370678416-2133-1-git-send-email-shane.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1370678416-2133-1-git-send-email-shane.huang@amd.com>
Sender: stable-owner@vger.kernel.org
To: Shane Huang <shane.huang@amd.com>
Cc: Yu Liu <liuyu.ac@gmail.com>, linux-ide@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sat, Jun 08, 2013 at 04:00:16PM +0800, Shane Huang wrote:
> ata_link_online() check in ahci_error_intr() is unnecessary, it should
> be removed otherwise may lead to lockup with FBS enabled PMP.
> http://marc.info/?l=linux-ide&m=137050421603272&w=2
> 
> Reported-by: Yu Liu <liuyu.ac@gmail.com>
> Signed-off-by: Shane Huang <shane.huang@amd.com>
> Cc: stable@vger.kernel.org

Applied to libata/for-3.10-fixes.  Thanks.

-- 
tejun
