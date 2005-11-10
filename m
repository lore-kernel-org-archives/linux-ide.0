From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Serious IDE problem still present in 2.6.14
Date: Thu, 10 Nov 2005 14:34:35 +0100
Message-ID: <58cb370e0511100534tead9e71u189666789b3f4da1@mail.gmail.com>
References: <Pine.LNX.4.44.0510301030120.26176-100000@coffee.psychology.mcmaster.ca>
	 <1130689871.6348.3.camel@montroll.chem.mcgill.ca>
	 <4365511C.7040903@yahoo.de>
	 <1130713716.6348.7.camel@montroll.chem.mcgill.ca>
	 <4365596F.4060105@yahoo.de>
	 <1130785344.5932.6.camel@montroll.chem.mcgill.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.201]:35253 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750714AbVKJNeg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Nov 2005 08:34:36 -0500
Received: by nproxy.gmail.com with SMTP id x29so108064nfb
        for <linux-ide@vger.kernel.org>; Thu, 10 Nov 2005 05:34:35 -0800 (PST)
In-Reply-To: <1130785344.5932.6.camel@montroll.chem.mcgill.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David.Ronis@mcgill.ca
Cc: Stefan <gentoopower@yahoo.de>, Mark Hahn <hahn@physics.mcmaster.ca>, linux-ide@vger.kernel.org

I would suggest doing binary search on -rc and snapshot releases.

http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.14-rc*
http://kernel.org/pub/linux/kernel/v2.6/snapshots/old/patch-2.6.14-*

Otherwise we can only guess what is wrong.

Moreover it doesn't look like an IDE problem the real performance
regression is in cached reads not the buffered ones.

On 10/31/05, David Ronis <ronis@ronispc.chem.mcgill.ca> wrote:
> Hi Stefan,
>
> I tried removing the modules you suggested and reran hdparm -tT /dev/hda
> after each.  No difference.  I also played a bit more by going to
> single-user mode and killing off various things (like udevd).   I turned
> off networking and removed the ethernet driver--still no change.  What
> seemed to make a difference was to turn of the firewall and remove all
> the ipt_ drivers, although the performance was still about 4 times less
> than what I get with the 2.6.13.6 kernel.
