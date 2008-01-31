From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: Re: [PATCHSET libata-dev#upstream] clean up scsi_host_templates and
 ata_port_operations
Date: Thu, 31 Jan 2008 17:34:17 +0900
Message-ID: <200801310833.m0V8Xh1l027206@toshiba.co.jp>
References: <12016853433196-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imx12.toshiba.co.jp ([61.202.160.132]:34060 "EHLO
	imx12.toshiba.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765344AbYAaIdq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 Jan 2008 03:33:46 -0500
Received: from arc11.toshiba.co.jp ([133.199.90.127])
	by imx12.toshiba.co.jp  with ESMTP id m0V8XjpG017955
	for <linux-ide@vger.kernel.org>; Thu, 31 Jan 2008 17:33:45 +0900 (JST)
Received: (from root@localhost)
	by arc11.toshiba.co.jp  id m0V8Xjl0021944
	for linux-ide@vger.kernel.org; Thu, 31 Jan 2008 17:33:45 +0900 (JST)
Received: from mx.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id m0V8Xick006749
	for <linux-ide@vger.kernel.org>; Thu, 31 Jan 2008 17:33:44 +0900 (JST)
In-Reply-To: (Your message of "Wed, 30 Jan 2008 18:28:54 +0900")
  <12016853433196-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, alessandro.zummo@towertech.it, domen.puncer@telargo.com, leoli@freescale.com

Tejun Heo wrote:
>The following drivers need specific platform to build, so they need
>verification.  If you work on one of the following drivers, please
>verify that the driver builds and works fine.  It would be best if you
>can verify that the sht and ops don't change by the fifth path using
>the method I'll write in another message.
..
>* pata_scc

I check pata_scc and it works fine.
Your verification method detects 1 difference in ops
(.thaw: NULL -> ata_bmdma_thaw) but there is no problem.

Cheers
