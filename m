From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] Snoop SET FEATURES - WRITE CACHE ENABLE/DISABLE command
Date: Mon, 29 May 2006 07:29:50 -0400
Message-ID: <447ADB2E.8030009@rtr.ca>
References: <1148547763.23979.15.camel@forrest26.sh.intel.com>	 <44779A05.4010209@garzik.org> <1148884515.3466.12.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:12250 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750853AbWE2L3w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 May 2006 07:29:52 -0400
In-Reply-To: <1148884515.3466.12.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: Jeff Garzik <jeff@garzik.org>, htejun@gmail.com, linux-ide@vger.kernel.org

zhao, forrest wrote:
>
> Doing scsi_rescan_device() in SCSI EH thread caused my machine with 1
> logical CPU to hang(it stopped responding, user can't login locally or
> remotely, and it can only respond to "ping".)
>
> So I think scsi_rescan_device() is prohibited from being invoked in SCSI
> EH thread.

Yup, that's how it works, as I also discovered when the qstor.c driver
became the first user of the "new" SCSI EH logic two years ago.

Cheers
