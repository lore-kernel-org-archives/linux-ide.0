From: Jeff Garzik <jeff@garzik.org>
Subject: Re: nvidia 2200/2050
Date: Sun, 05 Mar 2006 10:52:35 -0500
Message-ID: <440B0943.1000705@garzik.org>
References: <5d96567b0603050334l38b38e3bo34325b49297a839f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:6611 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932104AbWCEPwi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 10:52:38 -0500
In-Reply-To: <5d96567b0603050334l38b38e3bo34325b49297a839f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Raz Ben-Jehuda(caro) wrote:
> hello.
> i have read the update from "http://linux-ata.org/sata-status.html".
> 
> So, just be sure !
> Am i correct to assume that currently nvidia driver ( sata_nv.c )
>    does not support NCQ ?

Correct.

More to the point, though, nothing in the upstream kernel supports NCQ.

Yet.

	Jeff



