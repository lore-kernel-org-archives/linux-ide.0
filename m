From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] sata_nv: remove redundant pointers sdev0 and sdev1
Date: Mon, 2 Jul 2018 07:48:16 -0700
Message-ID: <20180702144816.GA533219@devbig577.frc2.facebook.com>
References: <20180702073022.10000-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180702073022.10000-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, Jul 02, 2018 at 08:30:22AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointers sdev0 and sdev1 are being assigned but are never used hence they
> are redundant and can be removed.
> 
> Cleans up clang warnings:
> warning: variable 'sdev0' set but not used [-Wunused-but-set-variable]
> warning: variable 'sdev1' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to libata/for-4.18-fixes.

Thanks.

-- 
tejun
