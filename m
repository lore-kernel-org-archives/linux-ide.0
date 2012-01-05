From: Sonic Zhang <sonic.adi@gmail.com>
Subject: Re: [PATCH v2] ata: pata_bf54x: Support sg list in bmdma transfer.
Date: Thu, 5 Jan 2012 10:47:36 +0800
Message-ID: <CAJxxZ0NtOqB1EbGj=K6zQ7jp2aMzBLDg8D9VEOhhxy=PGyw7eQ@mail.gmail.com>
References: <1325657211-21904-1-git-send-email-sonic.adi@gmail.com>
	<4F0452B8.4090101@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61396 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755649Ab2AECrh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jan 2012 21:47:37 -0500
Received: by eaad14 with SMTP id d14so46009eaa.19
        for <linux-ide@vger.kernel.org>; Wed, 04 Jan 2012 18:47:36 -0800 (PST)
In-Reply-To: <4F0452B8.4090101@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: David Miller <davem@davemloft.net>, jgarzik@pobox.com, linux-ide@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

On Wed, Jan 4, 2012 at 9:23 PM, Sergei Shtylyov <sshtylyov@mvista.com> =
wrote:
> Hello.
>
>
> On 04-01-2012 10:06, Sonic Zhang wrote:
>
>> From: Sonic Zhang<sonic.zhang@analog.com>
>
>
>> BF54x on-chip ATAPI controller allows maximum 0x1fffe bytes to be
>> transfered
>> in one ATAPI transfer. So, set the max sg_tablesize to 4.
>
>
>> Signed-off-by: Sonic Zhang<sonic.zhang@analog.com>
>> ---
>
>
> =A0 What are the changes since v1?

Structure dma_desc_array is moved into arch/blackfin/include/asm/dma.h
per the comments from Mike.

Sonic

>
> MBR, Sergei
