From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 1/1] sata_mv: Prevent PIO commands to be defered too long
 if traffic in progress.
Date: Wed, 14 Oct 2009 08:35:15 -0400
Message-ID: <4AD5C583.8060006@rtr.ca>
References: <1255387440-13313-1-git-send-email-gwendal@google.com> <1255387440-13313-2-git-send-email-gwendal@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:37228 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752591AbZJNMfy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Oct 2009 08:35:54 -0400
In-Reply-To: <1255387440-13313-2-git-send-email-gwendal@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>, Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Grant Grundler <grundler@google.com>

Gwendal Grignou wrote:
> Use excl_link when non NCQ commands are defered, to be sure they are processed
> as soon as outstanding commands are completed. It prevents some commands to be
> defered indifinitely when using a port multiplier.
> 
> Signed-off-by: Gwendal Grignou <gwendal@google.com>
..
> Reviewed-by: Grant Grundler <grundler@google.com>
..

Reviewed-by: Mark Lord <mlord@pobox.com>

Looks good to me.  Jeff, please feel free to accept sata_mv patches
directly from Gwendal and/or Grant -- they know the chips as well as I do.

Cheers

Mark
