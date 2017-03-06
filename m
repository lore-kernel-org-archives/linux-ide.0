From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] Delete redundant return value check of
 platform_get_resource()
Date: Mon, 6 Mar 2017 15:41:22 -0500
Message-ID: <20170306204122.GD26127@htj.duckdns.org>
References: <20170227214118.GA2895@belen-VirtualBox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170227214118.GA2895@belen-VirtualBox>
Sender: linux-kernel-owner@vger.kernel.org
To: Belen Sarabia <belensarabia@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, Feb 27, 2017 at 10:41:18PM +0100, Belen Sarabia wrote:
> Delete error handling from the result of a call to platform_get_resource()
> when the value is immediately passed to devm_ioremap_resource().
> 
> Signed-off-by: Belen Sarabia <belensarabia@gmail.com>

Applied to libata/for-4.12.

Thanks.

-- 
tejun
