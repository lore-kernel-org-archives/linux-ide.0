From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 04/30] ACPI driver support for pata
Date: Tue, 06 Mar 2007 23:18:36 +0900
Message-ID: <45ED783C.6060604@gmail.com>
References: <200703061037.l26AbrtB019463@shell0.pdx.osdl.net>	<45ED649A.20207@gmail.com> <20070306151415.45db1d52@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:39393 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965052AbXCFOSj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Mar 2007 09:18:39 -0500
Received: by an-out-0708.google.com with SMTP id b33so1768559ana
        for <linux-ide@vger.kernel.org>; Tue, 06 Mar 2007 06:18:38 -0800 (PST)
In-Reply-To: <20070306151415.45db1d52@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@linux-foundation.org, jeff@garzik.org, linux-ide@vger.kernel.org, alan@redhat.com, lenb@kernel.org

Alan Cox wrote:
>> using separate pata_acpi driver (we can definitely implement pata_acpi
>> using the helpers).  It will reduce general confusion and allow
>> combining acpi cable detection with specialized device handling (e.g.
>> ACPI cable detection combined with ADMA command operation).
> 
> Read the code Tejun, I did exactly that. pata_acpi is a driver which uses
> a nice clean set of helper methods I added to libata-acpi. pata_acpi
> itself knows nothing about ACPI other than calling into libata-acpi.

Actually, I have.  I was thinking of higher level helpers.  e.g.
pacpi_cable_detect() in libata-acpi.c such that sata_nv's cable_detect
can do.

int nv_cable_detect(struct ata_port *ap)
{
	if (ck804) {
		if (pacpi_cable_detect(ap) == 0)
			return 0;
	}

	/* do original nv cable detection */
	return rc;
}

So that it's more robust && we don't have to alternate between sata_nv,
pata_acpi depending on BIOS/kernel configuration, and possibly combine
other low level features with ACPI support.

-- 
tejun
