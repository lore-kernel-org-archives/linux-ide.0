From: Ronny Hegewald <ronny.hegewald@online.de>
Subject: Re: [PATCH] resolve collision of generic ATA_FLAG_LOWTAG and driver specific flag
Date: Wed, 15 Apr 2015 22:56:50 +0000
Message-ID: <201504152256.50452.ronny.hegewald@online.de>
References: <201504092009.08703.ronny.hegewald@online.de> <55280213.9000601@cogentembedded.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:59281 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbbDOW5e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Apr 2015 18:57:34 -0400
In-Reply-To: <55280213.9000601@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-ide@vger.kernel.org

On Friday 10 April 2015, you wrote
> Actually, ATA_FLAG_LOWTAG has been removed in the 'for-next' branch, so
> this patch is no longer needed. 

Its still needed for kernel <= 3.19, else the driver will malfunction for 
SI3132 based chipsets.

> Moreover, the newly assigned flag clashes with the new ATA_FLAG_SATA_PORT.

As far i can tell its not really a problem in practice for this driver, as 
they will not be used together. But its certainly better to keep the flags 
clash-free nonetheless. I will change it to bit 31 in the next version of the 
patch.

