From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_marvell: fix cable detection
Date: Fri, 17 Nov 2006 23:40:26 +0000
Message-ID: <20061117234026.680d9769@localhost.localdomain>
References: <m3fycidk6h.fsf@anduin.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46290 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1756035AbWKQXey (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Nov 2006 18:34:54 -0500
In-Reply-To: <m3fycidk6h.fsf@anduin.mandriva.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnaud Patard <apatard@mandriva.com>
Cc: linux-ide@vger.kernel.org, alan@redhat.com

On Fri, 17 Nov 2006 19:04:06 +0100
Arnaud Patard <apatard@mandriva.com> wrote:

> 
> A "break;" is missing in the cable detection switch() statement, leading
> to a wrong detection of the cable type.
> 
> Signed-off-by: Arnaud Patard <apatard@mandriva.com>

Acked-by: Alan Cox <alan@redhat.com>
