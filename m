From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH libata-dev#upstream 3/3] libata: implement and use ata_port_desc()
 to report port configuration
Date: Wed, 15 Aug 2007 04:48:46 -0400
Message-ID: <46C2BDEE.7060705@garzik.org>
References: <20070730052303.GH22374@htj.dyndns.org> <20070730052415.GI22374@htj.dyndns.org> <20070730052527.GJ22374@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51827 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758882AbXHOIsu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Aug 2007 04:48:50 -0400
In-Reply-To: <20070730052527.GJ22374@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Currently, port configuration reporting has the following problems.
> 
> * iomapped address is reported instead of raw address
> * report contains irrelevant fields or lacks necessary fields for
>   non-SFF controllers.
> * host->irq/irq2 are there just for reporting and hacky.
> 
> This patch implements and uses ata_port_desc() and
> ata_port_pbar_desc().  ata_port_desc() is almost identical to
> ata_ehi_push_desc() except that it takes @ap instead of @ehi, has no
> locking requirement, can only be used during host initialization and "
> " is used as separator instead of ", ".  ata_port_pbar_desc() is a
> helper to ease reporting of a PCI BAR or an offsetted address into it.
> 
> LLD pushes whatever description it wants using the above two
> functions.  The accumulated description is printed on host
> registration after "[S/P]ATA max MAX_XFERMODE ".
> 
> SFF init helpers and ata_host_activate() automatically add
> descriptions for addresses and irq respectively, so only LLDs which
> isn't standard SFF need to add custom descriptions.  In many cases,
> such controllers need to report different things anyway.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> pata_hpt3x3 fixed as pointed out by Alan.
> 
>  drivers/ata/ahci.c           |    4 ++
>  drivers/ata/libata-core.c    |   27 +++++++----------
>  drivers/ata/libata-eh.c      |   67 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/ata/libata-sff.c     |   23 +++++++++++---
>  drivers/ata/pata_cs5520.c    |   23 +++++++++-----
>  drivers/ata/pata_hpt3x3.c    |    6 +++
>  drivers/ata/pata_icside.c    |   19 ++++++++++--
>  drivers/ata/pata_isapnp.c    |    4 ++
>  drivers/ata/pata_ixp4xx_cf.c |   13 +++++++-
>  drivers/ata/pata_legacy.c    |    2 +
>  drivers/ata/pata_mpc52xx.c   |    7 +++-
>  drivers/ata/pata_mpiix.c     |   16 ++++++----
>  drivers/ata/pata_pcmcia.c    |    2 +
>  drivers/ata/pata_pdc2027x.c  |   17 +++++++---
>  drivers/ata/pata_platform.c  |    4 ++
>  drivers/ata/pata_qdi.c       |    5 ++-
>  drivers/ata/pata_scc.c       |    3 +
>  drivers/ata/pata_winbond.c   |    7 +++-
>  drivers/ata/pdc_adma.c       |   13 ++++++--
>  drivers/ata/sata_inic162x.c  |   14 +++++++-
>  drivers/ata/sata_mv.c        |    8 ++++-
>  drivers/ata/sata_promise.c   |   11 +++++--
>  drivers/ata/sata_qstor.c     |   11 +++++--
>  drivers/ata/sata_sil.c       |    6 +++
>  drivers/ata/sata_sil24.c     |    7 +++-
>  drivers/ata/sata_svw.c       |   12 +++++--
>  drivers/ata/sata_sx4.c       |   19 +++++++-----
>  drivers/ata/sata_uli.c       |   13 ++++++++
>  drivers/ata/sata_via.c       |    3 +
>  drivers/ata/sata_vsc.c       |   12 +++++--
>  include/linux/libata.h       |   12 ++++++-
>  31 files changed, 309 insertions(+), 81 deletions(-)

ACK, request rediff once #upstream mirrors out


