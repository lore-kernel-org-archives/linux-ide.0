From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata-sff: PCI IRQ handling fix
Date: Thu, 10 Jan 2008 16:54:30 -0500
Message-ID: <47869416.4080502@garzik.org>
References: <20080103172228.0e091daf@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33681 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757702AbYAJVyg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Jan 2008 16:54:36 -0500
In-Reply-To: <20080103172228.0e091daf@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> It is legitimate (although annoying and silly) for a PCI IDE controller
> not to be assigned an interrupt and to be polled. The libata-sff code
> should therefore not try and request IRQ 0 in this case.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied #upstream-fixes (2.6.24)


