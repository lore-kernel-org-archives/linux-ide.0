From: Andi Kleen <andi@firstfloor.org>
Subject: Re: 2.6.34 PDC20268 PATA IO error loop makes system unusable
Date: Mon, 14 Jun 2010 11:22:42 +0200
Message-ID: <20100614092242.GE17092@basil.fritz.box>
References: <20100613154808.GA10408@basil.fritz.box> <4C15DDA0.3020409@kernel.org> <20100614075350.GC17092@basil.fritz.box> <4C15E16B.5000702@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-scsi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4C15E16B.5000702@kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> > So basically it was a "reset button only" situation.
> > 
> > When the device is gone what's the point in giving a message 
> > more than once? Can't the requests just be silently failed in this
> > case?
> 
> Yeah, it would be better to somehow summarize those error message
> instead of spitting out all of them.

Hmm I think I have some ideas on that, I'll take a look.
-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
