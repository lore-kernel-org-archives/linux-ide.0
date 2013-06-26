From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: SATA hdd refuses to reallocate a sector?
Date: Tue, 25 Jun 2013 20:04:22 -0700
Message-ID: <1372215862.2806.54.camel@dabdike>
References: <20130623101940.GA4448@amd.pavel.ucw.cz>
	 <51C76858.4060906@pobox.com> <20130623215100.GA7414@amd.pavel.ucw.cz>
	 <201306240914.29502.linux@rainbow-software.org>
	 <51C83907.2020202@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38723 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751408Ab3FZDE0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Jun 2013 23:04:26 -0400
In-Reply-To: <51C83907.2020202@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Ondrej Zary <linux@rainbow-software.org>, Pavel Machek <pavel@ucw.cz>, Marcus Overhagen <marcus.overhagen@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, tj@kernel.org

On Mon, 2013-06-24 at 08:18 -0400, Mark Lord wrote:
> And the SCSI stack in Linux has rather atrocious error handling.
> It lumps multiple requests together, and can fail the entire lot even
> if only a single sector is bad.

That's rather misleading.  SCSI doesn't lump anything together; it
handles the requests it was passed.  For reads and writes through the
page cache, block will aggregate in the elevators, but you avoid that by
not using the page cache (O_DIRECT or SG_IO).

For devices which report failing sectors correctly data up to the failed
sector is returned and the request is shortened and retried from the
failed sector on.  If we get a second failure at the beginning (where
the previous bad sector was), then we give up.

James


