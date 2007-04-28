From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ata_timing: ensure t->cycle is always correct
Date: Sat, 28 Apr 2007 14:51:43 -0400
Message-ID: <463397BF.9010406@garzik.org>
References: <20070423115536.38a7e43c@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53421 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753785AbXD1Svq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Apr 2007 14:51:46 -0400
In-Reply-To: <20070423115536.38a7e43c@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org

Alan Cox wrote:
> Russell King hit a case where quantisation errors accumulated such that
> the cycle time was shorter than rather than equal to the active/recovery
> time. The code already knows how to stretch times to fit the cycle time
> but does not know about the reverse. 
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied


