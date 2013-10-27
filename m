From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/1] AHCI: disabled FBS prior to issuing software reset
Date: Sun, 27 Oct 2013 07:57:03 -0400
Message-ID: <20131027115703.GH14934@mtj.dyndns.org>
References: <CAP0P+NUQSByVNquY-zP3S-6GKhSvQXgq_4dDCTd2R8FM=YC_Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP0P+NUQSByVNquY-zP3S-6GKhSvQXgq_4dDCTd2R8FM=YC_Gg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: xiangliang yu <yxlraid@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, yuxiangl@marvell.com
List-Id: linux-ide@vger.kernel.org

Hello,

On Wed, Oct 16, 2013 at 11:36:20AM +0800, xiangliang yu wrote:
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 34c8216..fbe592f 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1266,9 +1266,11 @@ int ahci_do_softreset(struct ata_link *link,
> unsigned int *class,

Your patch is still completely white space corrupted.  Please check
your mail settings.  Using git-send-email is usually a good idea.  I'm
applying the patch manually this time but *please* make sure your mail
setup is working before posting things next time.

Thanks.

-- 
tejun
