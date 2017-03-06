From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] libata: transport: Remove circular dependency at free
 time
Date: Mon, 6 Mar 2017 23:11:53 +0300
Message-ID: <ebcbf109-729f-bb2f-f65e-b16765776996@cogentembedded.com>
References: <CAP8WD_ZJ9EgssJgTu8EOtKodtnfxO8tqhN6iAnuMHq2VQ7MoaQ@mail.gmail.com>
 <20170303170009.36744-1-gwendal@chromium.org>
 <20170306200952.GG19696@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36518 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753731AbdCFUMI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 6 Mar 2017 15:12:08 -0500
Received: by mail-lf0-f42.google.com with SMTP id y193so77701732lfd.3
        for <linux-ide@vger.kernel.org>; Mon, 06 Mar 2017 12:12:06 -0800 (PST)
In-Reply-To: <20170306200952.GG19696@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Gwendal Grignou <gwendal@chromium.org>
Cc: gregkh@linuxfoundation.org, linux-ide@vger.kernel.org

Hello!

On 03/06/2017 11:09 PM, Tejun Heo wrote:

> Applied the following to libata/for-4.11-fixes.
>
> Thanks.
> ------ 8< ------
> From d4a32919c3d9c959af268d33bab24eb134dab0cc Mon Sep 17 00:00:00 2001
> From: Gwendal Grignou <gwendal@chromium.org>
> Date: Fri, 3 Mar 2017 09:00:09 -0800
> Subject: [PATCH] libata: transport: Remove circular dependency at free time
>
> Without this patch, failed probe would not free resources like irq.
>
> ata port tdev object currently hold a reference to the ata port
> object.  Therefore the ata port object release function will not get
> called until the ata_tport_release is called. But that would never
> happen, releasing the last reference of ata port dev is done by
> scsi_host_release, which is called by ata_host_release when the ata
> port object is released.
>
> The ata_tranport device objects actually do not need to explicitly

    Still tranport? :-/

> hold a reference to their real counterpart, given the transport
> objects are the children of these objects and device_add() is call for
> each child.  We know the parent will not be deleted until we call the
> child's device_del().
>
> Reported-by: Matthew Whitehead <tedheadster@gmail.com>
> Tested-by: Matthew Whitehead <tedheadster@gmail.com>
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Tejun Heo <tj@kernel.org>
[...]

MBR, Sergei

