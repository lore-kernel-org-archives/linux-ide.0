From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] libata: clean up scsi_host_templates and ata_port_operations,
 take #3
Date: Wed, 12 Mar 2008 15:48:41 +0900
Message-ID: <47D77CC9.2090909@gmail.com>
References: <12052371651181-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:25983 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbYCLGtG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Mar 2008 02:49:06 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3262719wah.23
        for <linux-ide@vger.kernel.org>; Tue, 11 Mar 2008 23:49:06 -0700 (PDT)
In-Reply-To: <12052371651181-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@arm.linux.org.uk, alessandro.zummo@towertech

devres-implement-pcim_iomap_regions_request_all was missing changes from
include/linux/pci.h.  Updated patch posted and git trees updated
accordingly.

Thanks.

-- 
tejun
