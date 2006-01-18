From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: fix sparse warnings
Date: Tue, 17 Jan 2006 19:40:43 -0500
Message-ID: <43CD8E8B.4020700@pobox.com>
References: <20051225193427.0962fdea.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:65456 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932464AbWARAkq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jan 2006 19:40:46 -0500
In-Reply-To: <20051225193427.0962fdea.rdunlap@xenotime.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-ide@vger.kernel.org

Randy.Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Question:  in patch block 2, what are the semantics of the user <arg>?
> Does it point to an input u8 args[4] which must be immediately followed
> by an output u8 args[4]?  That's what it seems to be.  Just checking.
> 
> 
> Fix sparse warnings:
> drivers/scsi/libata-scsi.c:154:15: warning: cast removes address space of expression
> drivers/scsi/libata-scsi.c:204:20: warning: cast removes address space of expression
> drivers/scsi/libata-scsi.c:204:20: warning: incorrect type in argument 1 (different address spaces)
> drivers/scsi/libata-scsi.c:204:20:    expected void [noderef] *to<asn:1>
> drivers/scsi/libata-scsi.c:204:20:    got void *<noident>
> drivers/scsi/libata-scsi.c:231:15: warning: cast removes address space of expression

Can you resend this and any other non-ACPI patches you have pending, please?

	Jeff



