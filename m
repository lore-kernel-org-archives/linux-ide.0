From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata reset-seq merge broke sata_sil on sh
Date: Thu, 10 May 2007 13:53:48 +0200
Message-ID: <464307CC.40701@gmail.com>
References: <20070510072005.GA27316@linux-sh.org> <464301D3.5060306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761037AbXEJLyT@vger.kernel.org>
In-Reply-To: <464301D3.5060306@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>, jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Some more thoughts.

Tejun Heo wrote:
> Hello,
> 
> Paul Mundt wrote:
> [--snip, thanks a lot for the detailed report--]
>> However, if I go back before any of the reset changes were introduced,
>> things were working fine, and there were no problems with waiting for
>> the reset. Ideas?
> 
> Hmm... It worked so well on all my sil's.  I'm a bit puzzled because we
> also failed the same condition before the change too.  The only change
> is we're less patient with the initial tries but in the end we give more
> than enough time to the device to prepare itself.
> 
> * Does your drive start spun down when it boots?  Can you post dmesg
> with printk timestamp turned on with kernel prior to reset-seq merge?
> 
> * In ata_bus_softreset() and sata_std_hardreset(), there's msleep(150)
> delay before checking the status post-reset.  Does increasing the delay
> make any difference?  Please try to increase it exponentially till it
> reaches 10sec.

* According to the report, things still work till 27c78b37 - commit for
the actual merge and there's no related change till the current master
from there.  So, which commit actually breaks detection?  Or is
detection just flaky after b8cffc6a?

* How does things work on 9b89391c?

Also, please turn on printk timestamp on all reports so that we can now
the timeline of things.

Thanks.

-- 
tejun
