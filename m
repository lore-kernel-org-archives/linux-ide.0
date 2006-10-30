From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.19-rc3-git7: scsi_device_unbusy: inconsistent lock state
Date: Mon, 30 Oct 2006 15:57:19 +0100
Message-ID: <1162220239.2948.27.camel@laptopd505.fenrus.org>
References: <45460D52.3000404@rtr.ca>  <20061030144315.GG4563@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030368AbWJ3O50@vger.kernel.org>
In-Reply-To: <20061030144315.GG4563@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, mingo@elte.hu
List-Id: linux-ide@vger.kernel.org


> which has always been considered safe, while not very pretty.


actually it's different I think (based on a brief inspection of the
code, I could well be wrong): 
get_request_wait() causes a get_request() call with a GFP_NOIO gfp_mask
which perculates upto cfq_set_request() as argument.
cfq_set_request() then calls the inline cfq_get_queue() (which isn't in
the backtrace due to inlining) which does
                } else if (gfp_mask & __GFP_WAIT) {
                        /* 
                         * Inform the allocator of the fact that we will
                         * just repeat this allocation if it fails, to allow
                         * the allocator to do whatever it needs to attempt to
                         * free memory.
                         */
                        spin_unlock_irq(cfqd->queue->queue_lock);

which enables interrupts right smack in the middle of holding a whole
bunch of locks.....

so to me it looks like lockdep at least has the appearance of moaning
about a reasonably fishy situation...



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org
