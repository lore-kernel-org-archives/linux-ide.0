From: Tejun Heo <tj@kernel.org>
Subject: Re: SATA DVD drive problem on ICH8M
Date: Sun, 16 Nov 2008 18:04:28 +0900
Message-ID: <491FE21C.7020904@kernel.org>
References: <291f35090811140246y674de2b1p23a9a650f8c7ef3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57591 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751541AbYKPJEN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Nov 2008 04:04:13 -0500
In-Reply-To: <291f35090811140246y674de2b1p23a9a650f8c7ef3a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Maxim Gorbachyov <maxim.gorbachyov@gmail.com>
Cc: linux-ide@vger.kernel.org

Maxim Gorbachyov wrote:
> Hello.
> I have a problem with SATA DVD drive and ICH8M on ASUS F80L. I insert
> a disk, try mounting it, mount fails. Then the drive gets lost, and I
> can't even eject the tray until power cycle. Kernel is vanilla
> 2.6.27.6. See dmesg, lspci, lshw output and kernel config attached.
> Let me know if more info is needed.

Looks like your drive doesn't like hald polling for media presence.
Does hal-disable-polling /dev/sr0 help?

-- 
tejun
