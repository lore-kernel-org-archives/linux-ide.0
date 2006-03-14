From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/1] libata-dev: add flush task to ata_exec_internal()
Date: Tue, 14 Mar 2006 02:08:15 -0500
Message-ID: <44166BDF.4000702@pobox.com>
References: <44163628.2000001@tw.ibm.com> <44165EDC.3070800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:31908 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750887AbWCNHIU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Mar 2006 02:08:20 -0500
In-Reply-To: <44165EDC.3070800@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, IDE Linux <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Yes, we certainly need this. The irq handling isn't really correct 
> either as irq handlers don't clear interrupt conditions on spurious 
> interrupts. I hope/plan to address this during EH work.

Except for the HSM, there is no guaranteed way to know if an interrupt 
is spurious or not on many controllers, who lack an "I have an 
interrupt" bit.

	Jeff


