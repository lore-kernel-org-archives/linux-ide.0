From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] AHCI: Move host activation code into ahci_host_activate()
Date: Mon, 29 Sep 2014 10:04:01 -0400
Message-ID: <20140929140401.GA15925@htj.dyndns.org>
References: <cover.1411648623.git.agordeev@redhat.com>
 <39cff5287f4fcc33d0f00f89cb2337c5a5ec22b6.1411648623.git.agordeev@redhat.com>
 <20140928160408.GA8050@mtj.dyndns.org>
 <20140929101846.GA8971@agordeev.usersys.redhat.com>
 <20140929101948.GB8971@agordeev.usersys.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140929101948.GB8971@agordeev.usersys.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, Sep 29, 2014 at 11:19:49AM +0100, Alexander Gordeev wrote:
> Currently host activation done by calling either function
> ahci_host_activate() or ata_host_activate(). Consolidate
> the code by only calling ahci_host_activate() for all AHCI
> devices.
> 
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> Cc: linux-ide@vger.kernel.org

I reverted 2-3.  Can you please respin the patches so that code
movement is separate from other changes?

Thanks.

-- 
tejun
