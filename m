From: Alexey Orishko <alexey.orishko@gmail.com>
Subject: Re: printouts about removable disk in the kernel log
Date: Fri, 1 May 2015 19:00:46 +0200
Message-ID: <CAL_Kpj08R50GuEiZFhyzxTRPttod5sOUokBg8oF+6RPrEQMoAg@mail.gmail.com>
References: <CAL_Kpj2BAO781yXF-q2Q1AHoxXZpSXeOHfxDc7uoyeEURJZ5qg@mail.gmail.com>
	<5541FABB.3060702@seoss.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:35578 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbbEARAr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 May 2015 13:00:47 -0400
Received: by qcbgu10 with SMTP id gu10so5686740qcb.2
        for <linux-ide@vger.kernel.org>; Fri, 01 May 2015 10:00:46 -0700 (PDT)
In-Reply-To: <5541FABB.3060702@seoss.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Small <tim@seoss.co.uk>
Cc: linux-ide@vger.kernel.org

On Thu, Apr 30, 2015 at 11:49 AM, Tim Small <tim@seoss.co.uk> wrote:
> Doing something like:
>
> echo 1 > /sys/block/sdc/device/delete
>
> prior to unplugging the drive will reduce messages on unplug (and will
> also spin down the disk etc.).  On some kernel versions it will also
> stop the kernel speed limiting the interface (if that's a concern).

Well... it will kill that block device completely. If you are removing
hard disk connected to sata controller directly, it would do. However
in case of dock with a disk cartridge, dock becomes nonoperational due
to missing driver.


/alexey
