From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes] libahci: fix result_tf handling after
 an ATA PIO data-in command
Date: Fri, 15 Oct 2010 10:45:17 +0200
Message-ID: <4CB8149D.4050707@kernel.org>
References: <4C9C3878.9010206@teksavvy.com>	<AANLkTi=85A9ueu9YYrh0jOKFgc+fqbaUhkRLt7=Bzx2M@mail.gmail.com>	<4C9C44D0.1030409@teksavvy.com>	<AANLkTinOECHi_7+y7yT-GZXxW0c4vrJOuRz80kejt2+N@mail.gmail.com>	<4C9CA385.5090709@teksavvy.com>	<4C9CA673.4090104@teksavvy.com>	<4C9D33C0.8050900@gmail.com>	<4CA99BCB.8080904@gmail.com>	<4CAA0885.8060906@teksavvy.com>	<4CAA0996.5080403@teksavvy.com>	<4CAA0F6C.6080609@teksavvy.com>	<4CAA21F4.5060000@teksavvy.com>	<4CAA2AA6.2010204@pobox.com>	<4CAA2C6F.2090603@teksavvy.com>	<4CAA2E16.4010905@pobox.com>	<4CAA3033.8030405@teksavvy.com>	<4CAACEBE.1000104@gmail.com>	<4CAB30FA.2010508@teksavvy.com>	<4CAB4CE9.9070709@gmail.com>	<AANLkTin=QWXcuy6JOi1y26dWH8FG1ji3JewTXu0K=4ri@mail.gmail.com>	<4CB6C50F.60609@kernel.org> <AANLkTi=FDPbo28+RL8FyY1v8O0kSac=snPMegV0bkz8
 3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55009 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752901Ab0JOIpm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Oct 2010 04:45:42 -0400
In-Reply-To: <AANLkTi=FDPbo28+RL8FyY1v8O0kSac=snPMegV0bkz83@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Mark Lord <kernel@teksavvy.com>, Seed <seedrubbish@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org

Hello,

On 10/15/2010 02:32 AM, Robert Hancock wrote:
>> +       if (qc->tf.protocol == ATA_PROT_PIO && qc->dma_dir == DMA_FROM_DEVICE &&
>> +           !(qc->flags & ATA_QCFLAG_FAILED))
>> +               qc->result_tf.command = (rx_fis + RX_FIS_PIO_SETUP)[15];
> 
> Shouldn't we be reading the entire TF from the PIO setup FIS and then
> just replacing the command register value with the E_Status field? It
> looks like that's the only field in the TF that's being set here.

Hmmm, yeah, probably that would be better.  I'll post the updated
version soon.

Thanks.

-- 
tejun
