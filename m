From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: hdio.txt update
Date: Thu, 10 Mar 2005 17:30:35 +0100
Message-ID: <58cb370e05031008307a0163c1@mail.gmail.com>
References: <20050302235457.GA21352@htj.dyndns.org>
	 <20050303021638.GA24150@htj.dyndns.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.201]:17171 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262677AbVCJQan (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Mar 2005 11:30:43 -0500
Received: by wproxy.gmail.com with SMTP id 68so815940wra
        for <linux-ide@vger.kernel.org>; Thu, 10 Mar 2005 08:30:36 -0800 (PST)
In-Reply-To: <20050303021638.GA24150@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hi,

On Thu, 3 Mar 2005 11:16:38 +0900, Tejun Heo <htejun@gmail.com> wrote:

> +         [2] Both the input and output buffers are copied from the
> +         user and written back to the user, even when not used.  The
> +         out_flags and in_flags are written back to the user after
> +         the ioctl completes.  These are the same as the input
> +         values, unchanged.

This is incorrect, please refer to flagged_taskfile() and ide_taskfile_ioctl().
Unfortunately you've based your latest patch series on this assumption.

> +         Taskfile registers are read back from the drive into
> +         {io|hob}_ports[] after the command completes iff one of the
> +         following conditions is met; otherwise, the original values
> +         will be written back, unchanged.
> +
> +           1. The drive fails the command (EIO).
> +           2. More than one bit is set in tf_out_flags.

Isn't one bit enough?

The rest is of the update is fine, thanks for doing this.

Bartlomiej
