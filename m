From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: pata_of_platform: using of_property_read_u32()
 helper
Date: Tue, 24 Jan 2017 11:15:53 -0500
Message-ID: <20170124161553.GD12281@htj.duckdns.org>
References: <1485259709-16487-1-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485259709-16487-1-git-send-email-wangkefeng.wang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-ide@vger.kernel.org

On Tue, Jan 24, 2017 at 08:08:29PM +0800, Kefeng Wang wrote:
> Using better of_property_read_u32() than generic of_get_property().
> 
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Applied to libata/for-4.11.

Thanks.

-- 
tejun
