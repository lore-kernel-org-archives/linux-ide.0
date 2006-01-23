From: Jamie Heilman <jamie@audible.transient.net>
Subject: Re: memory leak in scsi_cmd_cache 2.6.15
Date: Sun, 22 Jan 2006 16:58:56 -0800
Message-ID: <20060123005856.GB15490@fifty-fifty.audible.transient.net>
References: <Pine.LNX.4.62.0601212105590.22868@pureeloreel.qftzy.pbz> <1137917798.3328.2.camel@laptopd505.fenrus.org> <1137918044.3328.6.camel@laptopd505.fenrus.org> <Pine.LNX.4.62.0601221251340.30208@pureeloreel.qftzy.pbz> <1137956841.3328.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from audible.transient.net ([216.254.12.79]:36064 "HELO
	audible.transient.net") by vger.kernel.org with SMTP
	id S932411AbWAWA66 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Jan 2006 19:58:58 -0500
Content-Disposition: inline
In-Reply-To: <1137956841.3328.36.camel@laptopd505.fenrus.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ariel <askernel2615@dsgml.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Sun, 2006-01-22 at 13:51 -0500, Ariel wrote:
> > On Sun, 22 Jan 2006, Arjan van de Ven wrote:
> > 
> > > On Sun, 2006-01-22 at 09:16 +0100, Arjan van de Ven wrote:
> > >> On Sat, 2006-01-21 at 21:13 -0500, Ariel wrote:
> > >>> I have a memory leak in scsi_cmd_cache.
> > 
> > >> does this happen without the binary nvidia driver too? (it appears
> > >> you're using that). That's a good datapoint to have if so...
> > 
> > I had the exact same nvidia driver with 2.6.12 (just recompiled) and it 
> > didn't happen there.
> > 
> > But just in case I used slabtop to watch scsi_cmd_cache grow by 1.24KB per 
> > second (104MB per day), then I rmmoded nvidia and watched it grow by 
> > 1.16KB per 
> 
> please repeat this without nvidia ever being loaded. Just having a
> module loaded before can already cause corruption that ripples through
> later, so just unloading is not enough to get a clean result.

Hrmph, yeah one of my workstations is exhibiting this too.  I use
the nvidia module, but I did clean reboot without it loaded and the
leak was still there.  So I'll add my data points at
http://audible.transient.net/~jamie/k/ ... all the files starting with
"scsi_cmd_cache."

-- 
Jamie Heilman                     http://audible.transient.net/~jamie/
