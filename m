From: kgene@kernel.org
Subject: RE: [PATCH 1/1] ata: pata_samsung_cf: Move plat/regs-ata.h to
 drivers/ata
Date: Sat, 04 Jan 2014 11:00:24 +0900
Message-ID: <22f301cf08f0$bb4eca70$31ec5f50$@kernel.org>
References: <1388467753-24431-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1388467753-24431-1-git-send-email-sachin.kamat@linaro.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Sachin Kamat' <sachin.kamat@linaro.org>, linux-ide@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, tj@kernel.org, patches@linaro.org
List-Id: linux-ide@vger.kernel.org

Sachin Kamat wrote:
> 
> plat/regs-ata.h is used only by Samsung PATA driver.
> Move this file to the drivers folder to remove platform
> dependency required for multiplatform support.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/ata/pata_samsung_cf.c                      |    2 +-
>  .../regs-ata.h => drivers/ata/pata_samsung_cf.h    |    9 ++++-----
>  2 files changed, 5 insertions(+), 6 deletions(-)
>  rename arch/arm/plat-samsung/include/plat/regs-ata.h =>
> drivers/ata/pata_samsung_cf.h (91%)
> 
I don't know we need to create header file into drivers/ata/ because the
header will be used for only pata_samsung_cf.c. But it's up to Tejun who is
a maintainer of SERIAL ATA ;-)

Thanks,
Kukjin
