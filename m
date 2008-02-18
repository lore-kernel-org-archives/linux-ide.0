From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH ht6560b] Force prefetch for some devices
Date: Mon, 18 Feb 2008 14:36:36 +0000
Message-ID: <20080218143636.3394eece@core>
References: <47B97EFA.2040805@caiway.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47446 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750893AbYBROpH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Feb 2008 09:45:07 -0500
In-Reply-To: <47B97EFA.2040805@caiway.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Evert van Grootheest <j.e.van.grootheest@caiway.nl>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

On Mon, 18 Feb 2008 13:50:02 +0100
Jan Evert van Grootheest <j.e.van.grootheest@caiway.nl> wrote:

> Prefetch needs to be set for some ide devices to work when connected to
> a ht6560b interface. This was not always done properly, causing a system
> with a HD and CD on the primary interface to not work properly. Or, in
> effect, hang hard.
> 
> This patch forces prefetch on devices before checking whether it
> is necessary to change the settings in the interface

Interesting, that is backwards to the docs and not something I've seen.
If you are correct then pata_legacy also wants tweaking .

Alan
