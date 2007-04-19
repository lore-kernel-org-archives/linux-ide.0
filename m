From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_sis: Fix oops on boot
Date: Thu, 19 Apr 2007 19:22:13 -0400
Message-ID: <4627F9A5.1050301@pobox.com>
References: <20070419110952.13470b08@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33338 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753931AbXDSXWQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Apr 2007 19:22:16 -0400
In-Reply-To: <20070419110952.13470b08@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org

Alan Cox wrote:
> A small number of SiS setups require special handling (not many judging
> by how long this dumb bug survived). A couple of Fedora 7 devel testers
> hit an Oops on pata_sis loading which is caused by terminal confusion
> between chipset as 'the chipset we have found' and chipset as 'array
> iterator'
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied


