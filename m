From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 3/5] sata_dwc: Add support ATAPI transfer
Date: Thu, 10 May 2012 14:52:44 +0400
Message-ID: <4FAB9DFC.4040403@mvista.com>
References: <1336623449-7697-1-git-send-email-tqnguyen@apm.com> <4FAB8F51.3010004@mvista.com> <CAKrQpSvqz-+w=Rvq_jtGwkEue0Tf6rh9Z5c9j4edbgeuWeMCVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:38305 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758144Ab2EJKxV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 May 2012 06:53:21 -0400
Received: by lahd3 with SMTP id d3so961803lah.19
        for <linux-ide@vger.kernel.org>; Thu, 10 May 2012 03:53:17 -0700 (PDT)
In-Reply-To: <CAKrQpSvqz-+w=Rvq_jtGwkEue0Tf6rh9Z5c9j4edbgeuWeMCVQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Thang Q. Nguyen" <tqnguyen@apm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello.

On 10-05-2012 14:12, Thang Q. Nguyen wrote:

> Thanks for quick response,
> I do not mean user use fdisk command on CD/DVD. However, whenever using 'fdisk
> -l' command, the system will access each first sector on each SCSI device
> (including CD/DVD on it) and the DMA transfer on blank CD/DVD will not return
> any data.

    Shouldn't the drive return error status in this case?

> The timeout is detected and error handler will be called.

    But user may also run 'hdparm -t' or even 'dd' with offset on a drive. 
Have you tried your workaround with those?

> Using PIO on some first sectors will avoid the issue.

> Regards,
> Thang Nguyen -

MBR, Sergei
