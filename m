From: Stan Hoeppner <stan@hardwarefreak.com>
Subject: Re: PMP 3726 problem?
Date: Wed, 29 Dec 2010 19:06:24 -0600
Message-ID: <4D1BDB10.803@hardwarefreak.com>
References: <AANLkTi=6yROpG+nXHYPqHwbQucwQqmrai9yCyx=GFCPG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-65-41-216-221.sta.embarqhsd.net ([65.41.216.221]:57407 "EHLO
	greer.hardwarefreak.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754529Ab0L3BG0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Dec 2010 20:06:26 -0500
Received: from [192.168.100.53] (gffx.hardwarefreak.com [192.168.100.53])
	by greer.hardwarefreak.com (Postfix) with ESMTP id 0F6306C0B1
	for <linux-ide@vger.kernel.org>; Wed, 29 Dec 2010 19:06:25 -0600 (CST)
In-Reply-To: <AANLkTi=6yROpG+nXHYPqHwbQucwQqmrai9yCyx=GFCPG@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Phill Jolliffe put forth on 12/29/2010 6:44 PM:
> Hi,
> 
> I'm having probelms with a DAS401 edge store disk enclosure. I have
> 4x Hitachi HDS72202 loaded into it. Wonder is this is a PMP driver
> problem?

> Unfortunately I have less than 50% chance on any given system startup
> that the disks are detected. As best I can tell the the DAS401 uses a
> SiI3726 Port-Multiplier built into the enclosure. I connect this to
> the mobo single esata builtin port.

1.  Have you tried the PCIe x1 eSATA card that came bundled with your
unit?  Does it work properly using that card?

1.  Have you tried more than 1 eSATA cable?

3.  Do you have any equipment of any kind, that generates EMI or RFI, in
close proximity (1 meter) to the PC, disk box, or the cable?  This would
include high voltage transformers (florescent lights), low voltage
transformers (wall warts--cell charger, cordless drill charger, etc),
electric pencil sharpeners, paper shredders, anything with an electric
motor, a cordless phone/base unit, anything electronic that could be
injecting noise into the eSATA cable?

Having these answers make troubleshooting easier, especially the answer
to #1 above.

-- 
Stan
