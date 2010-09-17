From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream 1/3] libata: add @ap to ata_wait_register()
 and introduce ata_msleep()
Date: Fri, 17 Sep 2010 02:11:08 -0400
Message-ID: <4C93067C.5010405@garzik.org>
References: <4C850F2D.4030601@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:51160 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126Ab0IQGLM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Sep 2010 02:11:12 -0400
Received: by qwh6 with SMTP id 6so1615577qwh.19
        for <linux-ide@vger.kernel.org>; Thu, 16 Sep 2010 23:11:11 -0700 (PDT)
In-Reply-To: <4C850F2D.4030601@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, yuanding02@gmail.com

On 09/06/2010 11:56 AM, Tejun Heo wrote:
> Add optional @ap argument to ata_wait_register() and replace msleep()
> calls with ata_msleep() which take optional @ap in addition to the
> duration.  These will be used to implement EH exclusion.
>
> This patch doesn't cause any behavior difference.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> ---
> These three patches fix the long-standing EH exclusion bug which was
> reported more than three years ago and recently caused obscure
> problems during parallel probing for ata_piix w/ SIDPR.
>
> It basically implements EH big lock which guarantees that only single
> EH of a host is running.  This achieves proper EH exclusion without
> pervasive changes to each driver which would be fragile while not
> harming parallel probing/EH too much.
>
> Thanks.
>
>   drivers/ata/libahci.c         |   18 +++++++++---------
>   drivers/ata/libata-core.c     |   21 ++++++++++++++-------
>   drivers/ata/libata-eh.c       |    2 +-
>   drivers/ata/libata-sff.c      |   12 ++++++------
>   drivers/ata/pata_bf54x.c      |    4 ++--
>   drivers/ata/pata_samsung_cf.c |    2 +-
>   drivers/ata/pata_scc.c        |    4 ++--
>   drivers/ata/sata_fsl.c        |   19 ++++++++++---------
>   drivers/ata/sata_inic162x.c   |    2 +-
>   drivers/ata/sata_sil24.c      |   14 +++++++-------
>   drivers/ata/sata_via.c        |    2 +-
>   include/linux/libata.h        |    5 +++--
>   12 files changed, 57 insertions(+), 48 deletions(-)

applied


