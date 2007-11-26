From: Frans Pop <elendil@planet.nl>
Subject: Re: "buggy cmd640" message followed by soft lockup
Date: Mon, 26 Nov 2007 02:32:35 +0100
Message-ID: <200711260232.36820.elendil@planet.nl>
References: <200711222007.12497.elendil@planet.nl> <200711242038.06677.elendil@planet.nl> <200711250013.51279.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hpsmtp-eml17.KPNXCHANGE.COM ([213.75.38.117]:52377 "EHLO
	hpsmtp-eml17.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754290AbXKZBcj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Nov 2007 20:32:39 -0500
In-Reply-To: <200711250013.51279.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

(Dropped Rafael from CC)

On Sunday 25 November 2007, Bartlomiej Zolnierkiewicz wrote:
> So either something went very very wrong or the oops itself is incorrect.
>
> Please put BUG() before the put_cmd640_reg() above so the next time
> BUG happens we will know which one is it.

I've spent quite a bit of time on this issue over the weekend and have seen 
all kinds of "interesting" behavior with various kernels with different 
debug patches, but no definite clues (except confirmation that on "good" 
boots no cmd64x hardware is detected).

At some point I scrapped the virtual machine I had been using and created a 
new one. Since then I've been unable to reproduce the problem. I'm still 
quite confused by the issue exactly because it was so consistent when it 
_did_ happen and am still not sure if it can be blamed completely on the 
quirkiness of Virtualbox.

I'll keep testing new kernels in VirtualBox and will keep alert for the 
issue, but for now I think it's best to forget about it.

Bartlomiej: thanks for your feedback and suggestions.

Cheers,
FJP
