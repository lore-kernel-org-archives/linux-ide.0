From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: SATA intel High loads due to writes vs ata_piix switch
Date: Thu, 17 May 2007 18:27:09 +0100
Message-ID: <20070517182709.54a831dd@the-village.bc.nu>
References: <8E8F647D7835334B985D069AE964A4F7028FE7F0@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
	<20070516214236.08dd02c9@the-village.bc.nu>
	<8E8F647D7835334B985D069AE964A4F7033AB605@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
	<8E8F647D7835334B985D069AE964A4F7033AB60A@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
	<8E8F647D7835334B985D069AE964A4F7033AB60B@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54310 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755146AbXEQRWz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 May 2007 13:22:55 -0400
In-Reply-To: <8E8F647D7835334B985D069AE964A4F7033AB60B@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
Cc: Linux IDE <linux-ide@vger.kernel.org>

> [root@kayak /root]# hdparm -T -t /dev/hda
> 
> /dev/hda:
>  Timing cached reads:   4816 MB in  2.00 seconds = 2408.44 MB/sec
>  Timing buffered disk reads:   12 MB in  3.23 seconds =   3.72 MB/sec

This is using PIO. How recent is your kernel - you may need a newer
kernel for the ICH8 if you only get PIO with the old IDE layer.
