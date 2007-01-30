From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 0/2] ide: clear bmdma status in ide_intr for Intel controllers
 (revised #3)
Date: Tue, 30 Jan 2007 10:49:38 +0800
Message-ID: <45BEB242.7070506@tw.ibm.com>
References: <45AF57BE.7060505@tw.ibm.com>	 <58cb370e0701191133m3dd584ffna5b231b00392c13d@mail.gmail.com>	 <45B12318.9000704@gmail.com> <45B467A9.6040404@tw.ibm.com>	 <45B479C2.7090300@tw.ibm.com> <58cb370e0701220805i783dddafse768e500b27fff36@mail.gmail.com> <45B6D386.3030104@tw.ibm.com> <45B6D5A7.6080700@tw.ibm.com> <45B7596F.6080504@ru.mvista.com> <45B878F0.7060707@tw.ibm.com> <45B8CA02.4050701@ru.mvista.com> <45B8DD84.3090700@ru.mvista.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:41526 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbXA3Ct7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Jan 2007 21:49:59 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0U2nqVR022521
	for <linux-ide@vger.kernel.org>; Mon, 29 Jan 2007 21:49:52 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l0U2nqou552914
	for <linux-ide@vger.kernel.org>; Mon, 29 Jan 2007 19:49:52 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l0U2np3N017134
	for <linux-ide@vger.kernel.org>; Mon, 29 Jan 2007 19:49:51 -0700
In-Reply-To: <45B8DD84.3090700@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, "Adam W. Hawks" <awhawks@us.ibm.com>

patch 1/2: remove clearing bmdma status from cdrom_decode_status() since ATA devices might need it as well.

patch 2/2: clear bmdma status in ide_intr() and add a new hwif->ide_dma_clear_irq for piix.c to use.

