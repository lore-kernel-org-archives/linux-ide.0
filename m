From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 0/5] ata: Add APM X-Gene SATA controller support
Date: Tue, 12 Nov 2013 20:34:36 +0400
Message-ID: <5282589C.2090606@cogentembedded.com>
References: <1383980431-6572-1-git-send-email-lho@apm.com> <3056580.hyyOnlSqg9@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:52010 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554Ab3KLQeb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Nov 2013 11:34:31 -0500
Received: by mail-lb0-f176.google.com with SMTP id p9so2050338lbv.7
        for <linux-ide@vger.kernel.org>; Tue, 12 Nov 2013 08:34:29 -0800 (PST)
In-Reply-To: <3056580.hyyOnlSqg9@amdc1032>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-arm-kernel@lists.infradead.org
Cc: Loc Ho <lho@apm.com>, olof@lixom.net, tj@kernel.org, linux-scsi@vger.kernel.org, jcm@redhat.com, Suman Tripathi <stripathi@apm.com>, Tuan Phan <tphan@apm.com>, linux-ide@vger.kernel.org

Hello.

On 12-11-2013 19:40, Bartlomiej Zolnierkiewicz wrote:

> Please remember to include linux-ide@vger.kernel.org on CC: for ATA patches.

> Also from the quick look it seems that:
> - patch #4 ("ata: Add APM X-Gene SATA serdes functions") should come before
>    patch #3 ("ata: Add APM X-Gene SATA driver") as code in patch #3 depends
>    on the code in patch #4
> - patch #5 ("Documentation: Add documentation for APM X-Gene SATA DTS
>    binding") should come before patch #2 ("arm64: Add APM X-Gene DTS entry
>    for SATA controllers") or (even better) just be merged into patch #2

    No, if it has to be merged then to the driver patch, not .dts patch.

> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics

WBR, Sergei

