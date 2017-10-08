From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: Marvell 88SE9480 Port Multiplier Support
Date: Sun, 08 Oct 2017 09:45:44 -0700
Message-ID: <1507481144.3150.4.camel@HansenPartnership.com>
References: <c93b6306-2e82-8a63-e909-f82641b0215b@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:52538 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751626AbdJHQpq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 8 Oct 2017 12:45:46 -0400
In-Reply-To: <c93b6306-2e82-8a63-e909-f82641b0215b@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Ryder <tireman@shaw.ca>, linux-ide@vger.kernel.org

On Sun, 2017-10-08 at 00:12 -0400, Andrew Ryder wrote:
> Hello,
> 
> Does the mvsas support port multiplier for the marvell 88SE9480 chip?

Not at the present time.  The code to handle SATA port multipliers is
stubbed out in libsas/sas_ata.c

The reason is fairly simple: usually if you're connecting drives via a
SAS host adapter, you want to use SAS expanders because they're way
more featureful and performant than SATA port multipliers, so there's
not much customer pull for support.

> I purchased an Addonics http://addonics.com/products/ad2ms6gpx8-e.php
> but the card fails to see any of the attached drives.
> 
> I found an old message saying it might support sata pmp?
> https://lkml.org/lkml/2014/4/24/413

This patch set was never merged.  There were significant problems with
the EH portion, which Dan Williams reviewed and sent a load of feedback
for but no future patch set incorporating the modifications was ever
forthcoming.

James


> I've attached a dmesg output also and I'm running kernel 4.9.36 if
> that
> helps.
> 
> Andrew

