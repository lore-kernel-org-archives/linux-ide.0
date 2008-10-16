From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: remove broken hpt34x driver
Date: Thu, 16 Oct 2008 13:48:10 +0400
Message-ID: <48F70DDA.4010805@ru.mvista.com>
References: <200810152156.25754.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:53832 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753710AbYJPJsO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Oct 2008 05:48:14 -0400
In-Reply-To: <200810152156.25754.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> No big loss since HPT343/363 controllers are properly supported
> by pata_hpt3x3 driver from Alan Cox.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>   

   Hum, interesting way of fixing the driver... :-)
   Shouldn't the PCI IDs be added to drivers/ide/pci/generic.c?

MBR, Sergei


