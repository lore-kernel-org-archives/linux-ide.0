From: "Tvrtko A. =?iso-8859-2?q?Ur=B9ulin?=" <tvrtko@croadria.com>
Subject: Re: [PATCH,RFT] VIA SATA driver update
Date: Mon, 22 Mar 2004 10:21:01 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200403221021.01679.tvrtko@croadria.com>
References: <405828DB.7060005@pobox.com> <200403171236.21145.tvrtko@croadria.com> <405B21FE.4010609@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shark.pro-futura.com ([161.58.178.219]:58530 "EHLO
	shark.pro-futura.com") by vger.kernel.org with ESMTP
	id S261815AbUCVJPz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Mar 2004 04:15:55 -0500
In-Reply-To: <405B21FE.4010609@pobox.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

On Friday 19 March 2004 17:38, Jeff Garzik wrote:
> > This is the same behavior I get ever since 2.6.1 when I started testing
> > 2.6 seried. It also doesn't work under 2.6 with IDE generic support for
> > VIA8237SATA (irq timeout, dma timeout)
>
> Ok...
>
> Does enabling SMP (CONFIG_SMP) fix things for you?
> (Note, this should work fine even on a uniprocessor machine)

Nope. :(

Regards,
Tvrtko
