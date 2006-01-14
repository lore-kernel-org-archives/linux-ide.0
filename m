From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 1/4] SATA ACPI build (applies to 2.6.16-git9)
Date: Sat, 14 Jan 2006 08:28:10 +0100
Message-ID: <20060114072810.GA7866@mars.ravnborg.org>
References: <20060113224252.38d8890f.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pasmtp.tele.dk ([193.162.159.95]:39181 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751233AbWANH2u (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Jan 2006 02:28:50 -0500
Content-Disposition: inline
In-Reply-To: <20060113224252.38d8890f.rdunlap@xenotime.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>, jgarzik <jgarzik@pobox.com>

Hi Randy
 
> --- linux-2615-g9.orig/drivers/scsi/Makefile
> +++ linux-2615-g9/drivers/scsi/Makefile
> @@ -164,6 +164,9 @@ CFLAGS_ncr53c8xx.o	:= $(ncr53c8xx-flags-
>  zalon7xx-objs	:= zalon.o ncr53c8xx.o
>  NCR_Q720_mod-objs	:= NCR_Q720.o ncr53c8xx.o
>  libata-objs	:= libata-core.o libata-scsi.o
> +ifeq ($(CONFIG_SCSI_SATA_ACPI),y)
> +  libata-objs	+= libata-acpi.o
> +endif

How about:
libata-y	:= libata-core.o libata-scsi.o
libata-$(CONFIG_SCSI_SATA_ACPI) += libata-acpi.o

	Sam

