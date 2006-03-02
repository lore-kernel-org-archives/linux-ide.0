From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: sx8 driver
Date: Thu, 02 Mar 2006 09:35:39 -0500
Message-ID: <440702BB.2000707@pobox.com>
References: <5d96567b0603020622v5c846b0br6b634188bc14e68b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:34235 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750729AbWCBOfn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Mar 2006 09:35:43 -0500
In-Reply-To: <5d96567b0603020622v5c846b0br6b634188bc14e68b@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Raz Ben-Jehuda(caro) wrote:
> had anyone here managed to compile sx8 ( carmel ) driver ?
> i am failing to do so in  2.6.15 .
> 
> make  -C /usr/kernels/linux-2.6.15 SUBDIRS=`pwd` modules
> 
> 
> /usr/kernels/linux-2.6.15/drivers/scsi/hosts.h:1:2: warning: #warning
> "This file is obsolete, please use <scsi/scsi_host.h> instead"
> /usr/download/cml26x20050104_1.1.0.18/carmel.c:255: error: syntax
> error before '*' token

This driver does not exist in the kernel tree.  Where did you find it?

You are looking for drivers/block/sx8.c which compiles just fine.

	Jeff



