From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: DMA mapping on SCSI device?
Date: Tue, 29 Jan 2008 14:09:52 -0800 (PST)
Message-ID: <896139.88121.qm@web31812.mail.mud.yahoo.com>
References: <479E6E8C.2090501@shaw.ca>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <479E6E8C.2090501@shaw.ca>
Sender: linux-scsi-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, ide <linux-ide@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org, Robert Hancock <hancockr@shaw.ca>
List-Id: linux-ide@vger.kernel.org

--- On Mon, 1/28/08, Robert Hancock <hancockr@shaw.ca> wrote:
> The trick is that if an ATAPI device is connected, we (as
> far as I'm 
> aware) can't use ADMA mode, so we have to switch that
> port into legacy 
> mode.

Can you double check this with the HW architect of the
HW DMA engine of the ASIC?

> This means it's only capable of 32-bit DMA.
> However the other port 
> on the controller may be connected to a hard drive and
> therefore still 
> capable of 64-bit DMA.

If this is indeed the case as you've presented it here,
it sounds like a HW shortcoming.  I cannot see how the device
type (or protocol) dictate how the DMA engine operates.
They live in two different domains.

> The ideal solution would be to do mapping against a
> different struct 
> device for each port, so that we could maintain the proper
> DMA mask for 
> each of them at all times. However I'm not sure if
> that's possible. The 
> thought of using the SCSI struct device for DMA mapping was
> brought up 
> at one point.. any thoughts on that?

The reason for this is that the object that a struct scsi_dev
represents has nothing to do with HW DMA engines.

It looks like your current solution is correct and
x86_64's blk_queue_bounce_limit needs work.

    Luben

