From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: dev_config does not need ap and adev passing
Date: Fri, 02 Mar 2007 18:14:26 -0500
Message-ID: <45E8AFD2.3020904@garzik.org>
References: <20070302005615.4f53acb8@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54573 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992720AbXCBXO2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Mar 2007 18:14:28 -0500
In-Reply-To: <20070302005615.4f53acb8@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alan wrote:
> It used to be impossible to get from ata_device to ata_port but that is
> no longer true. Various methods have been cleaned up over time but
> dev_config still takes both and most users don't need both anyway. Tidy
> this one up
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied to #upstream (2.6.22), since its not a bugfix


