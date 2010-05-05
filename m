From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v2] libata: update developer's guide
Date: Wed, 05 May 2010 14:54:29 -0400
Message-ID: <4BE1BEE5.7090104@pobox.com>
References: <201005051727.10803.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47398 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758086Ab0EESyg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 May 2010 14:54:36 -0400
Received: by vws12 with SMTP id 12so1262361vws.19
        for <linux-ide@vger.kernel.org>; Wed, 05 May 2010 11:54:35 -0700 (PDT)
In-Reply-To: <201005051727.10803.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On 05/05/2010 09:27 AM, Sergei Shtylyov wrote:
> Commit 6bfff31e77cfa1b13490337e5a4dbaa3407e83ac (libata: kill probe_ent
> and related helpers) killed ata_device_add() but didn't remove references
> to it from the libata developer's guide.
>
> Commits 9363c3825ea9ad76561eb48a395349dd29211ed6 (libata: rename SFF
> functions) and 5682ed33aae05d10a25c95633ef9d9c062825888 (libata: rename
> SFF port ops) renamed the taskfile access methods but didn't update the
> developer's guide.  Commit c9f75b04ed5ed65a058d18a8a8dda50632a96de8
> (libata: kill ata_noop_dev_select()) didn't update the developer's
> guide as well.
>
> The guide also refers to the long gone ata_pio_data_xfer_noirq(),
> ata_pio_data_xfer(), and ata_mmio_data_xfer() -- replace those by
> the modern ata_sff_data_xfer_noirq(), ata_sff_data_xfer(), and
> ata_sff_data_xfer32().
>
> Also, remove the reference to non-existant ata_port_stop()...
>
> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
>
> ---
> The patch is against the recent Linus' tree.
>
> Changes since the previous version:
> - I've just realized that I forgot to rename the taskfile methods themselves.
>
>   Documentation/DocBook/libata.tmpl |   49 ++++++++++++--------------------------
>   1 file changed, 16 insertions(+), 33 deletions(-)

applied


