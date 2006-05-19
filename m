From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFT] major libata update
Date: Fri, 19 May 2006 20:03:32 +0900
Message-ID: <446DA604.8040207@gmail.com>
References: <20060515170006.GA29555@havoc.gtf.org>	<20060516190507.35c1260f.akpm@osdl.org>	<446AAB3C.6050303@gmail.com> <20060516215610.2b822c00.akpm@osdl.org> <446AB12C.10001@gmail.com> <446AC418.4070704@gmail.com> <446C5957.9040404@tw.ibm.com> <446C5B83.9000305@gmail.com> <446D9FCD.5050907@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.202]:58924 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932262AbWESLDj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 May 2006 07:03:39 -0400
Received: by nz-out-0102.google.com with SMTP id 8so603239nzo
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2006 04:03:39 -0700 (PDT)
In-Reply-To: <446D9FCD.5050907@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Andrew Morton <akpm@osdl.org>, jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org, Doug Maxey <dwm@maxeymade.com>

Albert Lee wrote:
> Checked the Promise 20275 manual, no device present bits.
> 
> It seems we still need IDENTIFY DEVICE to identify the phantom slave.
> The IDE code uses polling for IDENTIFY DEVICE. (libata did the same.)
> Maybe we can also use polling for IDENTIFY DEVICE?
> 
> Could you try the attached patch to see if polling helps
> to reduce the boot time? Thanks.
> 
> --
> albert
> (Need some time to find the specific IBM DVD-RAM drive for bug verification...)
> 
> --- upstream0/drivers/scsi/libata-core.c	2006-05-16 11:08:49.000000000 +0800
> +++ 300_phantom_device/drivers/scsi/libata-core.c	2006-05-19 17:37:23.000000000 +0800
> @@ -1194,6 +1194,9 @@ static int ata_dev_read_id(struct ata_de
>  
>  	tf.protocol = ATA_PROT_PIO;
>  
> +	/* Use polling for early detection of phantom device 1 */
> +	tf.flags |= ATA_TFLAG_POLLING;
> +
>  	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_FROM_DEVICE,
>  				     id, sizeof(id[0]) * ATA_ID_WORDS);
>  	if (err_mask) {
> 

Great, it worked.  Here's the relevant part of log w/ both ATA_DEBUG and 
ATA_VERBOSE_DEBUG on.  Although it tries several times but all those are 
slightly over 15secs, so it's quite usable.

[ata_eh_recover      ] ENTER
[__ata_port_freeze   ] ata1 port frozen
[piix_sata_prereset  ] ata1: ENTER, pcs=0x1f base=0
[piix_sata_prereset  ] ata1: LEAVE, pcs=0x1b present_mask=0x1
[ata_std_softreset   ] ENTER
[ata_std_softreset   ] about to softreset, devmask=3
[ata_bus_softreset   ] ata1: bus reset via SRST
[ata_dev_classify    ] found ATAPI device by sig
[ata_dev_classify    ] found ATAPI device by sig
[ata_std_softreset   ] EXIT, classes[0]=3 [1]=3
[ata_std_postreset   ] ENTER
[ata_std_postreset   ] EXIT
[ata_eh_thaw_port    ] ata1 port thawed
[ata_eh_revalidate_and_attach] ENTER
[ata_dev_read_id     ] ENTER, host 1, dev 0
[ata_dev_select      ] ENTER, ata1: device 0, wait 1
[ata_dev_select      ] ENTER, ata1: device 0, wait 1
[ata_exec_command_pio] ata1: cmd 0xA1
[ata_hsm_move        ] ata1: protocol 2 task_state 2 (dev_stat 0x5A)
[ata_pio_sector      ] data read
[ata_hsm_move        ] ata1: protocol 2 task_state 3 (dev_stat 0x50)
[ata_hsm_move        ] ata1: dev 0 command complete, drv_stat 0x50
[ata_port_flush_task ] ENTER
[ata_port_flush_task ] flush #1
[ata_port_flush_task ] flush #2
[ata_port_flush_task ] EXIT
[ata_dev_configure   ] ENTER, host 1, dev 0
[ata_dump_id         ] 49==0x0f00  53==0x0006  63==0x0007  64==0x0003 
75==0x0000
[ata_dump_id         ] 80==0x0078  81==0x0000  82==0x0000  83==0x0000 
84==0x0000
[ata_dump_id         ] 88==0x101f  93==0x4101
ata1.00: ATAPI, max UDMA/66
ata1.00: applying bridge limits
[ata_dev_configure   ] EXIT, drv_stat = 0x50
[ata_dev_read_id     ] ENTER, host 1, dev 1
[ata_dev_select      ] ENTER, ata1: device 1, wait 1
[ata_dev_select      ] ENTER, ata1: device 1, wait 1
[ata_exec_command_pio] ata1: cmd 0xA1
[ata_hsm_move        ] ata1: protocol 2 task_state 2 (dev_stat 0x0)
[ata_hsm_move        ] ata1: protocol 2 task_state 4 (dev_stat 0x0)
[__ata_port_freeze   ] ata1 port frozen
[ata_port_flush_task ] ENTER
[ata_port_flush_task ] flush #1
[ata_port_flush_task ] flush #2
[ata_port_flush_task ] EXIT
ata1.01: failed to IDENTIFY (I/O error, err_mask=0x2)
[ata_eh_revalidate_and_attach] EXIT
ata1: failed to recover some devices, retrying in 5 secs

-- 
tejun
