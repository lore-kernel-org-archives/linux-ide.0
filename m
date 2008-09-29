From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/5] libata: make SCR access ops per-link
Date: Mon, 29 Sep 2008 00:33:49 -0400
Message-ID: <48E05AAD.80102@garzik.org>
References: <1217491364-19725-1-git-send-email-tj@kernel.org> <1217491364-19725-2-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40917 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759AbYI2Edz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Sep 2008 00:33:55 -0400
In-Reply-To: <1217491364-19725-2-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, JosephChan@via.com.tw

Tejun Heo wrote:
> Logically, SCR access ops should take @link; however, there was no
> compelling reason to convert all SCR access ops when adding @link
> abstraction as there's one-to-one mapping between a port and a non-PMP
> link.  However, that assumption won't hold anymore with the scheduled
> addition of slave link.
> 
> Make SCR access ops per-link.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  drivers/ata/ahci.c            |   24 ++++++++++++------------
>  drivers/ata/ata_piix.c        |   15 +++++++++++----
>  drivers/ata/libata-core.c     |   13 ++++---------
>  drivers/ata/sata_fsl.c        |   26 +++++++++++++-------------
>  drivers/ata/sata_inic162x.c   |    8 ++++----
>  drivers/ata/sata_mv.c         |   28 ++++++++++++++--------------
>  drivers/ata/sata_nv.c         |   16 ++++++++--------
>  drivers/ata/sata_promise.c    |   16 +++++++++-------
>  drivers/ata/sata_qstor.c      |   12 ++++++------
>  drivers/ata/sata_sil.c        |   16 ++++++++--------
>  drivers/ata/sata_sil24.c      |   12 ++++++------
>  drivers/ata/sata_sis.c        |   28 ++++++++++++++++------------
>  drivers/ata/sata_svw.c        |   10 ++++++----
>  drivers/ata/sata_uli.c        |   24 ++++++++++++------------
>  drivers/ata/sata_via.c        |   24 ++++++++++++------------
>  drivers/ata/sata_vsc.c        |   10 ++++++----
>  drivers/scsi/libsas/sas_ata.c |    8 ++++----
>  include/linux/libata.h        |    4 ++--
>  18 files changed, 153 insertions(+), 141 deletions(-)

applied 1-5


