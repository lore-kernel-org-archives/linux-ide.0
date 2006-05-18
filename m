From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [Fwd: [RFT] major libata update]
Date: Wed, 17 May 2006 20:04:55 -0700 (PDT)
Message-ID: <20060518030455.62177.qmail@web31814.mail.mud.yahoo.com>
References: <Pine.LNX.4.64.0605171036140.10823@g5.osdl.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605171036140.10823@g5.osdl.org>
Sender: linux-scsi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>, James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jeff Garzik <jeff@garzik.org>, Jens Axboe <axboe@suse.de>, SCSI Mailing List <linux-scsi@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Andrew Morton <akpm@osdl.org>
List-Id: linux-ide@vger.kernel.org

--- Linus Torvalds <torvalds@osdl.org> wrote:
> On Wed, 17 May 2006, James Bottomley wrote:
> > 
> > This is one of the questions.  Currently block has no concept of "host".
> 
> That's good. 
> 
> I don't understand why you'd ever _want_ a concept of "host". The whole 
> concept is broken and unnecessary. At no point should you even need to map 
> from request to host, but if you do, you don't need to introduce any 
> generic "host" notion, you can do it easily per-queue.

You are correct.  The concept of "host" should NOT be exported to
higher than PCI/SCSI* level.

* See below.

> The whole fixation with "host" in the SCSI layer is a bug, I think. What 
> does it matter, really? And when do you actually have a "request_queue" 
> entry without already knowing which controller it is connected to (ie why 
> do you even need that mapping)?

Not quite, the concept of a "host" is needed as it is the "host" which
provides "SCSI ports" to the "SCSI domain".

     Luben

