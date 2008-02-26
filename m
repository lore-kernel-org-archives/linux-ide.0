From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Sata-MV, Intergated Sata Device Support
Date: Mon, 25 Feb 2008 19:17:09 -0500
Message-ID: <47C35A85.3020307@garzik.org>
References: <1176673884.5109.30.camel@Desktop> <47C35203.20402@garzik.org> <47C3585D.8070701@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761600AbYBZAR0@vger.kernel.org>
In-Reply-To: <47C3585D.8070701@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, jon@ngndg.com, LKML <linux-kernel@vger.kernel.org>, Saeed Bishara <saeed@marvell.com>
List-Id: linux-ide@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
>> Jon Li wrote:
>>> Hello,
>>>
>>> I am curious as to whether there are plans to add support for integrated
>>> sata devices.  I personally want to add support for a 60x1C0 based
>>> device (pci:id = 0x5182).  I think adding support should be relatively
>>> simple, except for a few issues outlined below.
>>>
>>> In the original mvSata.c (ver3.4) that has 0x5182 support, the config
>>> space is as such:
>>>
>>> case MV_SATA_DEVICE_ID_5182:
>>>         pAdapter->numberOfChannels = MV_SATA_5182_PORT_NUM;
>>>         pAdapter->numberOfUnits = 1;
>>>         pAdapter->portsPerUnit = 2;
>>>         pAdapter->sataAdapterGeneration = MV_SATA_GEN_IIE;
>>>         /*The integrated sata core chip based on 60x1 C0*/
>>>         pAdapter->chipIs60X1C0 = MV_TRUE;
>>>         pAdapter->hostInterface = MV_HOST_IF_INTEGRATED;
>>>         pAdapter->mainMaskOffset = 0x20024; /*the iobaseaddress is
>>> 0x60000*/
>>>         pAdapter->mainCauseOffset = 0x20020;
>>>         break;
>>>
>>> I have not yet figured out how all these values are defined in sata-mv.c
>>> (ver 0.8).  Specifically, where do I define "numberOfChannels" which
>>> should equal 2, and "numberOfUnits" which obviously equals 1?
>>>
>>> I have a current config space (not completed) for sata-mv.c which is:
>>>
>>>     {  /* chip_5182 */
>>>         .sht        = &mv_sht,
>>>         .flags        = (MV_COMMON_FLAGS | MV_6XXX_FLAGS |
>>>                    MV_FLAG_DUAL_HC),
>>>         .pio_mask    = 0x1f,    /* pio0-4 */
>>>         .udma_mask    = 0x7f,    /* udma0-6 */
>>>         .port_ops    = &mv6_ops,
>>>     },
> ...
> 
> Saeed:  isn't this what your SOC patches already implemented for us?
> As near as I can tell, sata_mv now already has support for the 60x1C0.

Saeed's stuff didn't support PCI though, and Jon Li is definitely 
talking about PCI...

	Jeff
