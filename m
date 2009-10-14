From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/1] sata_mv: Prevent PIO commands to be defered too long
 if traffic in progress.
Date: Wed, 14 Oct 2009 08:38:11 -0400
Message-ID: <4AD5C633.7050003@pobox.com>
References: <> <1255387440-13313-1-git-send-email-gwendal@google.com> <1255387440-13313-2-git-send-email-gwendal@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [207.36.208.214] ([207.36.208.214]:41084 "EHLO mail.dvmed.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1760081AbZJNMiv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Oct 2009 08:38:51 -0400
In-Reply-To: <1255387440-13313-2-git-send-email-gwendal@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: mlord@pobox.com, linux-ide@vger.kernel.org

On 10/12/2009 06:44 PM, Gwendal Grignou wrote:
> Use excl_link when non NCQ commands are defered, to be sure they are processed
> as soon as outstanding commands are completed. It prevents some commands to be
> defered indifinitely when using a port multiplier.
>
> Signed-off-by: Gwendal Grignou<gwendal@google.com>
> ---
>   drivers/ata/sata_mv.c |   29 +++++++++++++++++++++++++++--
>   1 files changed, 27 insertions(+), 2 deletions(-)

An ACK from Mark, too, I hope?

I'll give this a try on a Gen-IIE chip...

	Jeff




