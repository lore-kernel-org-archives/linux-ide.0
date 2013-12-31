From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/1] ata: pata_samsung_cf: Move plat/regs-ata.h to
 drivers/ata
Date: Tue, 31 Dec 2013 06:34:28 -0500
Message-ID: <20131231113428.GA3985@htj.dyndns.org>
References: <1388467753-24431-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1388467753-24431-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-ide@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, patches@linaro.org
List-Id: linux-ide@vger.kernel.org

On Tue, Dec 31, 2013 at 10:59:13AM +0530, Sachin Kamat wrote:
> plat/regs-ata.h is used only by Samsung PATA driver.
> Move this file to the drivers folder to remove platform
> dependency required for multiplatform support.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Applied to libata/for-3.14.

As this is only used by pata_samsung_cf.c, can you please follow up
with a patch to roll pata_samsung_cf.h into .c?  There's no point in
creating separate header files for stuff which isn't shared among
multiple files.

Thanks.

-- 
tejun
