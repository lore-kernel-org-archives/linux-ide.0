From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Correct abuse of language
Date: Sat, 09 Jun 2007 22:44:02 -0400
Message-ID: <466B6572.5090209@garzik.org>
References: <20070607161355.3d3bc35c@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35892 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755507AbXFJCoF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 9 Jun 2007 22:44:05 -0400
In-Reply-To: <20070607161355.3d3bc35c@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> The controller is not reporting an unlawful type, it is reporting an
> invalid type. Illegal specifically means "prohibited by law" [1]
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> [1] Microsoft BSOD excepted - and that has another mistake too - it says
> "your software" meaning "our software" according to their licence.

applied to #upstream-fixes, sans Microsoft comment


