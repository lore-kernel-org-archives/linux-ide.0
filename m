From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCHSET] implement and use port_task
Date: Tue, 07 Mar 2006 14:13:43 +0800
Message-ID: <440D2497.7050504@tw.ibm.com>
References: <11415401073423-git-send-email-htejun@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:55704 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751688AbWCGGNp
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Mar 2006 01:13:45 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k276DeuN010588
	for <linux-ide@vger.kernel.org>; Tue, 7 Mar 2006 01:13:40 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k276GS13186024
	for <linux-ide@vger.kernel.org>; Mon, 6 Mar 2006 23:16:28 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k276DcVv008100
	for <linux-ide@vger.kernel.org>; Mon, 6 Mar 2006 23:13:39 -0700
In-Reply-To: <11415401073423-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Hi Jeff,
> 
> This patchset implements port_task and replace pio_task and
> packet_task with it.  port_task isn't very different from pio_task or
> packet_task - it's straight forward generalization.  The port_task is
> a per-port task avaliable to low level drivers which is managed by
> libata core layer.
> 
> Differences from pio/packet task.
> 
> * Not limited to PIO HSM implementation.  Other drivers can use it.
> 
> * Synchronization against EH core layer is done within libata core
>   layer, not in PIO HSM implementation (ata_qc_timeout()).
> 
> Thanks.
> 
> --
> tejun
> 

Something related to the PIO HSM.
After the task renaming by this patchset, the task name is changed from pio_task to port_task.
Should we add polling DMA support to the polling HSM?
It could make the polling HSM more complete.

Polling DMA does no performance gain. However, DMA has crc check,
so it won't be worse than PIO when irq is not working.

Albert


