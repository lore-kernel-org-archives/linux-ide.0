From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_sis: Clean up using cable_detect methods
Date: Fri, 09 Mar 2007 07:32:52 -0500
Message-ID: <45F153F4.8010903@pobox.com>
References: <20070307165424.5e770840@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55523 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965796AbXCIMcz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 07:32:55 -0500
In-Reply-To: <20070307165424.5e770840@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> This changeset revolves around the fact that all the SiS controllers have
> the same enable bits, but differing cable detection methods. Previously
> that meant each type had its own error_handler methods. Instead we can
> now implement different ->cable_detect methods and share a single
> error_handler which does the filtering by enable bits.
> 
> In addition we had some auto const arrays that should be static const. I'm
> not sure if gcc already treats them intelligently but adding the static
> will make sure.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied (patch dated mar 07)


