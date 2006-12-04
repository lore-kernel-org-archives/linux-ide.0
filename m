From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata: Add support for the MPC52xx ATA controller using
 libata
Date: Mon, 4 Dec 2006 12:18:15 +0000
Message-ID: <20061204121815.022a2cdd@localhost.localdomain>
References: <4573D90E.3050806@246tNt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:9397 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S936178AbWLDMRM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Dec 2006 07:17:12 -0500
In-Reply-To: <4573D90E.3050806@246tNt.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sylvain Munaut <tnt@246tNt.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

On Mon, 04 Dec 2006 09:15:10 +0100
Sylvain Munaut <tnt@246tNt.com> wrote:

> This patch adds libata support for the Freescale MPC5200 IDE
> controller.
nit timings to PIO0 */
urce(op->node, 0, &res_mem);
>

Acked-by: Alan Cox <alan@redhat.com>
