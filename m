From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: Integrate ACPI-based PATA/SATA hotplug - version
 2
Date: Sun, 16 Sep 2007 14:22:55 +0200
Message-ID: <46ED201F.3060109@gmail.com>
References: <20070915030154.GA17655@srcf.ucam.org> <20070915170652.GA25504@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:39703 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbXIPMYq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Sep 2007 08:24:46 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1048676rvb
        for <linux-ide@vger.kernel.org>; Sun, 16 Sep 2007 05:24:46 -0700 (PDT)
In-Reply-To: <20070915170652.GA25504@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org

Matthew Garrett wrote:
> +static void ata_acpi_notify(acpi_handle handle, u32 event, void *data)
> +{
> +	struct ata_port *ap = data;
> +	struct ata_eh_info *ehi = &ap->eh_info;
> +
> +	ata_ehi_clear_desc(ehi);
> +	ata_ehi_push_desc(ehi, "ACPI event");
> +	ata_ehi_hotplugged(ehi);
> +	ata_port_freeze(ap);

You probably want to wrap the above inside ap->lock.

-- 
tejun
