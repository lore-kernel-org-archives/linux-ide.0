From: Jon Li <jon@ngndg.com>
Subject: Sata-MV, Intergated Sata Device Support
Date: Sun, 15 Apr 2007 16:51:24 -0500
Message-ID: <1176673884.5109.30.camel@Desktop>
Reply-To: jon@ngndg.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout11.yourhostingaccount.com ([65.254.253.92]:38984 "EHLO
	mailout11.yourhostingaccount.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754017AbXDOWOn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Apr 2007 18:14:43 -0400
Received: from mailscan09.yourhostingaccount.com ([10.1.15.9] helo=mailscan09.yourhostingaccount.com)
	by mailout11.yourhostingaccount.com with esmtp (Exim)
	id 1HdCch-0005sr-Ql
	for linux-ide@vger.kernel.org; Sun, 15 Apr 2007 17:51:03 -0400
Received: from authsmtp11.yourhostingaccount.com ([10.1.18.11] ident=exim)
	by mailscan09.yourhostingaccount.com with spamscanlookuphost (Exim)
	id 1HdCch-00030A-M8
	for linux-ide@vger.kernel.org; Sun, 15 Apr 2007 17:51:03 -0400
Received: from authsmtp11.yourhostingaccount.com ([10.1.18.11] helo=authsmtp11.yourhostingaccount.com)
	by mailscan09.yourhostingaccount.com with esmtp (Exim)
	id 1HdCch-000304-82
	for linux-ide@vger.kernel.org; Sun, 15 Apr 2007 17:51:03 -0400
Received: from adsl-71-147-38-110.dsl.emhril.sbcglobal.net ([71.147.38.110] helo=[192.168.12.143])
	by authsmtp11.yourhostingaccount.com with esmtpa (Exim)
	id 1HdCcg-0003Ga-W2
	for linux-ide@vger.kernel.org; Sun, 15 Apr 2007 17:51:03 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I am curious as to whether there are plans to add support for integrated
sata devices.  I personally want to add support for a 60x1C0 based
device (pci:id = 0x5182).  I think adding support should be relatively
simple, except for a few issues outlined below.

In the original mvSata.c (ver3.4) that has 0x5182 support, the config
space is as such:

case MV_SATA_DEVICE_ID_5182:
        pAdapter->numberOfChannels = MV_SATA_5182_PORT_NUM;
        pAdapter->numberOfUnits = 1;
        pAdapter->portsPerUnit = 2;
        pAdapter->sataAdapterGeneration = MV_SATA_GEN_IIE;
        /*The integrated sata core chip based on 60x1 C0*/
        pAdapter->chipIs60X1C0 = MV_TRUE;
        pAdapter->hostInterface = MV_HOST_IF_INTEGRATED;
        pAdapter->mainMaskOffset = 0x20024; /*the iobaseaddress is
0x60000*/
        pAdapter->mainCauseOffset = 0x20020;
        break;

I have not yet figured out how all these values are defined in sata-mv.c
(ver 0.8).  Specifically, where do I define "numberOfChannels" which
should equal 2, and "numberOfUnits" which obviously equals 1?

I have a current config space (not completed) for sata-mv.c which is:

	{  /* chip_5182 */
		.sht		= &mv_sht,
		.flags		= (MV_COMMON_FLAGS | MV_6XXX_FLAGS |
				   MV_FLAG_DUAL_HC),
		.pio_mask	= 0x1f,	/* pio0-4 */
		.udma_mask	= 0x7f,	/* udma0-6 */
		.port_ops	= &mv6_ops,
	},

I believe according to the new structure in sata-mv.c,
HC_MAIN_IRQ_CAUSE_OFS should equal 0x20020 and HC_MAIN_IRQ_MASK_OFS
should equal 0x20024 for the 0x5182 device.

My final question is how to implement the MV_HOST_IF_INTEGRATED flag?
Is this already implemented and renamed in sata-mv.c?  Or do I need to
also add the routines?


Thanks in advance.


Regards,
-- 
Jon Li <jon@ngndg.com>
Next Generation NAS Development Group

