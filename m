From: "Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]"
	<asamymuthupa@micron.com>
Subject: RE: New driver mtipx2xx submission
Date: Mon, 27 Jun 2011 17:38:48 -0600
Message-ID: <22A973199D2C2F46933448F6E7990A3002697E77@ntxboimbx31.micron.com>
References: <22A973199D2C2F46933448F6E7990A300204F2BC@ntxboimbx31.micron.com><20110428230605.78c55c70@lxorguk.ukuu.org.uk><22A973199D2C2F46933448F6E7990A300204F728@ntxboimbx31.micron.com><20110502184206.25907c5e@lxorguk.ukuu.org.uk><22A973199D2C2F46933448F6E7990A300214B0D6@ntxboimbx31.micron.com><20110511202013.075b07cc@lxorguk.ukuu.org.uk><4DD722DB.8030303@micron.com><x49lixuyhhs.fsf@segfault.boston.devel.redhat.com><22A973199D2C2F46933448F6E7990A300239EA77@ntxboimbx31.micron.com><x49ipsp9voy.fsf@segfault.boston.devel.redhat.com><20110601212129.11534c55@lxorguk.ukuu.org.uk><4DF80ADE.8020206@micron.com> <x49ips75f4j.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from masquerade.micron.com ([137.201.242.130]:59625 "EHLO
	masquerade.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754128Ab1F0Xi7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Jun 2011 19:38:59 -0400
Content-class: urn:content-classes:message
In-Reply-To: <x49ips75f4j.fsf@segfault.boston.devel.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

> 2.6.39 introduced the on-stack plugging work from Jens, the intent of
> which is to reduce queue lock contention.  It would be great if you
> could run with that kernel and noop to see if we make up some of the
> performance gap (which looks to be just north of 10%).
> 
> Asai, thanks for running these tests and providing all of this data!
> 
> -Jeff

At least with noop and deadline for ahci driver, now queue lock is not
the top offender. With the new change in plugging, seems noop and
deadline are spending more time in processing I/O similar to Micron
block driver.

With the current test results with 2.6.39.1 (new optimization for
plugging) and application queue depth of 32, 
     * Micron block driver exhibits 43% better IOPS than ahci driver
with noop
     * Micron block driver slightly better in CPU utilization.
     
With application queue depth of 256, Micron block driver is able to
leverage the device capability, and hence performance increases more
than 225%.

NOTE: To set up this benchmark, ran 'zerodrive' on the drive twice
before each test (standard benchmark procedure). The objective is to
compare the driver performance to call out the relative performance
capabilities between the drivers.

Links to perf report files below:

Filename                       |    Description
------------------------------------------------------------------------
------------------
mtip_ncq32.html                : vdbench summary of a run for Micron
block driver with app. queue depth of 32
http://www.micron.com/document_download/?documentId=6808

mtip_ncq32_report.txt          : performance call graph for Micron block
driver with app. queue depth of 32
http://www.micron.com/document_download/?documentId=6809

ahci_noop_ncq32.html           : vdbench summary of a run for ahci
driver with noop scheduler enabled and app. queue depth of 32
http://www.micron.com/document_download/?documentId=6814

ahci_noop_ncq32_report.txt     : performance call graph for ahci driver
with noop scheduler enabled and app. queue depth of 32
http://www.micron.com/document_download/?documentId=6815

ahci_cfq_ncq32.html            : vdbench summary of a run for ahci
driver with cfq scheduler enabled and app. queue depth of 32
http://www.micron.com/document_download/?documentId=6810

ahci_cfq_ncq32_report.txt      : performance call graph for ahci driver
with cfq scheduler enabled and app. queue depth of 32
http://www.micron.com/document_download/?documentId=6811

ahci_deadline_ncq32.html       : vdbench summary of a run for ahci
driver with deadline scheduler enabled and app. queue depth of 32
http://www.micron.com/document_download/?documentId=6812

ahci_deadline_ncq32_report.txt : performance call graph for ahci driver
with deadline scheduler enabled and app. queue depth of 32
http://www.micron.com/document_download/?documentId=6813

mtip_ncq256.html               : vdbench summary of a run for Micron
block driver with app. queue depth of 256
http://www.micron.com/document_download/?documentId=6816

mtip_ncq256_report.txt         : performance call graph for Micron block
driver with app. queue depth of 256
http://www.micron.com/document_download/?documentId=6817

config-2.6.39.1                : config file used for kernel 2.6.39.1
http://www.micron.com/document_download/?documentId=6818
