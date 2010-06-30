From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Subject: Re: [PATCH v5] libata: pata_samsung: Add Samsung PATA controller
 driver
Date: Wed, 30 Jun 2010 12:40:44 +0200
Message-ID: <4C2B1F2C.9070705@gmail.com>
References: <1277809518-1122-1-git-send-email-kgene.kim@samsung.com> <4C2A3C62.4090101@gmail.com> <016f01cb1840$850c4ae0$8f24e0a0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <016f01cb1840$850c4ae0$8f24e0a0$%kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, jgarzik@redhat.com, sshtylyov@mvista.com, 'Abhilash Kesavan' <a.kesavan@samsung.com>
List-Id: linux-ide@vger.kernel.org

 Op 30-06-10 12:39, Kukjin Kim schreef:
> Maurus Cuelenaere wrote:
> Hi Maurus :-)

Hi Kukjin

>>  Op 29-06-10 13:05, Kukjin Kim schreef:
>>> From: Abhilash Kesavan <a.kesavan@samsung.com>
>>>
>>> Adds support for the Samsung PATA controller. This driver is based on the
>>> Libata subsystem and references the earlier patches sent for IDE subsystem.
>>>
>>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>>> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
>>> Cc: Ben Dooks <ben-linux@fluff.org>
<snip>
>>> +/*
>>> + * Waits until the IDE controller is able to perform next read/write
>>> + * operation to the disk. Needed for 64XX series boards only.
>>> + */
>>> +static int wait_for_host_ready(struct s3c_ide_info *info)
>>> +{
>>> +	ulong timeout;
>>> +	void __iomem *fifo_reg = info->ide_addr + info->fifo_status_reg;
>>> +
>> Shouldn't this have an if (type != S3C64XX) return 0; ?
>>
> Actually, wait_for_host_ready() is called only by pata_s3c_port_ops methods 

Oh, ok. Sorry for the noise.

-- 
Maurus Cuelenaere
