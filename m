From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: libata-pmp: Fix a possible data race in
 sata_pmp_handle_link_fail
Date: Tue, 8 May 2018 07:20:52 -0700
Message-ID: <20180508142052.GK2368884@devbig577.frc2.facebook.com>
References: <20180508082140.14038-1-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180508082140.14038-1-baijiaju1990@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, May 08, 2018 at 04:21:40PM +0800, Jia-Ju Bai wrote:
> The write operation to "link->flags" is protected by
> the lock on line 898, but the read operation to
> this data on line 892 is not protected by the lock.
> Thus, there may exist a data race for "link->flags".
> 
> To fix this data race, the read operation to "link->flags" 
> should be also protected by the lock.

Same as the previous patch.

Thanks.

-- 
tejun
