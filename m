From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: is there a value to CONFIG_NO_ATA_LEGACY?
Date: Sun, 10 Feb 2008 22:54:10 +0000
Message-ID: <20080210225410.3c28deeb@core>
References: <alpine.LFD.1.00.0802101442240.14742@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54528 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751314AbYBJXBE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Feb 2008 18:01:04 -0500
In-Reply-To: <alpine.LFD.1.00.0802101442240.14742@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: linux-ide@vger.kernel.org

On Sun, 10 Feb 2008 14:44:16 -0500 (EST)
"Robert P. J. Day" <rpjday@crashcourse.ca> wrote:

> 
>   in drivers/ata/libata-sff.c:
> 
> ...
> #if defined(CONFIG_NO_ATA_LEGACY)
>                 /* Some platforms with PCI limits cannot address compat
>                    port space. In that case we punt if their firmware has
>                    left a device in compatibility mode */
>                 if (legacy_mode) {
>                         printk(KERN_ERR "ata: Compatibility mode ATA is not supported on this platform, skipping.\n");
>                         return -EOPNOTSUPP;
>                 }
> #endif
> ...
> 
>   there is no Kconfig file that defines that variable -- should that
> test be removed?  or is something eventually coming that defines it?

It is used by some of the unsubmitted tree stuff certainly and is there
because some platforms will need it (eg FRV). 

Alan
