From: Adrian Bunk <bunk@stusta.de>
Subject: 2.6.18-rc4-mm1: ATI SB600 SATA drivers: modpost errors
Date: Mon, 14 Aug 2006 01:01:41 +0200
Message-ID: <20060813230141.GT3543@stusta.de>
References: <20060813012454.f1d52189.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:49422 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751705AbWHMXBn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 13 Aug 2006 19:01:43 -0400
Content-Disposition: inline
In-Reply-To: <20060813012454.f1d52189.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Anatoli Antonovitch <antonovi@ati.com>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, rusty@rustcorp.com.au, sam@ravnborg.org

On Sun, Aug 13, 2006 at 01:24:54AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc3-mm2:
>...
> +ahci-ati-sb600-sata-support-for-various-modes.patch
> +atiixp-ati-sb600-ide-support-for-various-modes.patch
>...
>  Misc patches
>...

<--  snip  -->

...
  MODPOST 1955 modules
WARNING: Can't handle masks in drivers/ata/ahci:FFFF05
WARNING: Can't handle masks in drivers/ide/pci/atiixp:FFFF05
...

<--  snip  -->

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

