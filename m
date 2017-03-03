From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] libata: transport: Remove circular dependency at free
 time
Date: Fri, 3 Mar 2017 21:28:45 +0300
Message-ID: <faa6496f-f72e-733a-f7a4-3e2587cd8e61@cogentembedded.com>
References: <CAP8WD_ZJ9EgssJgTu8EOtKodtnfxO8tqhN6iAnuMHq2VQ7MoaQ@mail.gmail.com>
 <20170303170009.36744-1-gwendal@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:34656 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbdCCSaa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 3 Mar 2017 13:30:30 -0500
Received: by mail-lf0-f52.google.com with SMTP id k202so51001897lfe.1
        for <linux-ide@vger.kernel.org>; Fri, 03 Mar 2017 10:28:49 -0800 (PST)
In-Reply-To: <20170303170009.36744-1-gwendal@chromium.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@chromium.org>, tj@kernel.org, gregkh@linuxfoundation.org, linux-ide@vger.kernel.org, htejun@gmail.com

Hello!

On 03/03/2017 08:00 PM, Gwendal Grignou wrote:

> From: Tejun Heo <tj@kernel.org>
>
> Without this patch, failed probe would not free resources like irq.
>
> ata port tdev object currently hold a reference to the ata port object.
> Therefore the ata port object release function will not get called until
> the ata_tport_release is called. But that would never happen, releasing
> the last reference of ata port dev is done by scsi_host_release, which
> is called by ata_host_release when the ata port object is released.
>
> The ata tranport device objects actually do not need to explicitly hold

    Not ata_transport.

> a reference to their real counterpart, given the transport objects are
> the children of these objects and device_add() is call for each child.
> We know the parent will not be deleted until we call the child

    Child's?

> device_del().
>
> Reported-by: Matthew Whitehead <tedheadster@gmail.com>
> Tested-by: Matthew Whitehead <tedheadster@gmail.com>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

    You're saying it's Tejun's patch but there's no sign-off from him?

MBR, Sergei

