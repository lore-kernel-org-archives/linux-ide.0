From: Daniel Drake <dsd@gentoo.org>
Subject: Re: Driver for sata adapter promise sata300 tx4
Date: Mon, 01 Aug 2005 17:16:31 +0100
Message-ID: <42EE4ADF.4080502@gentoo.org>
References: <42EDE918.9040807@gmx.net> <42EE3501.7010107@gentoo.org> <42EE3FB8.10008@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262257AbVHAQTU@vger.kernel.org>
In-Reply-To: <42EE3FB8.10008@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Otto Meier <gf435@gmx.net>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Otto Meier wrote:
> My question is also are these features (NCQ/TCQ) and the heigher 
> datarate be supported by this
> modification? or is only the basic feature set of sata 150 TX4 supported?

NCQ support is under development. Search the archives for Jens Axboe's recent 
patches to support this. I don't know about TCQ.

> Here is the patch:
> 
> --- linux/drivers/scsi/sata_promise.c.orig 2005-08-01 17:09:48.474824778 
> +0200
> +++ linux/drivers/scsi/sata_promise.c 2005-07-31 12:57:06.415979512 +0200

Your patch will not apply because it is linewrapped. You also need to submit 
it in a mail of its own to the relevent lists and maintainer, with your 
sign-off  (see Documentation/SubmittingPatches)

> I just saw the patches of  Luke Kosewski regarding the SATA150 TX4 
> antipating
> them it might be right to modify the patch to
> 
> + { PCI_VENDOR_ID_PROMISE, 0x3d17, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> + board_40518 },

It won't compile like this because board_40518 is not a valid identifier. I 
also think it doesn't really matter as it looks like these identifier codes 
have lost their numerical meanings, and now just signify:

board_2037x - 2 port SATA, maybe with an extra PATA port
board_20319 - 4 port SATA
board_20619 - 4 port PATA

Daniel
