From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: make ata_port_operations const
Date: Mon, 7 Aug 2017 08:07:27 -0700
Message-ID: <20170807150727.GD4050379@devbig577.frc2.facebook.com>
References: <1502101922-13313-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502101922-13313-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, b.zolnierkie@samsung.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello,

On Mon, Aug 07, 2017 at 04:02:02PM +0530, Bhumika Goyal wrote:
> Make ata_port_operations structures const as it is only stored in the
> inherits field of an ata_port_operations structure. Therefore make it
> const.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

How did you test the patch?

Thanks.

-- 
tejun
