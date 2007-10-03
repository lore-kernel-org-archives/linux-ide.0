From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 2/2] libata: change the last state of pio read to HSM_ST_IDLE
Date: Wed, 03 Oct 2007 12:13:50 +0800
Message-ID: <470316FE.2000406@tw.ibm.com>
References: <468B5930.3070000@tw.ibm.com> <468B5B3D.6040805@tw.ibm.com> <4702616B.1000402@garzik.org>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:48254 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbXJCEOV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Oct 2007 00:14:21 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l934E0SK012711
	for <linux-ide@vger.kernel.org>; Wed, 3 Oct 2007 00:14:00 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l934Dx1d437258
	for <linux-ide@vger.kernel.org>; Tue, 2 Oct 2007 22:13:59 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l934DxWK004509
	for <linux-ide@vger.kernel.org>; Tue, 2 Oct 2007 22:13:59 -0600
In-Reply-To: <4702616B.1000402@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: albertl@mail.com, Linux IDE <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Albert Lee wrote:
> 
>> Patch 2/2:
>>   After reading the last pio data block, the HSM is waiting for device
>> to be idle, not waiting for the last interrupt.
>>
>> This patch changes the state after "PIO data-in" to HSM_ST_IDLE instead
>> of HSM_ST_LAST for accuracy.
>>
>> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> 
> 
> Is this still needed?
> 

Not quite needed; it only makes the state transition after reading the
last PIO block more accurate.

However, if we want to do part of the irq PIO in the workqueue sometime
in the future, this patch will be needed (otherwise the HSM might think
it expecting another irq). For the time being, maybe we can just skip
this patch until sometime it's really needed.
--
albert


 


