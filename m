From: Jeff Garzik <jeff@garzik.org>
Subject: Re: PATA driver for ide-pmac?
Date: Wed, 08 Nov 2006 12:55:58 -0500
Message-ID: <45521A2E.1090503@garzik.org>
References: <20061108133735.GI16523@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:29073 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1754619AbWKHR4N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Nov 2006 12:56:13 -0500
In-Reply-To: <20061108133735.GI16523@curie-int.orbis-terrarum.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Robin H. Johnson" <robbat2@orbis-terrarum.net>
Cc: linux-ide@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Robin H. Johnson wrote:
> Just looking around, I don't see one, but maybe I'm not looking in the
> right places.
> 
> Has anybody started on a libata-based replacement for the ide-pmac
> (BLK_DEV_IDEDMA_PMAC) at all?

Not AFAIK.  It's probably pretty low on benh's priority list, since 
there's a working driver now.  But a libata driver is nonetheless 
welcomed :)

	Jeff



