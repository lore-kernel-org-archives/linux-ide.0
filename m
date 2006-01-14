From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH 1/4] SATA ACPI build (applies to 2.6.16-git9)
Date: Fri, 13 Jan 2006 23:30:44 -0800
Message-ID: <20060113233044.248bcd1d.rdunlap@xenotime.net>
References: <20060113224252.38d8890f.rdunlap@xenotime.net>
	<20060114072810.GA7866@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:48331 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751268AbWANHas (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Jan 2006 02:30:48 -0500
Received: from midway ([71.111.157.99]) by xenotime.net for <linux-ide@vger.kernel.org>; Fri, 13 Jan 2006 23:30:46 -0800
In-Reply-To: <20060114072810.GA7866@mars.ravnborg.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com

On Sat, 14 Jan 2006 08:28:10 +0100 Sam Ravnborg wrote:

> Hi Randy
>  
> > --- linux-2615-g9.orig/drivers/scsi/Makefile
> > +++ linux-2615-g9/drivers/scsi/Makefile
> > @@ -164,6 +164,9 @@ CFLAGS_ncr53c8xx.o	:= $(ncr53c8xx-flags-
> >  zalon7xx-objs	:= zalon.o ncr53c8xx.o
> >  NCR_Q720_mod-objs	:= NCR_Q720.o ncr53c8xx.o
> >  libata-objs	:= libata-core.o libata-scsi.o
> > +ifeq ($(CONFIG_SCSI_SATA_ACPI),y)
> > +  libata-objs	+= libata-acpi.o
> > +endif
> 
> How about:
> libata-y	:= libata-core.o libata-scsi.o
> libata-$(CONFIG_SCSI_SATA_ACPI) += libata-acpi.o

Hi Sam,
OK, I'll change that.

Thanks.
---
~Randy
