From: Asai Thambi S P <asamymuthupa@micron.com>
Subject: Re: New driver mtipx2xx submission
Date: Tue, 14 Jun 2011 19:29:02 -0600
Message-ID: <4DF80ADE.8020206@micron.com>
References: <22A973199D2C2F46933448F6E7990A300204F2BC@ntxboimbx31.micron.com>	<20110428230605.78c55c70@lxorguk.ukuu.org.uk>	<22A973199D2C2F46933448F6E7990A300204F728@ntxboimbx31.micron.com>	<20110502184206.25907c5e@lxorguk.ukuu.org.uk>	<22A973199D2C2F46933448F6E7990A300214B0D6@ntxboimbx31.micron.com>	<20110511202013.075b07cc@lxorguk.ukuu.org.uk>	<4DD722DB.8030303@micron.com>	<x49lixuyhhs.fsf@segfault.boston.devel.redhat.com>	<22A973199D2C2F46933448F6E7990A300239EA77@ntxboimbx31.micron.com>	<x49ipsp9voy.fsf@segfault.boston.devel.redhat.com> <20110601212129.11534c55@lxorguk.ukuu.org.uk>
Reply-To: <asamymuthupa@micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from masquerade.micron.com ([137.201.242.130]:30390 "EHLO
	masquerade.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754245Ab1FOB3P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jun 2011 21:29:15 -0400
In-Reply-To: <20110601212129.11534c55@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Moyer <jmoyer@redhat.com>, linux-ide@vger.kernel.org

On 6/1/2011 2:21 PM, Alan Cox wrote:
>> Thanks, Asai!  I don't think cfq is the ideal I/O scheduler to be
>> testing.  Could you run again with deadline and/or noop and see how that
>> changes your throughput and perf report?  Also, just for completeness,
>> could you tell us which kernel you ran this against?

kernel 2.6.38.6

> How many processors is this system, just looking at the lock contention
> which is pretty horrible.

8 processors (2 quad-core CPUs)
Intel(R) Xeon(R) CPU           X5672  @ 3.20GHz

> I'd been expecting various red flags in the AHCI/libata/scsi queue code
> but it seems at first glance that the block queue stuff is killing us and
> the scsi/ata code is a distraction (unless of course its causing a lot of
> the lock time)
>
> No-op would be most interesting but the I/O scheduler numbers don't look
> pretty.
>
> Alan

On looking into the data in below links, lock and block queue are 
consuming more time when running with ahci driver. Correct me if I 
missing something.

With mtipx2xx, the driver is spot on processing I/O. Any idea of who is 
the top offender when running with mtipx2xx?

Filename                  |    Description
-------------------------------------------------------------------------------------------
perf_report_ahci_cfq      : perf call graph for ahci driver with cfq
                             scheduler enabled
http://www.micron.com/get-document/?documentId=6768

vdbench.ahci.cfq.html     : vdbench summary of a run for ahci driver
                             with cfq scheduler enabled
http://www.micron.com/get-document/?documentId=6774

perf_report_ahci_deadline : perf call graph for ahci driver with
                             deadline scheduler enabled
http://www.micron.com/get-document/?documentId=6769

vdbench_ahci.deadline.html: vdbench summary of a run for ahci driver
                             with deadline scheduler enabled
http://www.micron.com/get-document/?documentId=6775

perf_report_ahci_noop     : perf call graph for ahci driver with noop
                             scheduler enabled
http://www.micron.com/get-document/?documentId=6770

vdbench_ahci.noop.html    : vdbench summary of a run for ahci driver
                             with noop scheduler enabled
http://www.micron.com/get-document/?documentId=6776

perf_report_micron        : perf call graph for Micron block driver
                             (mtipx2xx)
http://www.micron.com/get-document/?documentId=6772

vdbench_micron.html       : vdbench summary of a run for Micron block
                             driver (mtipx2xx)
http://www.micron.com/get-document/?documentId=6777

This is the first time we are hosting files for public access, that 
process took time to get to here.
