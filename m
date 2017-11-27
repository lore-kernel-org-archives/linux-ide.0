From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_pdc2027x : make pdc2027x_*_timing structures const
Date: Mon, 27 Nov 2017 11:49:50 -0800
Message-ID: <20171127194950.GN983427@devbig577.frc2.facebook.com>
References: <568091f7b46ee8c9f15ae5cbfe0b76d3a8c47022.1511608541.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <568091f7b46ee8c9f15ae5cbfe0b76d3a8c47022.1511608541.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: b.zolnierkie@samsung.com, sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sat, Nov 25, 2017 at 04:47:35PM +0530, Arvind Yadav wrote:
> Make these pdc2027x_*_timing structures const as it is never modified.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied to libata/for-4.15-fixes.

Thanks.

-- 
tejun
