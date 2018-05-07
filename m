From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] driver core: add __printf verification to
 __ata_ehi_pushv_desc
Date: Mon, 7 May 2018 08:32:36 -0700
Message-ID: <20180507153236.GE2368884@devbig577.frc2.facebook.com>
References: <20180505200038.17840-1-malat@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180505200038.17840-1-malat@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Malaterre <malat@debian.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sat, May 05, 2018 at 10:00:37PM +0200, Mathieu Malaterre wrote:
> __printf is useful to verify format and arguments. Remove the following
> warning (with W=1):
> 
>   drivers/ata/libata-eh.c:183:10: warning: function might be possible candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to libata/for-4.17-fixes.

Thanks.

-- 
tejun
