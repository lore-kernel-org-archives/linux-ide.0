From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 11/15] libata: reimplement controller-wide PM
Date: Mon, 26 Jun 2006 15:53:36 +0900
Message-ID: <449F8470.3060308@gmail.com>
References: <11511486203395-git-send-email-htejun@gmail.com> <1151303807.7132.162.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.201]:15714 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750948AbWFZGxX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jun 2006 02:53:23 -0400
Received: by nz-out-0102.google.com with SMTP id o37so729327nzf
        for <linux-ide@vger.kernel.org>; Sun, 25 Jun 2006 23:53:22 -0700 (PDT)
In-Reply-To: <1151303807.7132.162.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

zhao, forrest wrote:
ort_schedule_eh(ap); need to be invoked in order to schedule EH,
> right?

Right.

 > But ata_port_schedule_eh(ap) is not called in ata_host_set_suspend().

Because ata_host_set_suspend() doesn't need to invoke EH.  It just needs 
to make sure that EH sees ATA_FLAG_SUSPENDED which is achieved by 
flushing EH after setting SUSPENDED.

-- 
tejun
