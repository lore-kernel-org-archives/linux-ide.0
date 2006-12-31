From: Mark Lord <liml@rtr.ca>
Subject: Re: bug: AHCI: Serial ATA to CompactFlash adapter loops endlessly
Date: Sun, 31 Dec 2006 12:47:15 -0500
Message-ID: <4597F7A3.1070207@rtr.ca>
References: <20061117211135.GO7299@kvack.org> <45842390.1000102@pobox.com> <20061220021309.GY1104@kvack.org> <4596984F.4020604@rtr.ca> <20061230174844.GY18867@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1765 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030372AbWLaRrR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 31 Dec 2006 12:47:17 -0500
In-Reply-To: <20061230174844.GY18867@kvack.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Benjamin LaHaise wrote:
>
> The other problem I'm finding is that this new motherboard doesn't want to 
> use AHCI, regardless of the settings of the BIOS.  The old IDE drivers will 
> only work in PIO mode on this chipset (an ICH7, I think), making it difficult 
> to compare things.

The libata "ata_piix" driver should work with that chipset,
as an alternative to the drivers/ide stuff.
