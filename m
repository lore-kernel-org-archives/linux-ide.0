From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA disk detect problem with silicon image 3132
Date: Mon, 29 Sep 2008 10:43:22 +0900
Message-ID: <48E032BA.10907@gmail.com>
References: <788014650809241914h46b153e0w6d88c2a1c8c65df3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:17351 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060AbYI2Bot (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Sep 2008 21:44:49 -0400
Received: by ti-out-0910.google.com with SMTP id b6so803766tic.23
        for <linux-ide@vger.kernel.org>; Sun, 28 Sep 2008 18:44:47 -0700 (PDT)
In-Reply-To: <788014650809241914h46b153e0w6d88c2a1c8c65df3@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: khchen@synology.com
Cc: linux-ide@vger.kernel.org

KueiHuan Chen wrote:
> Hello,
> 
>   I have some problem in detect sata disk with silicon image 3132 in
> Marvell platform (arm).
> 
>   I am using kernel 2.6.24 with silicon image 3132 in Marvell 5281 /
> 6281 platform(Driver is sata_sil24). both would has same situation
> like the messages below.
> 
>   The problem is when the 3132 has disk on it, it would know it. But
> the identify command would timeout. After this, all ports would not
> responce for any hotplug event.
> 
>   The interesting thing is when i change the 3132 with marvell 6145
> sata chip(both using PCI-Express), and the driver using AHCI in
> Marvell 6281 platform.  It just work.
> 
>   And when i use 3132 in x86 or MPC85xx platform(same kernel), it also
> work fine. So i don't know where might has problem.  Is there any
> hint/idea for me ?

Looks like IRQ goes offline after the event.  sata_sil24 uses pretty
heavy hammer to reset the controller.  Maybe it somehow mysteriously
messes with IRQ delivery?

-- 
tejun
