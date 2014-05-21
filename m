From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] sata_fsl: remove check for CONFIG_MPC8315_DS
Date: Wed, 21 May 2014 15:39:04 -0400
Message-ID: <20140521193904.GE5259@htj.dyndns.org>
References: <1400700937.30334.2.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1400700937.30334.2.camel@x220>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, May 21, 2014 at 09:35:37PM +0200, Paul Bolle wrote:
> A check for CONFIG_MPC8315_DS was added in v2.6.24. But the related
> Kconfig symbol was never added to the tree. So the code behind this
> check has effectively been dead for over six years. Remove it.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

Applied to libata/for-3.16.

Thanks.

-- 
tejun
