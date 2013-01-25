From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH #upstream] revert libata: export host controller number
 thru /sys
Date: Fri, 25 Jan 2013 15:31:18 -0500
Message-ID: <5102EB96.70405@pobox.com>
References: <1359045189-16813-1-git-send-email-dmilburn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:51027 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab3AYUg5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jan 2013 15:36:57 -0500
Received: by mail-qc0-f177.google.com with SMTP id u28so398561qcs.22
        for <linux-ide@vger.kernel.org>; Fri, 25 Jan 2013 12:36:56 -0800 (PST)
In-Reply-To: <1359045189-16813-1-git-send-email-dmilburn@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: linux-ide@vger.kernel.org, kay.sievers@vrfy.org, coughlan@redhat.com, fengguang.wu@intel.com, gwendal@google.com

On 01/24/2013 11:33 AM, David Milburn wrote:
>      Revert "libata: export host controller number thru /sys"
>
>      This reverts commit 1757d902b029a29dfcef63609964385cf8865b5a.
>
>      Solution still uses global counter for ata port.
>
> Signed-off-by: David Milburn <dmilburn@redhat.com>
> ---
>   drivers/ata/libata-core.c      |    4 ----
>   drivers/ata/libata-transport.c |    2 +-
>   include/linux/libata.h         |    1 -
>   3 files changed, 1 insertions(+), 6 deletions(-)

applied



