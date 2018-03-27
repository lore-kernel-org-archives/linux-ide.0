From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH][next] libata: ensure host is free'd on error exit paths
Date: Tue, 27 Mar 2018 06:57:05 -0700
Message-ID: <20180327135705.GK1840639@devbig577.frc2.facebook.com>
References: <20180327132601.12749-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180327132601.12749-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, Mar 27, 2018 at 02:26:01PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The host structure is not being kfree'd on two error exit paths
> leading to memory leaks. Add in new err_free label and kfree host.
> 
> Detected by CoverityScan, CID#1466103 ("Resource leak")
> 
> Fixes: 2623c7a5f279 ("libata: add refcounting to ata_host")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to libata/for-4.17.

Thanks.

-- 
tejun
