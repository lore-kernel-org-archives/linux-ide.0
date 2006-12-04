From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.6.19-rc6-mm2] sata_sis: support SiS966/966L
Date: Mon, 4 Dec 2006 12:43:06 +0000
Message-ID: <20061204124306.58d0fdf4@localhost.localdomain>
References: <200612040134.42688.uwe.koziolek@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:59077 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S936375AbWLDMhp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Dec 2006 07:37:45 -0500
In-Reply-To: <200612040134.42688.uwe.koziolek@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

On Mon, 4 Dec 2006 01:34:42 +0100
Uwe Koziolek <uwe.koziolek@gmx.net> wrote:

> The SiS966/966L has different PCI-IDs for native mode and AHCI mode.
> The SiS966 supports four SATA ports only in native mode.
> 
> Added additional PCI-ID 0x0183 for SiS965/965L.
> 
> this patch is based on the code from David Wang from SiS Corporation published on SiS Website.
> 
> Signed-off-by: Uwe Koziolek <uwe.koziolek@gmx.net>

Acked-by: Alan Cox <alan@redhat.com>

