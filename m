From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata-scsi: ata_task_ioctl should return ATA registers
 from sense data
Date: Wed, 20 Dec 2006 14:21:44 -0500
Message-ID: <45898D48.8020800@pobox.com>
References: <458702D9.6080800@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34974 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030321AbWLTTVr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Dec 2006 14:21:47 -0500
In-Reply-To: <458702D9.6080800@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

David Milburn wrote:
> User applications using the HDIO_DRIVE_TASK ioctl through libata
> expect specific ATA registers to be returned to userspace. Verified
> that ata_task_ioctl correctly returns register values to the
> smartctl application.
> 
> Signed-off-by: David Milburn <dmilburn@redhat.com>

ACK, but fails to apply to libata-dev.git#upstream-fixes:


[jgarzik@pretzel libata-dev]$ git-applymbox /g/tmp/mbox ~/info/signoff.txt
1 patch(es) to process.

Applying 'libata-scsi: ata_task_ioctl should return ATA registers from 
sense data'

fatal: corrupt patch at line 83

