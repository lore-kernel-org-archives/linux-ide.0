From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata-scsi: ata_task_ioctl should return ATA registers
 from sense data
Date: Tue, 19 Dec 2006 16:29:35 +0900
Message-ID: <458794DF.8070100@gmail.com>
References: <458702D9.6080800@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:44315 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932178AbWLSH3o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Dec 2006 02:29:44 -0500
Received: by py-out-1112.google.com with SMTP id a29so974850pyi
        for <linux-ide@vger.kernel.org>; Mon, 18 Dec 2006 23:29:43 -0800 (PST)
In-Reply-To: <458702D9.6080800@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

David Milburn wrote:
> User applications using the HDIO_DRIVE_TASK ioctl through libata
> expect specific ATA registers to be returned to userspace. Verified
> that ata_task_ioctl correctly returns register values to the
> smartctl application.
> 
> Signed-off-by: David Milburn <dmilburn@redhat.com>
Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
