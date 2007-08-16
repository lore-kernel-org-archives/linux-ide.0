From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/4] libata: ACPI checks for 80wire cable
Date: Thu, 16 Aug 2007 02:34:33 -0400
Message-ID: <46C3EFF9.9080508@garzik.org>
References: <20070726183647.1ee7f2d4@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55192 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758690AbXHPGeh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Aug 2007 02:34:37 -0400
In-Reply-To: <20070726183647.1ee7f2d4@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> We can use the ACPI mode information with several drivers as a hint to
> cable type. If the ACPI mode set by the BIOS is faster than UDMA33 then
> we know the BIOS thinks there are 80wire cables. If it doesn't set such a
> mode or it has no ACPI method then we get no further information and can
> rely on existing approaches
> 
> Introduce the function headers needed. Null it out for non ACPI boxes
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied 1-2, after combining into a single changeset.

When adding a new API, IMO it's better to keep definition and 
implementation additions in a single changeset.


