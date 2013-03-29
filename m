From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2] [libata] Fix HDIO_DRIVE_CMD ioctl sense data check
Date: Fri, 29 Mar 2013 23:01:36 +0300
Message-ID: <5155F320.2020004@cogentembedded.com>
References: <1364576992-17598-1-git-send-email-gwendal@google.com> <1364577166-17930-1-git-send-email-gwendal@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:42855 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754502Ab3C2TCL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Mar 2013 15:02:11 -0400
Received: by mail-la0-f52.google.com with SMTP id fs12so725703lab.25
        for <linux-ide@vger.kernel.org>; Fri, 29 Mar 2013 12:02:09 -0700 (PDT)
In-Reply-To: <1364577166-17930-1-git-send-email-gwendal@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: ronald645@gmail.com, krzysiek@podlesie.net, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 03/29/2013 08:12 PM, Gwendal Grignou wrote:

> commit 84a9a8cd9d0aa93c17e5815ab8a9cc4c0a765c63

    Please, also specify that commit's summary line in parens
(or however you like).

>   changed the sense key
> used for returning task registers, but HDIO_DRIVE_CMD ioctl was
> not changed accordingly.
>
> Tested: check that SMART ENABLE sent using HDIO_DRIVE_CMD returns 0
> instead of EIO.
>
> Signed-off-by: Gwendal Grignou <gwendal@google.com>
>

MBR, Sergei

