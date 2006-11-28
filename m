From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_it821x: Suspend/Resume support
Date: Tue, 28 Nov 2006 03:34:22 -0500
Message-ID: <456BF48E.6040709@pobox.com>
References: <20061127161436.51e1a8de@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50049 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S935675AbWK1IeY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 03:34:24 -0500
In-Reply-To: <20061127161436.51e1a8de@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan wrote:
> If you are using the noraid option then after a suspend/resume sequence
> we need to reset the card back out of raid mode again.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied this, and similar patches:

serverworks
via
amd
hpt36x
hpt3x3
pata : more drivers...

and also

pata_marvell: merge Mandriva patches


