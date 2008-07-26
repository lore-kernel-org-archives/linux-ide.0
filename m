From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/5] Introduce ata_id_has_unload()
Date: Sat, 26 Jul 2008 17:01:36 +0100
Message-ID: <20080726170136.144f51b0@lxorguk.ukuu.org.uk>
References: <87prp1kvyy.fsf@denkblock.local>
	<20080726062142.29070.87751.stgit@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44550 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754588AbYGZQTg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Jul 2008 12:19:36 -0400
In-Reply-To: <20080726062142.29070.87751.stgit@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Jeff Garzik <jeff@garzik.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Pavel Machek <pavel@ucw.cz>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 26 Jul 2008 08:24:35 +0200
Elias Oltmanns <eo@nebensachen.de> wrote:

> Add a function to check an ATA device's id for head unload support as
> specified in ATA-7.

If a feature is new in ATA 7 you should also check the ATA version is >=7
in the tests. Just in case some prehistoric device has it down for a
different purpose.

Alan
