From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v2] ata: pata_bf54x: Support sg list in bmdma transfer.
Date: Wed, 04 Jan 2012 17:23:04 +0400
Message-ID: <4F0452B8.4090101@mvista.com>
References: <1325657211-21904-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37558 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755234Ab2ADNYI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jan 2012 08:24:08 -0500
Received: by eaad14 with SMTP id d14so9364758eaa.19
        for <linux-ide@vger.kernel.org>; Wed, 04 Jan 2012 05:24:07 -0800 (PST)
In-Reply-To: <1325657211-21904-1-git-send-email-sonic.adi@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: David Miller <davem@davemloft.net>, jgarzik@pobox.com, linux-ide@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

Hello.

On 04-01-2012 10:06, Sonic Zhang wrote:

> From: Sonic Zhang<sonic.zhang@analog.com>

> BF54x on-chip ATAPI controller allows maximum 0x1fffe bytes to be transfered
> in one ATAPI transfer. So, set the max sg_tablesize to 4.

> Signed-off-by: Sonic Zhang<sonic.zhang@analog.com>
> ---

    What are the changes since v1?

MBR, Sergei
