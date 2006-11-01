From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Fun with HPT302N (Rocket Raid 1520 PCI card)
Date: Wed, 01 Nov 2006 12:17:23 +0000
Message-ID: <1162383443.11965.109.camel@localhost.localdomain>
References: <23724.1161684269@redhat.com>  <454869C8.9000103@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50666 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1946841AbWKAMNn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Nov 2006 07:13:43 -0500
In-Reply-To: <454869C8.9000103@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: David Howells <dhowells@redhat.com>, linux-ide@vger.kernel.org

Ar Mer, 2006-11-01 am 04:32 -0500, ysgrifennodd Jeff Garzik:
> I think the newer HPTs present a pata_hpt*.c compatible interface, even 
> though the card is driving SATA devices.

Some of the cards using HPT3xx chips for SATA are PATA chips with
bridges so it may well be such a card. I really need to know what
happens if you plug a drive in.

