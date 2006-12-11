From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.19-rc6-mm2] sata_sis: support SiS966/966L
Date: Mon, 11 Dec 2006 10:49:31 -0500
Message-ID: <457D7E0B.2070802@garzik.org>
References: <200612040134.42688.uwe.koziolek@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46971 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936710AbWLKPtd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Dec 2006 10:49:33 -0500
In-Reply-To: <200612040134.42688.uwe.koziolek@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: linux-ide@vger.kernel.org

Uwe Koziolek wrote:
> The SiS966/966L has different PCI-IDs for native mode and AHCI mode.
> The SiS966 supports four SATA ports only in native mode.
> 
> Added additional PCI-ID 0x0183 for SiS965/965L.
> 
> this patch is based on the code from David Wang from SiS Corporation published on SiS Website.
> 
> Signed-off-by: Uwe Koziolek <uwe.koziolek@gmx.net>

applied


