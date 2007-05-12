From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pasemi: electra IDE/pata_platform glue
Date: Sun, 13 May 2007 00:58:30 +0100
Message-ID: <20070513005830.38ba8e3b@the-village.bc.nu>
References: <20070512145041.GA13025@lixom.net>
	<200705130111.03153.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40632 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754888AbXELXyV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 May 2007 19:54:21 -0400
In-Reply-To: <200705130111.03153.arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Olof Johansson <olof@lixom.net>, paulus@samba.org, linux-ide@vger.kernel.org

> Why not provide a proper pata_of.c driver based on ata_generic? That
> will help the next person that has a builtin ata controller and wants
> to get it running as an of_device.

Easier to use pata_platform I would think ? Just create the OF device and
bind it to pata_platform.

Alan
