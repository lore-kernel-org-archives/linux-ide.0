From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Fix ata_task_ioctl to return ATA registers on check condition
Date: Tue, 19 Dec 2006 16:20:40 +0900
Message-ID: <458792C8.1010700@gmail.com>
References: <458174D7.1020307@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.235]:27674 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872AbWLSHUs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Dec 2006 02:20:48 -0500
Received: by nz-out-0506.google.com with SMTP id s1so686796nze
        for <linux-ide@vger.kernel.org>; Mon, 18 Dec 2006 23:20:47 -0800 (PST)
In-Reply-To: <458174D7.1020307@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

David Milburn wrote:
> The HDIO_DRIVE_TASK ioctl should output the taskfile register values,
> the smartctl utility checks the values of the lba registers specifically
> the values of lbam and lbah for failure status (0xf4 and 0x2c
> respectively). This patch will copy the ATA registers back to the
> user-space application on a check condition similiar to ata_cmd_ioctl().
> 
> Please ACK or comment.

Acked-by: Tejun Heo <htejun@gmail.com>

Great, but you need to resend the patch with Signed-off-by: line.

-- 
tejun
