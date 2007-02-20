From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: warn if speed limited due to 40-wire cable (v2)
Date: Tue, 20 Feb 2007 13:11:45 +0000
Message-ID: <20070220131145.18195df1@localhost.localdomain>
References: <45DA44B4.6000209@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49987 "EHLO
	localhost.localdomain" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932570AbXBTMIM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Feb 2007 07:08:12 -0500
In-Reply-To: <45DA44B4.6000209@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>

> cleaned up somewhat. Also, it's been inadvertently tested (it seems that
> pata_amd Nvidia cable detection is broken in current -git..)

Yes. The pata_acpi driver fixes that one, but got kicked out as it didn't
match other merges at the same time. It'll be back soon

> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>

Acked-by: Alan Cox <alan@redhat.com>
