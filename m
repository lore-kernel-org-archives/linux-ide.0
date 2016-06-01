From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: Kernel option to disable TRIM/discard system-wide?
Date: Tue, 31 May 2016 23:05:41 -0400
Message-ID: <yq1mvn5vcai.fsf@sermon.lab.mkp.net>
References: <57436FA6.1010801@rabbit.us> <5745A24D.2010601@rabbit.us>
	<yq1oa7syzyy.fsf@sermon.lab.mkp.net> <574B17EB.50108@rabbit.us>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:27010 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbcFADFw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 May 2016 23:05:52 -0400
In-Reply-To: <574B17EB.50108@rabbit.us> (Peter Rabbitson's message of "Sun, 29
	May 2016 18:25:15 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Rabbitson <rabbit+list@rabbit.us>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org

>>>>> "Peter" == Peter Rabbitson <rabbit+list@rabbit.us> writes:

Peter> root@Ahasver:~# echo 0 > /sys/block/sda/queue/discard_max_bytes
Peter> -bash: /sys/block/sda/queue/discard_max_bytes: Permission denied

Peter> What am I missing?

Your kernel is too old. Try:

echo -n disabled > /sys/block/sda/device/scsi_disk/*/provisioning_mode

-- 
Martin K. Petersen	Oracle Linux Engineering
