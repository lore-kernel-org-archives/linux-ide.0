From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 04/30] ACPI driver support for pata
Date: Tue, 06 Mar 2007 09:26:47 -0500
Message-ID: <45ED7A27.3030504@garzik.org>
References: <200703061037.l26AbrtB019463@shell0.pdx.osdl.net>	<45ED649A.20207@gmail.com> <20070306151415.45db1d52@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54811 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965044AbXCFO0y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 09:26:54 -0500
In-Reply-To: <20070306151415.45db1d52@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, akpm@linux-foundation.org, linux-ide@vger.kernel.org, alan@redhat.com, lenb@kernel.org

Alan Cox wrote:
>> using separate pata_acpi driver (we can definitely implement pata_acpi
>> using the helpers).  It will reduce general confusion and allow
>> combining acpi cable detection with specialized device handling (e.g.
>> ACPI cable detection combined with ADMA command operation).
> 
> Read the code Tejun, I did exactly that. pata_acpi is a driver which uses
> a nice clean set of helper methods I added to libata-acpi. pata_acpi
> itself knows nothing about ACPI other than calling into libata-acpi.

Tejun is just repeating what I've been saying:  you don't need a 
separate driver, call out from sata_nv or whereever instead.

	Jeff



