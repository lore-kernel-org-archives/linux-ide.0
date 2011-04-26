From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_mv port lockup on hotplug (kernel 2.6.38.2)
Date: Tue, 26 Apr 2011 17:52:29 +0200
Message-ID: <20110426155229.GM878@htj.dyndns.org>
References: <4D9FACC9.7020200@teksavvy.com>
 <C1438B59050E1B4C9482FF3266AD6BA32C772D9EB1@gretna.indigovision.com>
 <4DA45CA7.9040102@teksavvy.com>
 <4DA467FB.6020905@teksavvy.com>
 <20110423005610.GC1576@mtj.dyndns.org>
 <C1438B59050E1B4C9482FF3266AD6BA32C775549E4@gretna.indigovision.com>
 <20110425162242.GB30828@mtj.dyndns.org>
 <C1438B59050E1B4C9482FF3266AD6BA32C77554BDC@gretna.indigovision.com>
 <20110426135027.GI878@htj.dyndns.org>
 <C1438B59050E1B4C9482FF3266AD6BA32C77554C70@gretna.indigovision.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <C1438B59050E1B4C9482FF3266AD6BA32C77554C70@gretna.indigovision.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bruce Stenning <b.stenning@indigovision.com>
Cc: Mark Lord <kernel@teksavvy.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hello,

On Tue, Apr 26, 2011 at 04:41:25PM +0100, Bruce Stenning wrote:
> Tejun wrote:
> > Does the following patch resolve the problem?
> 
> I have applied that patch, keeping Mark's mv_set_main_irq_mask spinlock patch
> in place.  I would not like to commit absolutely, for obvious reasons, but I
> have abused the port considerably and have not been able to coax it into
> locking up.

Yeah, it makes sense.  Hmm... it seems I wasn't thinking straight when
I added that work around.  Not sure how to fix it properly at this
moment.  I'll think about it.  Can you please keep me posted if you
find something while testing?

Thanks.

-- 
tejun
