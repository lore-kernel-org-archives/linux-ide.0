From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 00/86] PATA fixes
Date: Thu, 03 Dec 2009 03:07:41 -0500
Message-ID: <4B1771CD.3090409@garzik.org>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:46147 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbZLCIHg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2009 03:07:36 -0500
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/25/2009 12:02 PM, Bartlomiej Zolnierkiewicz wrote:
> Hi,
>
> I've been going through PATA drivers for the last few days to make
> sure that we offer similar level of hardware support in the new PATA
> drivers as with the old IDE subsystem and the following patchset is
> the end result of said audit.
>
>
> Inside:
>
> - many bugfixes
>
>    ( ata_piix, pata_artop, pata_atiixp, pata_efar, pata_cmd64x,
>      pata_hpt3x3, pata_it8213, pata_legacy, pata_ns87415, pata_sis,
>      pata_radisys, pata_rz1000&  pata_via )
>
> - add Power Management support for more controllers
>
>    ( pata_artop, pata_pdc2027x, pata_sl82c105 )
>
> - add 32-bit PIO support for more controllers
>
>    ( pata_artop, pata_atiixp, pata_efar, pata_cmd64x, pata_cs5520,
>      pata_cs5530, pata_cs5535, pata_cypress, pata_hpt366, pata_hpt37x,
>      pata_hpt3x2n, pata_it8213, pata_it821x, pata_jmicron, pata_ns87415,
>      pata_opti, pata_pdc2027x, pata_pdc202xx_old, pata_rz1000,
>      pata_sc1200, pata_scc, pata_sch, pata_serverworks, pata_sl82c105,
>      pata_sis, pata_triflex&  pata_via )
>
> - fix QDI65x0 support in pata_legacy driver so pata_qdi driver can
>    be finally removed
>
> - remove pata_qdi and pata_winbond drivers resulting in 600 LOC gone
>
>    (affected hardware is fully supported by pata_legacy driver now)
>
> - unify code for programming PIO and MWDMA timings for 'PIIX-like'
>    controllers resulting in 200 LOC gone
>
>    ( ata_piix, pata_efar, pata_it8213, pata_oldpiix, pata_radisys&
>      pata_rdc )
>
> - add ->init_host method for abstracting host specific controller
>    initialization and then use it to cleanup Power Managment code
>    resulting in over 100 LOC gone
>
>    ( pata_ali, pata_amd, pata_artop, pata_cmd640, pata_cmd64x,
>      pata_cs5530, pata_hpt366, pata_hpt3x3, pata_it821x, pata_ninja32,
>      pata_ns87415, pata_pdc2027x&  sata_sil )
>
> - misc fixes and cleanups

What are your plans for 2.6.33?

The merge window is upon us, which by strict rules means that anything 
not already in libata-dev.git#upstream needs to wait until 2.6.34.

However, bug fixes and the like should definitely be in 2.6.33. 
->init_host is definitely 2.6.34 material.  Some of the other stuff 
could go either way.

	Jeff



