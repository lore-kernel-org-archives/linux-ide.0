From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.11-rc2 05/09] ide: map ide_task_ioctl() to ide_taskfile_ioctl()
Date: Sun, 6 Feb 2005 19:38:40 +0100
Message-ID: <58cb370e050206103817d11145@mail.gmail.com>
References: <20050205021502.GA17767@htj.dyndns.org>
	 <20050205021556.CFCE41326F9@htj.dyndns.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.192]:49204 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261275AbVBFSio (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Feb 2005 13:38:44 -0500
Received: by wproxy.gmail.com with SMTP id 67so745313wri
        for <linux-ide@vger.kernel.org>; Sun, 06 Feb 2005 10:38:40 -0800 (PST)
In-Reply-To: <20050205021556.CFCE41326F9@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@home-tj.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat,  5 Feb 2005 11:15:56 +0900 (KST), Tejun Heo <tj@home-tj.org> wrote:

> -       int err = 0;
> -       u8 args[7], *argbuf = args;
> -       int argsize = 7;
> +       u8 args[7];
> +       ide_task_t task;
> +       task_ioreg_t *regs = task.tfRegister;

u8 *regs please

> +       int ret;

What is the reason for changing the name of variable
(other than making the patch bigger ;) ?

Please also read comments to patch #4.

Thanks,
Bartlomiej
