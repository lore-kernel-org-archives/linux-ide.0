From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 4/4] pata_samsung: Add Samsung PATA controller driver
Date: Thu, 03 Jun 2010 09:25:24 +0900
Message-ID: <002101cb02b3$44d40be0$ce7c23a0$%kim@samsung.com>
References: <1274948524-2970-1-git-send-email-kgene.kim@samsung.com>
 <1274948524-2970-5-git-send-email-kgene.kim@samsung.com>
 <4BFE46C4.5030007@mvista.com>
 <002a01cb01fd$4cf10a50$e6d31ef0$%kim@samsung.com>
 <4C0629B7.4060300@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <4C0629B7.4060300@ru.mvista.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Sergei Shtylyov' <sshtylyov@mvista.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, 'Abhilash Kesavan' <a.kesavan@samsung.com>
List-Id: linux-ide@vger.kernel.org

Sergei Shtylyov wrote:
> 
> Hello.

Hi ;-)

> Kukjin Kim wrote:
> 
> >>> From: Abhilash Kesavan <a.kesavan@samsung.com>
> >>> Adds support for the Samsung PATA controller. This driver is based on
the
> >>> Libata subsystem and references the earlier patches sent for IDE
subsystem.
> 
>     Where I those I wonder? :-)
>     It's a pity they didn't get accepted.
> 
Was told that that only new libata based drivers would be accepted.

> >>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> >>> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> 
> [...]
> 
> >>> +		for (i = 0; i < words; i++, temp_addr++) {
> >>> +			wait_for_host_ready(info);
> >>> +			writel(*temp_addr, data_addr);
> >>> +		}
> >>> +	}
> 
> >>     Well, if this is pere CF case, 'buflen' can't be odd, but otherwise
> 
>     I meant to type "pure". :-)
> 
considering CF in true-ide mode..should I still add the check?

> >> you should handle that case...
> 
> >>> +	uint pio_teoc[5] = { 240, 43, 10, 70, 25 };
> 
> >>     What timing is this? :-O
> 
> > Should have been t2i rec.
> 
>     If it's t2i timing, it is incorrect for the first 3 PIO modes.
> 
Should have been (240, 93, 40, 70, 25)

> >>> +	if (cpu_type == TYPE_S3C6400) {
> >>> +		ap->ops = &pata_s3c_port_ops;
> >>> +		info->sfr_addr = info->ide_addr + 0x1800;
> >>> +		info->ide_addr = info->ide_addr + 0x1900;
> >>> +		info->fifo_status_reg = 0x94;
> >>> +	} else if (cpu_type == TYPE_S5PC100) {
> >>> +		ap->ops = &pata_s5p_port_ops;
> >>> +		info->sfr_addr = info->ide_addr + 0x1800;
> >>> +		info->ide_addr = info->ide_addr + 0x1900;
> 
> >>     Does make sense to assign those before *if*.
> 
> > Offsets not required for S5PV210/S5PC110.
> 
>     pata_s3c_tune_chipset() certainly requires them.
> 
yes..but for V210/C110 just the ioremapped info->ide_addr with 0 offset is
enough.

> >>> +		info->fifo_status_reg = 0x84;
> >>> +	} else {
> >>> +		ap->ops = &pata_s5p_port_ops;
> 
> >>     You don't assign 'info->ide_addr' here but you'll need it in
> >> pata_s3c_tune_chipset() which will be called thru pata_s5p_port_ops!
> 
> > The address received at ioremap() is enough for S5PV210/S5PC110..no
offset
> > needed.
> 
>     I only have to restate that pata_s3c_tune_chipset() does use
> 'info->ide_addr'. Maybe you shouldn't install this method for
S5PV210/S5PC110?
> Or do you mean thgat offset of 0 will work?
> 
V210/C110 requires 0 offset as compared to 6410 and C100 which require
0x1800.

> >>> +release_mem:
> >>> +	release_mem_region(res->start, res->end - res->start + 1);
> 
> >>     But you didn't call request_mem_region()!
> 
> > I didn't..will remove.
> 
>     But you should call request_mem_region() in one or another form...
> 
OK..will request mem_region() before ioremap()..and then the release_mem's
should be fine.


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
