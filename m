From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: Re: [PATCHSET libata-dev#upstream] clean up scsi_host_templates and
 ata_port_operations, take #2
Date: Wed, 13 Feb 2008 08:55:29 +0900
Message-ID: <200802122354.m1CNsV4n011311@toshiba.co.jp>
References: <1202805801343-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imx12.toshiba.co.jp ([61.202.160.132]:57460 "EHLO
	imx12.toshiba.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764300AbYBLXye (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Feb 2008 18:54:34 -0500
Received: from arc11.toshiba.co.jp ([133.199.90.127])
	by imx12.toshiba.co.jp  with ESMTP id m1CNsWNU020711
	for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 08:54:32 +0900 (JST)
Received: (from root@localhost)
	by arc11.toshiba.co.jp  id m1CNsW2U022587
	for linux-ide@vger.kernel.org; Wed, 13 Feb 2008 08:54:32 +0900 (JST)
Received: from mx12.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id m1CNsWqT015363
	for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 08:54:32 +0900 (JST)
In-Reply-To: (Your message of "Tue, 12 Feb 2008 17:43:11 +0900")
  <1202805801343-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@arm.linux.org.uk, alessandro.zummo@towertech.it, domen.puncer@telargo.com, leoli@freescale.com

Tejun Heo wrote:
>* pata_scc should now have NULL thaw after conversion.

I'm sorry. This is a bug.
Please use default thaw (ata_bmdma_thaw) for pata_scc.

Cheers
