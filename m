From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 13/15] ide: fix UDMA/MWDMA/SWDMA masks
Date: Mon, 22 Jan 2007 18:46:20 +0000
Message-ID: <20070122184620.1c8b87ac@localhost.localdomain>
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
	<20070119003226.14846.87052.sendpatchset@localhost.localdomain>
	<45B4FFBD.40507@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52491 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932163AbXAVSfW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Jan 2007 13:35:22 -0500
In-Reply-To: <45B4FFBD.40507@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 22 Jan 2007 21:17:33 +0300
>     Ugh, I'm not seeing any *actual* support for MW/SW DMA in this driver... 

Thats long been broken. Should be correct in the libata driver

Alan
