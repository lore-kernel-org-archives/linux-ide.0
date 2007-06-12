From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 3/3] Enable Aggressive Link Power management for AHCI
 controllers.
Date: Wed, 13 Jun 2007 00:45:21 +0900
Message-ID: <466EBF91.8060508@gmail.com>
References: <20070612011148.GA9808@khazad-dum.debian.net> <466DF3E9.30303@linux.intel.com> <d8jr6oikkcz.fsf@nygaard.ping.uio.no> <466DFE09.3020408@garzik.org> <20070612035928.GB9808@khazad-dum.debian.net> <466E1A32.90306@linux.intel.com> <20070612090940.GA9719@srcf.ucam.org> <20070612121819.GA20408@khazad-dum.debian.net> <20070612135010.GA12601@srcf.ucam.org> <20070612141714.GB20408@khazad-dum.debian.net> <20070612153828.GA13888@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:17291 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757005AbXFLPpd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Jun 2007 11:45:33 -0400
Received: by py-out-1112.google.com with SMTP id a29so3322240pyi
        for <linux-ide@vger.kernel.org>; Tue, 12 Jun 2007 08:45:31 -0700 (PDT)
In-Reply-To: <20070612153828.GA13888@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Arjan van de Ven <arjan@linux.intel.com>, Jeff Garzik <jeff@garzik.org>, =?ISO-8859-1?Q?Dagfinn_Ilmari_Manns=E5?= =?ISO-8859-1?Q?ker?= <ilmari@ilmari.org>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, james.bottomley@steeleye.com, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org

Matthew Garrett wrote:
> On Tue, Jun 12, 2007 at 11:17:14AM -0300, Henrique de Moraes Holschuh wrote:
>> On Tue, 12 Jun 2007, Matthew Garrett wrote:
>>> Laptop bays are designed to deal with hotplugging PATA - I don't think 
>>> this is too much of an issue :)
>> The new SATA ones use the SATA hardware hotplug ;-)   Just like the pci-e
>> cards use usb2.0 and pci-e hotplug...
> 
> Yes, but they'll also send an ACPI interrupt even if the SATA host 
> controller doesn't - it's part of the spec for bays.

Does the spec mandate that the ACPI interrupt shouldn't depend on SATA
phy status?  I don't think vendors are likely to implement separate
mechanism when SATA phy status can do the job fine.

-- 
tejun
