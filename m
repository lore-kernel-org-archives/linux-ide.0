From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: Incorrect timing computation for PIO5/6
Date: Thu, 07 Dec 2006 07:39:05 -0500
Message-ID: <45780B69.4000302@pobox.com>
References: <20061207124118.0feee6d9@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37495 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032140AbWLGMjH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 7 Dec 2006 07:39:07 -0500
In-Reply-To: <20061207124118.0feee6d9@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org

Alan wrote:
> The ata timing computation code makes some mistakes in PIO5/6 because a
> check was not updated correctly when I put this support into the kernel.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied


