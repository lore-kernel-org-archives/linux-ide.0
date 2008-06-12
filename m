From: "Justin Mattock" <justinmattock@gmail.com>
Subject: Re: macbook pro dvd playback after suspend Buffer I/O error
Date: Thu, 12 Jun 2008 05:22:17 +0000
Message-ID: <dd18b0c30806112222k60e411dfs98e4cc7f64938b5b@mail.gmail.com>
References: <dd18b0c30804032207u36bd1f43l358e9949f0c94f79@mail.gmail.com>
	 <484F31B8.8030001@gmail.com>
	 <dd18b0c30806110045s6d19a034yd89b892441bd1621@mail.gmail.com>
	 <dd18b0c30806111131gc1b506cva12f577ebb4afdf9@mail.gmail.com>
	 <485048EC.2080608@gmail.com>
	 <dd18b0c30806111527x22fa895em230ceade4712f073@mail.gmail.com>
	 <4850794F.3000200@gmail.com>
	 <dd18b0c30806111910j4b127c32rbd546f885731e18c@mail.gmail.com>
	 <dd18b0c30806111913gf505c05j479a6a682c2cdd28@mail.gmail.com>
	 <4850A2F8.3050404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:47825 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbYFLFWU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jun 2008 01:22:20 -0400
Received: by an-out-0708.google.com with SMTP id d40so823559and.103
        for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2008 22:22:17 -0700 (PDT)
In-Reply-To: <4850A2F8.3050404@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thu, Jun 12, 2008 at 4:15 AM, Tejun Heo <htejun@gmail.com> wrote:
> Hello,
>
> Please do the followings.
>
> 1. apply the attached patch
> 2. turn on device drivers -> SCSI -> SCSI verbose logging
> 3. rebuild the kernel and boot the new kernel.
> 4. run "sysctl -w dev.scsi.logging_level=1"
> 5. run the suspend/resume test w/ dd and report the result.
>
> Thanks.
>
> --
> tejun
>
> ---
>  drivers/ata/libata-eh.c |    6 ++++++
>  1 file changed, 6 insertions(+)
>
> Index: work/drivers/ata/libata-eh.c
> ===================================================================
> --- work.orig/drivers/ata/libata-eh.c
> +++ work/drivers/ata/libata-eh.c
> @@ -2507,6 +2507,9 @@ static int atapi_eh_clear_ua(struct ata_
>                        return -EIO;
>                }
>
> +               ata_dev_printk(dev, KERN_WARNING, "XXX: TUR err_mask=0x%x sense_key=0x%x\n",
> +                              err_mask, sense_key);
> +
>                if (!err_mask || sense_key != UNIT_ATTENTION)
>                        return 0;
>
> @@ -2516,6 +2519,9 @@ static int atapi_eh_clear_ua(struct ata_
>                                "UNIT ATTENTION (err_mask=0x%x)\n", err_mask);
>                        return -EIO;
>                }
> +
> +               ata_dev_printk(dev, KERN_WARNING, "XXX: REQUEST SENSE err_mask=0x%x ASC=0x%x ASCQ=0x%x\n",
> +                              err_mask, sense_buffer[12], sense_buffer[13]);
>        }
>
>        ata_dev_printk(dev, KERN_WARNING,
>
>

Alright; I'll let you know what happens.
regards;

-- 
Justin P. Mattock
