From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH/RFC 0/2] libata: legacy mode fixes
Date: Tue, 30 May 2006 11:36:33 +0800
Message-ID: <447BBDC1.8070300@tw.ibm.com>
References: <20060524165006.GC12022@harddisk-recovery.com> <4476947A.3020003@tw.ibm.com> <4476991E.5060506@tw.ibm.com> <44779702.5070407@pobox.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:61889 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751265AbWE3Dg7
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 23:36:59 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4U3awhZ018970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-ide@vger.kernel.org>; Mon, 29 May 2006 23:36:58 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k4U3awxZ189396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Mon, 29 May 2006 21:36:58 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k4U3avbH030068
	for <linux-ide@vger.kernel.org>; Mon, 29 May 2006 21:36:58 -0600
In-Reply-To: <44779702.5070407@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertl@mail.com, Erik Mouw <erik@harddisk-recovery.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, rene.herman@keyaccess.nl, Unicorn Chang <uchang@tw.ibm.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>

Jeff Garzik wrote:
> Albert Lee wrote:
> 
>> Dear all,
>>
>> Description:
>> This is the revised patch by Unicorn and I for legacy mode fix.
>>
>> patch 1/2: make both legacy ports share one host_set.
>> patch 2/2: remove the unused ap->hard_port_no.
> 
> 
> Unfortunately, NAK.
> 
> While it would be nice to eventually share one host_set, your patch
> demonstrates the hacks that must be added to the hot path, to deal with
> two separate interrupt handlers trying to share the same host_set.
> 
> Additionally, neither this email nor the two patches describes the
> problem you are trying to fix, and how these changes fix that problem.

Sorry for not describing the problem properly. There are two problems
related to "each legacy port has its own host_set":
1. When the LLDD module with legacy ports is unloaded, only
   irq 15 is freed while irq 14 is not. So, when the LLDD module
   is reloaded, it cannot get irq 14 non-shared and fails to load.
2. For simplex device in legacy mode, both primary and secondary
   legacy port will get the DMA engine because the ATA_HOST_SIMPLEX
   flag is available in the host_sets of each legacy port.

The patch tries to fix the probems by
1. Let both legacy ports share the same host_set (fix for problem 2).
2. Add per port irq to ata_ioports for legacy irq 14/15 since
   host_set is shared now.
3. Add irq handler hack to support both per-port legacy irq and
   per adapter shared irq cases.

> 
> The correct solution, long term, is
> 1) move the irq registration (request_irq, free_irq) out of
> ata_device_add().  The current design was convenient initially, but I
> have known since I wrote the code that it was insufficient, long term.
> 
> The best solution is to give each LLDD the ability to register an
> interrupt handler in a manner best suited to the hardware.  Consider,
> for example, how poorly the current design will work on PCI MSI-X hardware.

Hmm, you're right.

> 
> 2) For legacy mode hardware, one should pass struct ata_port* to
> request_irq(), rather then struct ata_host_set*.  Thus in the legacy ATA
> interrupt handler, obtain the host_set via ap->host_set.
> 

Thanks for the advice. Will revise the patch accordingly.
--
albert


