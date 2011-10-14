From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/3] pata_sil680: minor CodingStyle fixups
Date: Fri, 14 Oct 2011 12:45:44 -0400
Message-ID: <4E986738.9050504@pobox.com>
References: <201110112021.51236.bzolnier@gmail.com> <4E957080.6020102@mvista.com> <20111012120305.0b5f8f06@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:49523 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755138Ab1JNQpr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Oct 2011 12:45:47 -0400
In-Reply-To: <20111012120305.0b5f8f06@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/12/2011 07:03 AM, Alan Cox wrote:
>
>>
>>> +	/* This last case is _NOT_ ok */
>>> +	case 0x30:
>>> +		printk(KERN_ERR "sil680: Clock disabled ?\n");
>>
>>      pr_err()? Or checkpatch.pl doesn't complain about it (I forgot)?
>
> dev_ would be even better but that seems to be a separate thing. The
> existing patch is still a move in the right direction.

agreed x 2

To be specific, it should be

	dev_err(&pdev->dev

