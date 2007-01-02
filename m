From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH] atiixp: Old drivers/ide layer driver for the ATIIXP hang fix
Date: Tue, 2 Jan 2007 21:19:10 +0100
Message-ID: <58cb370e0701021219l162406cax8116402e55feeac5@mail.gmail.com>
References: <20070102155752.78f6a01e@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:55414 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754947AbXABUTL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Jan 2007 15:19:11 -0500
Received: by ug-out-1314.google.com with SMTP id 44so4994273uga
        for <linux-ide@vger.kernel.org>; Tue, 02 Jan 2007 12:19:10 -0800 (PST)
In-Reply-To: <20070102155752.78f6a01e@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, akpm@osdl.org

On 1/2/07, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> When the old IDE layer calls into methods in the driver during error
> handling it is essentially random whether ide_lock is already held. This
> causes a deadlock in the atiixp driver which also uses ide_lock internally
> for locking.
>
> Switch to a private lock instead.
>
> Signed-off-by: Alan Cox <alan@redhat.com>

Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
