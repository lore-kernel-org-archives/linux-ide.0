From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 0/2] ide: clear bmdma status in ide_intr for all commands
Date: Wed, 24 Jan 2007 11:33:26 +0800
Message-ID: <45B6D386.3030104@tw.ibm.com>
References: <45AF57BE.7060505@tw.ibm.com>	 <58cb370e0701191133m3dd584ffna5b231b00392c13d@mail.gmail.com>	 <45B12318.9000704@gmail.com> <45B467A9.6040404@tw.ibm.com>	 <45B479C2.7090300@tw.ibm.com> <58cb370e0701220805i783dddafse768e500b27fff36@mail.gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:43767 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965459AbXAXDdd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jan 2007 22:33:33 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id l0NHVv4L017902
	for <linux-ide@vger.kernel.org>; Tue, 23 Jan 2007 12:31:57 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l0O3XWYq547776
	for <linux-ide@vger.kernel.org>; Tue, 23 Jan 2007 20:33:32 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l0O3XWin021274
	for <linux-ide@vger.kernel.org>; Tue, 23 Jan 2007 20:33:32 -0700
In-Reply-To: <58cb370e0701220805i783dddafse768e500b27fff36@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, "Adam W. Hawks" <awhawks@us.ibm.com>

patch 1/2: remove clearing bmdma status from cdrom_decode_status() since ATA devices might need it as well.

patch 2/2: do the clearing in ide_intr() and add a new hwif->ide_dma_clear_irq such that lldd could override it.

