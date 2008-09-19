From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Problem booting to SATA drive on Dell GX270 with Intel 82801EB
 (ICH5) chipset
Date: Fri, 19 Sep 2008 14:05:09 +0100
Message-ID: <20080919140509.6bde889b@lxorguk.ukuu.org.uk>
References: <2DF4CDBD-CE01-45BE-B49F-F491DB2F2716@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44399 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752222AbYISNFM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Sep 2008 09:05:12 -0400
In-Reply-To: <2DF4CDBD-CE01-45BE-B49F-F491DB2F2716@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Clifford Heath <clifford.heath@gmail.com>
Cc: linux-ide@vger.kernel.org

> The SATA BIOS in this m/b always assigns the SATA drives to drive  
> codes 0x80, etc,

That is quite common.

> When the same kernel is loaded using /dev/sda1 as root, it finishes  
> initializing devices
> and frees the kernel memory used during bootup, then says "unable to  
> create initial
> console" on the first access to the SATA disk.

Its a bit hard to tell what is going on. A first thing to try would be to
completely turn off CONFIG_IDE. It won't fix the problem (or I'll be
amazed if it does) but it will mean that everything that is going on is
occuring through the same disk layer.

Unable to create initial console implies it mounted a file system with no
suitable /dev (eg because your setup expects udev & initrd, or
because /dev/sda1 or whatever your root= entry gives isn't actually the
right partition)

> The 2.6.26.5 kernel has new support for the Intel ICH5 chips (Serial  
> ATA(prod)... ->
> ATA SFF -> Intel ESB, ICH, PIIX4 ...) enabled.

Actually it has the same as before but the menu shuffled around

Alan
