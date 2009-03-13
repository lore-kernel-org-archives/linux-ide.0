From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Off-by-one in both LIBATA and IDE drivers
Date: Fri, 13 Mar 2009 08:45:06 -0600
Message-ID: <49BA7172.80908@gmail.com>
References: <20090313074120.48682.qmail@web4108.mail.ogk.yahoo.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f177.google.com ([209.85.219.177]:59024 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753773AbZCMOpO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Mar 2009 10:45:14 -0400
In-Reply-To: <20090313074120.48682.qmail@web4108.mail.ogk.yahoo.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: n0diamond@yahoo.co.jp
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jim Paris <jim@jtan.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>

Norman Diamond wrote:
> LIBATA with the patch to ata.h now handles all sectors on
> hard drives that it recognizes.
> 
> An example of a hard drive that it recognizes is one that
> is attached to an Intel ICH7M chipset when hda=noprobe
> hdc=noprobe have been specified in the boot command.
> 
> An example of a hard drive that it doesn't recognize is
> one that is attached to an Intel PIIX4 chipset when
> hda=noprobe hdc=noprobe have been specified in the boot
> command.
> 
> In either case, the boot parameters persuade the old IDE
> drivers not to grab the controllers.
> 
> With ICH7M, LIBATA takes over and runs both the hard drive
> and DVD at full speed.
> 
> With PIIX4, LIBATA initializes.  End of story.  Slax can't
> find its own CD.  If I only use hda=noprobe then the old
> IDE controller assigns hdc to the CD and Slax finds it,
> but the hard drive is still undetected.  Behaviour is the
> same under VMware as in a genuine old PC.
> 
> LIBATA's PIIX drivers are built in along with everything
> else.  They just seem not to get executed.
> 
> What am I missing?

I assume that ATA_PIIX is set in the configuration.. The lspci -vn and
dmesg output from when it fails to detect would be useful.

> 
> --------------------------------------
> Power up the Internet with Yahoo! Toolbar.
> http://pr.mail.yahoo.co.jp/toolbar/

