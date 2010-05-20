From: Tejun Heo <tj@kernel.org>
Subject: Re: Fwd: CF card I/O errors on Linux
Date: Thu, 20 May 2010 11:50:36 +0200
Message-ID: <4BF505EC.5030102@kernel.org>
References: <7B56DFFC-819E-46BA-9D06-B9AB97144AD6@usgs.gov> <291D4AE0-82BE-44F8-9AF0-209433D9FA39@usgs.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37320 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752751Ab0ETJvR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 May 2010 05:51:17 -0400
In-Reply-To: <291D4AE0-82BE-44F8-9AF0-209433D9FA39@usgs.gov>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Larry Baker <baker@usgs.gov>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hello,

On 05/12/2010 11:19 PM, Larry Baker wrote:
> 1.  I needed to see more of the IDENTIFY DEVICE response, so I modified
> the probe printout to include words 47, 49, 59, and 80-88, like this:
> 
> -                   "%s: cfg 49:%04x 82:%04x 83:%04x 84:%04x "
> -                   "85:%04x 86:%04x 87:%04x 88:%04x\n",
> +                   "%s: cfg 47:%04x 49:%04x 59:%04x "
> +                    "80-88:%04x %04x %04x %04x %04x %04x %04x %04x
> %04x\n",
>                     __func__,
> -                   id[49], id[82], id[83], id[84],
> -                   id[85], id[86], id[87], id[88]);
> +                   id[47], id[49], id[59], id[80], id[81], id[82],
> +                    id[83], id[84], id[85], id[86], id[87], id[88]);

I think it would be better to include a module parameter which makes
libata dump the whole thing.  The message is only useful for
development and debugging anyway.  I'll add such an option.

> 2.  The device I was having trouble with claims to support multi-sector
> transfers, with a maximum Sector Count of 1.  There's not much point
> then, is there?  I suggest adding a test for max >= 2 in the conditional
> where dev->multi_count is assigned:
> 
>         /* get current R/W Multiple count setting */
>         if ((dev->id[47] >> 8) == 0x80 && (dev->id[59] & 0x100)) {
>             unsigned int max = dev->id[47] & 0xff;
>             unsigned int cnt = dev->id[59] & 0xff;
> +            /* no point unless max >= 2 */
> +            if (max >= 2)
>             /* only recognize/allow powers of two here */
>             if (is_power_of_2(max) && is_power_of_2(cnt))
>                 if (cnt <= max)
>                     dev->multi_count = cnt;
>         }

Yeap, this does make sense.  Sergei, Alan, what do you guys think?

> 3.  In the error recovery code (in libata-eh.c?), I suggest a way to
> recover for devices like the one I've got that improperly implement
> READ/WRITE MULTI commands:
> 
> If the failed command is one of the READ/WRITE MULTI commands (entries
> 0-4 in ata_rw_cmds[]), and the device response is ABORT, use your
> HORKAGE mechanism to set a flag like ATA_HORKAGE_BROKEN_MULTI to skip
> setting dev->multi_count in libata-core.c (the code in 2., above), i.e.,
> disable multi-sector transfers, then reconfigure the device to disable
> multi-sector transfers (call ata_dev_configure(), I guess, so the new
> configuration gets printed out in dmesg) and retry the transfer.  Any
> future calls to ata_dev_configure() for that device will not attempt to
> enable multi-sector transfers because the ATA_HORKAGE_BROKEN_MULTI is set:
> 
> +        /* don't try to enable R/W multi if it is broken */
> +        if (!(dev->horkage & ATA_HORKAGE_BROKEN_MULTI))

So, turn off MULTI on ABORT....  Oh yeah, I can add that to the
existing speed down logic.  Would you be available to test patches?

Thanks.

-- 
tejun
