From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 1/1] ata: pata_samsung_cf: Move plat/regs-ata.h to
 drivers/ata
Date: Thu, 02 Jan 2014 09:49:46 +0900
Message-ID: <001b01cf0754$88b7fc00$9a27f400$%han@samsung.com>
References: <1388467753-24431-1-git-send-email-sachin.kamat@linaro.org>
 <20131231113428.GA3985@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20131231113428.GA3985@htj.dyndns.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Sachin Kamat' <sachin.kamat@linaro.org>
Cc: 'Tejun Heo' <tj@kernel.org>, linux-ide@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, patches@linaro.org, 'Brian Norris' <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, 'Jingoo Han' <jg1.han@samsung.com>
List-Id: linux-ide@vger.kernel.org

On Tuesday, December 31, 2013 8:34 PM, Tejun Heo wrote:
> On Tue, Dec 31, 2013 at 10:59:13AM +0530, Sachin Kamat wrote:
> > plat/regs-ata.h is used only by Samsung PATA driver.
> > Move this file to the drivers folder to remove platform
> > dependency required for multiplatform support.
> >
> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> 
> Applied to libata/for-3.14.
> 
> As this is only used by pata_samsung_cf.c, can you please follow up
> with a patch to roll pata_samsung_cf.h into .c?  There's no point in
> creating separate header files for stuff which isn't shared among
> multiple files.

(+cc Brian Norris, linux-mtd mailing list)

Right, I also agree with Tejun's opinion.
Would you also send the patch to roll .h into .c for your another
patch "mtd: s3c2410: Move plat/regs-nand.h to drivers/mtd"?
(http://www.spinics.net/lists/linux-samsung-soc/msg25498.html)

Best regards,
Jingoo Han
