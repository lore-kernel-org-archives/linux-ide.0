From: Tejun Heo <tj@kernel.org>
Subject: Re: utku's sata freeze and hard reset problem
Date: Tue, 19 May 2009 16:41:10 +0900
Message-ID: <4A126296.80006@kernel.org>
References: <4A10B2A2.3030003@zeitin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39105 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752744AbZESHlQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 May 2009 03:41:16 -0400
In-Reply-To: <4A10B2A2.3030003@zeitin.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Utku Somer <utku@zeitin.com>
Cc: linux-ide@vger.kernel.org

Utku Somer wrote:
> I have started getting this error from the sata kernel code which
> freezes my system for 20-30 seconds. I haven't been able to tell the
> exact reason so far. My current configuration is two SATA disks on
> which three partitions are raided with soft raid1.

Tiemouts without any link layer problem reported.  Hmmm.... Does it
help if you disable NCQ with the following command?

# echo 1 > /sys/block/sdX/device/queue_depth

Thanks.

-- 
tejun
