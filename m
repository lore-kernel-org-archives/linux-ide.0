From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Recommended SATA controller?
Date: Sun, 07 Mar 2004 23:24:13 +0000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <404BAF1D.9070103@superbug.demon.co.uk>
References: <opr4idafayq1sf88@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:39688 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S262330AbUCGX0P (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 Mar 2004 18:26:15 -0500
In-Reply-To: <opr4idafayq1sf88@mail.broadpark.no>
List-Id: linux-ide@vger.kernel.org
To: Arve Knudsen <aknuds-1@broadpark.no>
Cc: linux-ide@vger.kernel.org

Arve Knudsen wrote:
> Hi
> 
> As it seems the Silicon Image driver won't be radically improved anytime 
> soon(?), I'm thinking of purchasing a dedicated SATA controller. Can 
> anyone recommend me a fairly cheap 2-port controller that's known to 
> work well with Linux (2.6-series)? Stability is imperative, I just had a 
> solid freeze and I'm afraid it might have to do with disk activity 
> (playing MP3s while compiling). Might Promise (Ultra 150) or Adaptect 
> (1210 SA) be worth considering?
> 
> Thanks
> 
> Arve Knudsen

The SATA controller on the ICH5 chips seems to work fine here. I have an 
ABIT IC7-G motherboard with SATA controller on the ICH5 chip, all built 
into the motherboard.

Cheers
James

