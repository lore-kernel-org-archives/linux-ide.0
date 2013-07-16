From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] AHCI: fix Null pointer dereference in achi_host_active()
Date: Tue, 16 Jul 2013 15:48:16 +0400
Message-ID: <51E53300.6010000@cogentembedded.com>
References: <1373951920-31699-1-git-send-email-xtfeng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:47155 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932210Ab3GPLsR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Jul 2013 07:48:17 -0400
Received: by mail-la0-f41.google.com with SMTP id fn20so443967lab.0
        for <linux-ide@vger.kernel.org>; Tue, 16 Jul 2013 04:48:16 -0700 (PDT)
In-Reply-To: <1373951920-31699-1-git-send-email-xtfeng@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Xiaotian Feng <xtfeng@gmail.com>
Cc: Alexander Gordeev <agordeev@redhat.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 16-07-2013 9:18, Xiaotian Feng wrote:

> commit b29900e6 introuded a regression, which resulted Null pointer

    Please also specify that commit's summary in parens.

> dereference for achi host with dummy ports. For ahci ports, when the
> port is dummy port, its private_data will be NULL, as ata_dummy_port_ops
> doesn't support ->port_start.

> Reported-and-tested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Xiaotian Feng <xtfeng@gmail.com>
> Cc: Alexander Gordeev <agordeev@redhat.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-ide@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

MBR, Sergei


