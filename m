From: Jeff Garzik <jeff@garzik.org>
Subject: Re: AHCI errors on ICH10 board
Date: Mon, 16 Mar 2009 11:06:46 -0400
Message-ID: <49BE6B06.1040909@garzik.org>
References: <200903161406.01411.vl@fidra.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47736 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752586AbZCPPGw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Mar 2009 11:06:52 -0400
In-Reply-To: <200903161406.01411.vl@fidra.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Volker Lanz <vl@fidra.de>
Cc: linux-ide@vger.kernel.org

Volker Lanz wrote:
> ata1: SError: { Proto TrStaTrns UnrecFIS }
> ata1.00: cmd 60/00:00:4a:b6:60/02:00:0c:00:00/40 tag 0 ncq 262144 in
> res 51/84:00:4a:b6:60/4e:00:0c:00:00/40 Emask 0x412 (ATA bus error) <F>
> ata1.00: error: { ICRC ABRT }

Your hardware is telling you that it is seeing CRC errors on the ATA bus 
-- which means to say, a hardware problem that causes data transfer over 
the SATA cable to fail.

Possible sources of problems:  bad SATA cable, bad power supply, bad 
SATA port on device or mainboard, bad mainboard, ...

	Jeff


