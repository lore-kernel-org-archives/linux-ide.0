From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET libata-dev#upstream] clean up scsi_host_templates and
 ata_port_operations, take #2
Date: Wed, 13 Feb 2008 09:03:16 +0900
Message-ID: <47B233C4.2080700@gmail.com>
References: <1202805801343-git-send-email-htejun@gmail.com> <200802122354.m1CNsV4n011311@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:36232 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbYBMADb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Feb 2008 19:03:31 -0500
Received: by wr-out-0506.google.com with SMTP id c48so4825238wra.23
        for <linux-ide@vger.kernel.org>; Tue, 12 Feb 2008 16:03:31 -0800 (PST)
In-Reply-To: <200802122354.m1CNsV4n011311@toshiba.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@arm.linux.org.uk, alessandro.zummo@towertech.it, domen.puncer@telargo.com, leoli@freescale.com

Akira Iguchi wrote:
> Tejun Heo wrote:
>> * pata_scc should now have NULL thaw after conversion.
> 
> I'm sorry. This is a bug.
> Please use default thaw (ata_bmdma_thaw) for pata_scc.

That change should be a separate patch.  This patchset shouldn't change
any actual behavior but adding ata_bmdma_thaw does change the behavior.
 Can you please submit a separate patch to fix it?

Thanks.

-- 
tejun
