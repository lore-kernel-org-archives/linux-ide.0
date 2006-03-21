From: Mark Lord <liml@rtr.ca>
Subject: Re: Some sata_mv error messages
Date: Mon, 20 Mar 2006 23:48:25 -0500
Message-ID: <441F8599.7080703@rtr.ca>
References: <20060318044056.350a2931.akpm@osdl.org> <20060320133318.GB32762@favonius> <441F508E.1030008@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:58083 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1030294AbWCUEs0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Mar 2006 23:48:26 -0500
In-Reply-To: <441F508E.1030008@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: sander@humilis.net, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, lkml@rtr.ca

Jeff Garzik wrote:
>
> Without answering your specific question, just remember that sata_mv is 
> considerly "highly experimental" right now, and still needs some 
> workarounds for hardware errata.
> 
> For now, the goal is a system that doesn't crash and doesn't corrupt 
> data.  If its occasionally slow or spits out a few errors, but otherwise 
> still works, that's pretty darned good :)

I'm currently working with the original authors of sata_mv, and have taken
over maintenance of it for now.  It should progress from "highly experimental"
to "production quality" over the next month or so.

The (mucho) updated driver I'm using here now is already much improved
in many ways.  At some point, I'll break it out into patches for Jeff.

But there's one MAJOR bugfix patch that I'll release here shortly,
to go with the interrupt handler fix already posted.

Cheers

Mark
