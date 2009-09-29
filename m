From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] trivial fix of a very frequent spelling mistake
Date: Mon, 28 Sep 2009 22:01:20 -0400
Message-ID: <4AC16A70.2020300@pobox.com>
References: <20090929015607.GA18220@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53919 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753931AbZI2CB1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Sep 2009 22:01:27 -0400
In-Reply-To: <20090929015607.GA18220@bombadil.infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dirk Hohndel <hohndel@infradead.org>
Cc: Jin Kosina <trivial@kernel.org>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 09/28/2009 09:56 PM, Dirk Hohndel wrote:
> something-bility is spelled as something-blity
> so a grep for 'blit' would find these lines
>
> I broke this one out from the rest as it actually changes
> the output of a kernel message - so it could in theory
> change the behavior of tools that parse that ouput
>
> Jeff, can you sign-off / NAK this, please?
>
> Signed-off-by: Dirk Hohndel<hohndel@infradead.org>
> ---
>   drivers/ata/pata_ali.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)

Yep, will send in the upcoming bug fix push...


