From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 04/30] ACPI driver support for pata
Date: Tue, 6 Mar 2007 15:14:15 +0000
Message-ID: <20070306151415.45db1d52@lxorguk.ukuu.org.uk>
References: <200703061037.l26AbrtB019463@shell0.pdx.osdl.net>
	<45ED649A.20207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48960 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965027AbXCFOLi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Mar 2007 09:11:38 -0500
In-Reply-To: <45ED649A.20207@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: akpm@linux-foundation.org, jeff@garzik.org, linux-ide@vger.kernel.org, alan@redhat.com, lenb@kernel.org

> using separate pata_acpi driver (we can definitely implement pata_acpi
> using the helpers).  It will reduce general confusion and allow
> combining acpi cable detection with specialized device handling (e.g.
> ACPI cable detection combined with ADMA command operation).

Read the code Tejun, I did exactly that. pata_acpi is a driver which uses
a nice clean set of helper methods I added to libata-acpi. pata_acpi
itself knows nothing about ACPI other than calling into libata-acpi.

Alan
