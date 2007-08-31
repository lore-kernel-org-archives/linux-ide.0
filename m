From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH take #6] [libata] libata driver for bf548 on chip ATAPI
 controller.
Date: Fri, 31 Aug 2007 05:37:25 -0400
Message-ID: <46D7E155.409@garzik.org>
References: <1187673151.16526.5.camel@sevens.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41827 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932517AbXHaJh0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 31 Aug 2007 05:37:26 -0400
In-Reply-To: <1187673151.16526.5.camel@sevens.analog.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

Sonic Zhang wrote:
> Fix all issues pointed out in Jeff's email.
> 
> Acked-by: Alan Cox <alan@redhat.com>
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
> ---
>  drivers/ata/Kconfig      |   16
>  drivers/ata/Makefile     |    1
>  drivers/ata/pata_bf54x.c | 1627 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1644 insertions(+)

applied


