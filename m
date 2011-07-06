From: Asai Thambi S P <asamymuthupa@micron.com>
Subject: Re: New driver mtipx2xx submission
Date: Wed, 6 Jul 2011 15:39:21 -0600
Message-ID: <4E14D609.1010404@micron.com>
References: <22A973199D2C2F46933448F6E7990A300204F2BC@ntxboimbx31.micron.com>	<20110428230605.78c55c70@lxorguk.ukuu.org.uk>	<22A973199D2C2F46933448F6E7990A300204F728@ntxboimbx31.micron.com>	<20110502184206.25907c5e@lxorguk.ukuu.org.uk>	<22A973199D2C2F46933448F6E7990A300214B0D6@ntxboimbx31.micron.com>	<20110511202013.075b07cc@lxorguk.ukuu.org.uk>	<4DD722DB.8030303@micron.com>	<x49lixuyhhs.fsf@segfault.boston.devel.redhat.com>	<22A973199D2C2F46933448F6E7990A300239EA77@ntxboimbx31.micron.com>	<x49ipsp9voy.fsf@segfault.boston.devel.redhat.com>	<20110601212129.11534c55@lxorguk.ukuu.org.uk>	<4DF80ADE.8020206@micron.com>	<x49ips75f4j.fsf@segfault.boston.devel.redhat.com>	<22A973199D2C2F46933448F6E7990A3002697E77@ntxboimbx31.micron.com> <x49boxirnl8.fsf@segfault.boston.devel.redhat.com>
Reply-To: <asamymuthupa@micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from masquerade.micron.com ([137.201.242.130]:9083 "EHLO
	masquerade.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab1GFVjd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Jul 2011 17:39:33 -0400
In-Reply-To: <x49boxirnl8.fsf@segfault.boston.devel.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On 6/28/2011 9:18 AM, Jeff Moyer wrote:
>  From the perf report, I would have guessed that the CPU utilization for
> the ahci test case would have been lower than the Micron block driver.
> Odd, I wonder what I'm missing.  Asai, did you notice if any of the CPUs
> was completely pegged during testing with ahci?

Yes, whichever cpu was handling interrupts was pegged in both cases. 
The driver is configured to use a single MSI interrupt.


You're using a NUMA
> box, right?  I also wonder what the irq distribution looked like, and
> whether rq_affinity is hurting performance for the ahci case.

No, it's not a NUMA box.  Our runs were done with rq_affinity=0.  If you 
think it would be helpful, we can re-run with rq_affinity=1.


   Also,
> does the Micron driver do any sort of interrupt coalescing that maybe
> the ahci driver isn't doing?
>

We have a scheme to coalesce multiple completions into a single 
interrupt.  Both drivers were using this feature for these runs.

