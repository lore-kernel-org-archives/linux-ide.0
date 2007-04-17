From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: HPA support
Date: Tue, 17 Apr 2007 22:45:22 +0100
Message-ID: <20070417224522.375b9fbe@the-village.bc.nu>
References: <20070411002313.29069ca5@the-village.bc.nu>
	<20070417184139.GB11211@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40717 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030384AbXDQVmd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Apr 2007 17:42:33 -0400
In-Reply-To: <20070417184139.GB11211@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, jkeating@redhat.com

>  > For normal users this brings us, I believe, to feature parity with old IDE
>  > (and of course more featured in some areas too).
> 
> This is broken horribly on nvidia chipsets..

Your Nvidia driver is out of date.

> HARDWARE ERROR
> CPU 0: Machine Check Exception:                4 Bank 4: b200000000070f0f
> TSC 5d45fa1400 
> This is not a software problem!
> Run through mcelog --ascii to decode and contact your hardware vendor
> Kernel panic - not syncing: Machine check
> BUG: warning at kernel/panic.c:137/panic() (Tainted: G   M  )

If you send certain commands via ADMA the chip takes the entire machine
out. The current Nvidia driver has this cured (and you want it as
otherwise you can blow up the machine via SG_IO)

Alan
