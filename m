From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 7/9] icside: use hwif->dev
Date: Fri, 28 Dec 2007 16:24:33 +0300
Message-ID: <4774F911.9080503@ru.mvista.com>
References: <20071227191153.1357.63211.sendpatchset@localhost.localdomain> <20071227191245.1357.38374.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754404AbXL1NYU@vger.kernel.org>
In-Reply-To: <20071227191245.1357.38374.sendpatchset@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Setup hwif->dev in icside_setup().

> * Use hwif->dev instead of state->dev in icside_build_sglist(),
>   icside_dma_end(), icside_dma_start() and icside_dma_setup().

> * Remove no longer needed 'dev' field from struct icside_state.

> Cc: Russell King <rmk@arm.linux.org.uk>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

PS: Russel, that was only an eyes check, the last word is yours. :-)
