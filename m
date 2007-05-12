From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] pasemi: electra IDE/pata_platform glue
Date: Sun, 13 May 2007 01:11:02 +0200
Message-ID: <200705130111.03153.arnd@arndb.de>
References: <20070512145041.GA13025@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:61864 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998AbXELXLP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 May 2007 19:11:15 -0400
In-Reply-To: <20070512145041.GA13025@lixom.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linuxppc-dev@ozlabs.org
Cc: Olof Johansson <olof@lixom.net>, paulus@samba.org, linux-ide@vger.kernel.org

On Saturday 12 May 2007, Olof Johansson wrote:
> 
> We unfortunately need to modify the resources before calling the generic
> platform driver, since the device tree only has one register window in
> it and the driver expects two. Adding this as an of_platform driver
> instead doesn't give us any benefit, it just adds one more layer of
> register/probe functions.

Why not provide a proper pata_of.c driver based on ata_generic? That
will help the next person that has a builtin ata controller and wants
to get it running as an of_device.

If you simply export generic_sht (rename that to ata_generic_sht)
and generic_port_ops (-> ata_generic_port_ops), then the resulting
of_platform_driver should be no more complicated than the one
you are proposing here.

	Arnd <><  
