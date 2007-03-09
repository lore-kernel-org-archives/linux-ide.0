From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_it821x: Clean up by using cable methods
Date: Fri, 09 Mar 2007 07:25:25 -0500
Message-ID: <45F15235.6080709@pobox.com>
References: <20070307161836.68c60eb0@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55395 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422628AbXCIMZ1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 07:25:27 -0500
In-Reply-To: <20070307161836.68c60eb0@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> Signed-off-by: Alan Cox <alan@redhat.com>

applied, as part of a jumbo ->cable_detect patch, since this patch 
contained changes highly similar to others it was applied alongside.


