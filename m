From: Peter Huewe <PeterHuewe@gmx.de>
Subject: Re: [PATCH 2/2] ide: add __init/__exit macros to drivers/ide/scc_pata.c
Date: Wed, 6 Jan 2010 21:58:01 +0100
Message-ID: <201001062158.01870.PeterHuewe@gmx.de>
References: <1261470564-23754-2-git-send-email-peterhuewe@gmx.de> <201001051939.07756.bzolnier@gmail.com> <20100106.122826.233087809.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:35903 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932788Ab0AFU6O (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Jan 2010 15:58:14 -0500
In-Reply-To: <20100106.122826.233087809.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: bzolnier@gmail.com, jkosina@suse.cz, kernel-janitors@vger.kernel.org, sshtylyov@ru.mvista.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Am Mittwoch 06 Januar 2010 21:28:26 schrieb David Miller:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date: Tue, 5 Jan 2010 19:39:07 +0100
> 
> 
> Not being able to unload a module is a bug isn't it?  Bug fixes
> are always fine :-)
> 
> I'll take a closer look at this then apply it, thanks Bart!

Funny what such trivial patch can reveal :)

Regards,
Peter
