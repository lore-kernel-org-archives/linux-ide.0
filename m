From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [git patches] IDE update
Date: Fri, 8 Jul 2005 12:20:56 +0200
Message-ID: <20050708102056.GA7172@elte.hu>
References: <1120567900.12942.8.camel@linux> <42CA84DB.2050506@rainbow-software.org> <1120569095.12942.11.camel@linux> <42CAAC7D.2050604@rainbow-software.org> <20050705142122.GY1444@suse.de> <6m8mc1lhug5d345uqikru1vpsqi6hciv41@4ax.com> <Pine.LNX.4.58.0507051748540.3570@g5.osdl.org> <nljmc1h40t2bv316ufij10o2am5607hpse@4ax.com> <Pine.LNX.4.58.0507052209180.3570@g5.osdl.org> <20050708084817.GB7050@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.elte.hu ([157.181.1.137]:58789 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262449AbVGHKVc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jul 2005 06:21:32 -0400
Content-Disposition: inline
In-Reply-To: <20050708084817.GB7050@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Grant Coady <grant_lkml@dodo.com.au>, Ondrej Zary <linux@rainbow-software.org>, =?iso-8859-1?Q?Andr=E9?= Tomt <andre@tomt.net>, Al Boldi <a1426z@gawab.com>, 'Bartlomiej Zolnierkiewicz' <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


* Jens Axboe <axboe@suse.de> wrote:

> But! I used hdparm -t solely, 2.6 was always ~5% faster than 2.4. But 
> using -Tt slowed down the hd speed by about 30%. So it looks like some 
> scheduler interaction, perhaps the memory timing loops gets it marked 
> as batch or something?

to check whether that could be the case, could you try:

	nice -n -20 hdparm -t /dev/hdc

does that produce different results?

	Ingo
