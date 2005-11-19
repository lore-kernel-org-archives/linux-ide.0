From: Tejun Heo <htejun@gmail.com>
Subject: Re: [sata_sil24] disks not detected (RESOLVED)
Date: Sat, 19 Nov 2005 20:16:13 +0900
Message-ID: <437F097D.6020101@gmail.com>
References: <20051113124650.GA21127@bam.epita.fr> <20051119100237.GA27926@bam.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.207]:45792 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751058AbVKSLQT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Nov 2005 06:16:19 -0500
Received: by zproxy.gmail.com with SMTP id 13so402923nzn
        for <linux-ide@vger.kernel.org>; Sat, 19 Nov 2005 03:16:19 -0800 (PST)
In-Reply-To: <20051119100237.GA27926@bam.epita.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Bevand <mb@opensc.org>
Cc: linux-ide@vger.kernel.org

Marc Bevand wrote:
> Marc Bevand wrote:
> | 
> | Remember the patch you made to sata_sil24 to correctly detect disks
> | attached to the controller [1] ? At this time I was using only one
> | SiI3124 controller, and it worked well. But today I just tried to
> | use 2 controllers with 4 disks attached to each of them (8 total disks),
> | and 2 of the disks are not detected [...]
> 
> The various sil24 patches that have been applied today to libata-dev
> (see below) have resolved my issue. Thanks Tejun.
> 
> [PATCH 1/4] sil24: add sil24_restart_controller
> [PATCH 2/4] sil24: use SRST for phy_reset 
> [PATCH 3/4] sil24: add ATAPI support 
> [PATCH 4/4] sil24: make error_intr less verbose
> 

Hi, Marc.

Good to hear that.  I was about to notify you once the patches show up 
in the repository.  You were faster than me. :-)

-- 
tejun
