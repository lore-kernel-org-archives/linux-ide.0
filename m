From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH resend] pata_hpt3x2n: fix clock turnaround
Date: Thu, 17 Dec 2009 01:13:12 -0500
Message-ID: <4B29CBF8.1070709@pobox.com>
References: <200912071652.57615.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:48248 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759102AbZLQGNP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Dec 2009 01:13:15 -0500
Received: by yxe17 with SMTP id 17so1663456yxe.33
        for <linux-ide@vger.kernel.org>; Wed, 16 Dec 2009 22:13:14 -0800 (PST)
In-Reply-To: <200912071652.57615.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, stable@kernel.org

On 12/07/2009 08:52 AM, Sergei Shtylyov wrote:
> The clock turnaround code still doesn't work for several reasons:
>
> - 'USE_DPLL' flag in 'ap->host->private_data' is never initialized or=
 updated,
>    so the driver can only set the chip to the DPLL clock mode, not th=
e PCI mode;
>
> - the driver doesn't serialize access to the channels depending on th=
e current
>    clock mode like the vendor drivers, so the clock turnaround is onl=
y executed
>    "optionally", not always as it should be;
>
> - the wrong ports are written to when hpt3x2n_set_clock() is called f=
or the
>    secondary channel;
>
> - hpt3x2n_set_clock() can inadvertently enable the disabled channels =
when
>    resetting the channel state machines.
>
> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
> Cc:stable@kernel.org

applied, after fixing this newly-appearing niggle:

drivers/ata/pata_hpt3x2n.c: In function =91hpt3x2n_qc_issue=92:
drivers/ata/pata_hpt3x2n.c:327: warning: cast to pointer from integer o=
f=20
different size
