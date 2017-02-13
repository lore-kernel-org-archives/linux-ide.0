From: Guillermo Amaral <g@maral.me>
Subject: DMA issue caused by vmapped stacks
Date: Mon, 13 Feb 2017 00:47:45 -0800
Message-ID: <CAPeEpDroE2bYQ_viz7qExspordpR6gLYHjVxaJ53px3utz+PrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:38358 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbdBMIrq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 13 Feb 2017 03:47:46 -0500
Received: by mail-it0-f51.google.com with SMTP id c7so70263048itd.1
        for <linux-ide@vger.kernel.org>; Mon, 13 Feb 2017 00:47:46 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Howdy,

I recently had some off-time and decided to look into why some of my
drives where completely failing to show up after v4.8-rc3, some with
odd DMA errors.

Turned out to be vmapped stacks!

Once CONFIG_VMAP_STACK got enabled by default in x86_64 (by commit
e37e43a), to be more precise.
I turned it off, and everything is back in working order.

I don't have a standard setup, so probably nobody else has run into
the same issue yet -- but if you want to replicate it: Get (or make)
an ATA locked drive, boot with or hot-swap said locked drive on a v4.9
kernel with CONFIG_VMAP_STACK set to Y.

On my systems (tested on two systems), the drive fails to get sensed
correctly and no SCSI nodes get created. This means no way to unlock
drives with hdparm (or in my case, via the kernel).

I will try to dig into this issue a bit more next weekend, I just
wanted to bring it up in case it hasn't been already.

Cheers,
G

-- 
gamaral
