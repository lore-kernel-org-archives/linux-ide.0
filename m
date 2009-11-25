From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 00/86] PATA fixes
Date: Wed, 25 Nov 2009 18:01:18 +0000
Message-ID: <20091125180118.66053387@lxorguk.ukuu.org.uk>
References: <20091125170218.5446.13513.sendpatchset@localhost>
	<4B0D6735.8000604@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52245 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758837AbZKYR7X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 12:59:23 -0500
In-Reply-To: <4B0D6735.8000604@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Summary would be lots of really good stuff and review.

> hmmmm....  will reserve comment until I review it thoroughly, but I am a 
> bit reluctant to move away from the current struct-driver style driver 
> init/setup model.

I think the model is right - I'd prefer it to be in the driver structs
somewhere but the basic point that init and resume often do the same job
is a very sound one.
