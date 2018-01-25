From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: pata_pdc2027x: Replace mdelay with msleep
Date: Thu, 25 Jan 2018 07:30:55 -0800
Message-ID: <20180125153055.GE17457@devbig577.frc2.facebook.com>
References: <1516877105-13081-1-git-send-email-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1516877105-13081-1-git-send-email-baijiaju1990@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: b.zolnierkie@samsung.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Jan 25, 2018 at 06:45:05PM +0800, Jia-Ju Bai wrote:
> After checking all possible call chains to pdc_adjust_pll and
> pdc_detect_pll_input_clock,
> my tool finds that these functions are never called in atomic context,
> namely never in an interrupt handler or holding a spinlock.
> And their caller functions pdc2027x_init_one and pdc2027x_reinit_one 
> calls pci_enable_device which can sleep, and no spinlock is held when
> calling pdc_adjust_pll and pdc_detect_pll_input_clock,
> so it proves that pdc_adjust_pll and pdc_detect_pll_input_clock 
> can call functions which can sleep.
> Thus mdelay can be replaced with msleep to avoid busy wait.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied to libata/for-4.16.

Thanks.

-- 
tejun
