From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 4/4] pata_samsung: Add Samsung PATA controller driver
Date: Wed, 02 Jun 2010 13:51:51 +0400
Message-ID: <4C0629B7.4060300@ru.mvista.com>
References: <1274948524-2970-1-git-send-email-kgene.kim@samsung.com> <1274948524-2970-5-git-send-email-kgene.kim@samsung.com> <4BFE46C4.5030007@mvista.com> <002a01cb01fd$4cf10a50$e6d31ef0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41056 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754928Ab0FBJws (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2010 05:52:48 -0400
In-Reply-To: <002a01cb01fd$4cf10a50$e6d31ef0$%kim@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: 'Sergei Shtylyov' <sshtylyov@mvista.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, 'Abhilash Kesavan' <a.kesavan@samsung.com>

Hello.

Kukjin Kim wrote:

>>> From: Abhilash Kesavan <a.kesavan@samsung.com>
>>> Adds support for the Samsung PATA controller. This driver is based on the
>>> Libata subsystem and references the earlier patches sent for IDE subsystem.

    Where I those I wonder? :-)
    It's a pity they didn't get accepted.

>>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>>> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

[...]

>>> +		for (i = 0; i < words; i++, temp_addr++) {
>>> +			wait_for_host_ready(info);
>>> +			writel(*temp_addr, data_addr);
>>> +		}
>>> +	}

>>     Well, if this is pere CF case, 'buflen' can't be odd, but otherwise

    I meant to type "pure". :-)

>> you should handle that case...

>>> +	uint pio_teoc[5] = { 240, 43, 10, 70, 25 };

>>     What timing is this? :-O

> Should have been t2i rec.

    If it's t2i timing, it is incorrect for the first 3 PIO modes.

>>> +	if (cpu_type == TYPE_S3C6400) {
>>> +		ap->ops = &pata_s3c_port_ops;
>>> +		info->sfr_addr = info->ide_addr + 0x1800;
>>> +		info->ide_addr = info->ide_addr + 0x1900;
>>> +		info->fifo_status_reg = 0x94;
>>> +	} else if (cpu_type == TYPE_S5PC100) {
>>> +		ap->ops = &pata_s5p_port_ops;
>>> +		info->sfr_addr = info->ide_addr + 0x1800;
>>> +		info->ide_addr = info->ide_addr + 0x1900;

>>     Does make sense to assign those before *if*.

> Offsets not required for S5PV210/S5PC110.

    pata_s3c_tune_chipset() certainly requires them.

>>> +		info->fifo_status_reg = 0x84;
>>> +	} else {
>>> +		ap->ops = &pata_s5p_port_ops;

>>     You don't assign 'info->ide_addr' here but you'll need it in
>> pata_s3c_tune_chipset() which will be called thru pata_s5p_port_ops!

> The address received at ioremap() is enough for S5PV210/S5PC110..no offset
> needed.

    I only have to restate that pata_s3c_tune_chipset() does use 
'info->ide_addr'. Maybe you shouldn't install this method for S5PV210/S5PC110? 
Or do you mean thgat offset of 0 will work?

>>> +release_mem:
>>> +	release_mem_region(res->start, res->end - res->start + 1);

>>     But you didn't call request_mem_region()!

> I didn't..will remove.

    But you should call request_mem_region() in one or another form...

MBR, Sergei
