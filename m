From: Tejun Heo <htejun@gmail.com>
Subject: Re: Some questions about new EH in libata
Date: Tue, 22 Aug 2006 14:10:00 +0900
Message-ID: <44EA91A8.5090309@gmail.com>
References: <8202f4270608212154k787f63a1k15ed3dcfff0624c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:7816 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750711AbWHVFKI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Aug 2006 01:10:08 -0400
Received: by py-out-1112.google.com with SMTP id n25so2794622pyg
        for <linux-ide@vger.kernel.org>; Mon, 21 Aug 2006 22:10:07 -0700 (PDT)
In-Reply-To: <8202f4270608212154k787f63a1k15ed3dcfff0624c2@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Fajun Chen wrote:
> Hi Folks,
> 
> I just upgraded to the libata with new EH and I have some questions
> about the new error handler:
> 1. In several occasions, I saw a port being disable, under what kind
> of conditions will new EH disable a port?

After EH fails to recover a device.  It usually takes three recovery 
trial failures.

> 2. For user space program, is there any way to checked the state of a
> port/drive? I noticed that dmesg has some printout but that could be
> wiped out by other traces or errors.

Hmmm... Not yet.

> 3. Does libata allow user space code to reset host/bus/drive or only
> libata itself has the privilege? I tried sg reset IOCTL interface on
> SATA Sil3124, it seems not working.

No, that doesn't work but issuing userscan forces libata to reset the 
channel.

> 4. How to reenable a port/drive after it's disabled without rebooting?
> Any API or command from user space?

You can use SCSI userscan interface.

Regards.

-- 
tejun
