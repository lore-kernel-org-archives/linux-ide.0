From: Stefan Keller <linux-list@zahlenfresser.de>
Subject: Re: Samsung SSD 850Pro firmware update queued TRIM problems
Date: Tue, 24 Feb 2015 22:12:43 +0100
Message-ID: <54ECE94B.9050302@zahlenfresser.de>
References: <54EB35EF.2050103@zahlenfresser.de> <yq1zj8340nj.fsf@sermon.lab.mkp.net> (sfid-20150224_193642_375049_A8AE57F7)
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from prometheus.apexo.de ([5.9.65.79]:34808 "EHLO
	prometheus.apexo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492AbbBXVMp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Feb 2015 16:12:45 -0500
In-Reply-To: <yq1zj8340nj.fsf@sermon.lab.mkp.net> (sfid-20150224_193642_375049_A8AE57F7)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org

Hello Martin,

On 02/24/2015 07:36 PM, Martin K. Petersen wrote:
>>>>>> "Stefan" == Stefan Keller <linux-list@zahlenfresser.de> writes:
> 
> Stefan> Hello list, I recently updated the firmware on my Samsung 850
> Stefan> Pro from EXM01B6Q to EXM02B6Q.  Now "fstrim -v /" causes SATA
> Stefan> command timeouts related to TRIM with NCQ.
> 
> Do these timeouts happen if you disable ALPM?

Yes.
cat /sys/class/scsi_host/host*/link_power_management_policy
max_performance
max_performance
max_performance
max_performance
max_performance
max_performance

Still timeouts (actually I think when I initially got them I was
connected to power, which in my setup means ALPM disabled). Also the
timeouts only happen with TRIM, not with any other heavy I/O.

Best regards,
Stefan

-- 
Stefan Keller <linux-list@zahlenfresser.de>
