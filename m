From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 05/20] pata_acpi-restore-driver versus libata-clean-up-sff-init-mess
Date: Fri, 11 May 2007 13:43:27 +0200
Message-ID: <464456DF.5010506@gmail.com>
References: <200705110548.l4B5mlAh007627@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:47725 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758084AbXEKLni (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 07:43:38 -0400
Received: by py-out-1112.google.com with SMTP id a29so761023pyi
        for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 04:43:37 -0700 (PDT)
In-Reply-To: <200705110548.l4B5mlAh007627@shell0.pdx.osdl.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

akpm@linux-foundation.org wrote:
> From: Andrew Morton <akpm@linux-foundation.org>
> 
> If you apply both libata-clean-up-sff-init-mess.patch and
> pata_acpi-restore-driver.patch, you'll need to add this patch to
> pata_acpi-restore-driver.patch
> 
> Cc: Tejun Heo <htejun@gmail.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Patch looks good to me.  It depends on how Jeff decides on
libata-clean-up-sff-init-mess tho.

-- 
tejun
