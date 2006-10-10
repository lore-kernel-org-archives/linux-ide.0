From: "Allen Martin" <AMartin@nvidia.com>
Subject: RE: [RFC PATCH] nForce4 ADMA with NCQ: It's aliiiive..
Date: Mon, 9 Oct 2006 23:52:34 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B018E8171B@hqemmail02.nvidia.com>
References: <4527C7AB.9080801@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965045AbWJJGwg@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <4527C7AB.9080801@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, prakash@punnoor.de
List-Id: linux-ide@vger.kernel.org

> > -Jeff will probably cringe at how I implemented the 
> > bmdma_stop/start/status/setup functions. This kludge of toggling 
> > ATA_FLAG_MMIO off for the call into libata was needed since this 
> > controller is almost what libata calls ATA_FLAG_MMIO, but not quite 
> > (the ATA taskfile registers are MMIO but the BMDMA 
> registers are PIO). 
> > This is also why I needed the patch to libata-sff.c to use the 
> > adapter's bmdma_status function rather than hardcoded 
> ata_bmdma_status.
> 
> *shrug*  I don't cringe if that's the most expedient way to 
> do something.
> 
> But I really don't think that is necessary.  I will take a 
> look at docs and see how things match up, when I am much more 
> awake.  Most likely you need to be using another set of 
> registers, and be all MMIO, all the time.

You shouldn't be touching BM registers when ADMA is enabled, it can
cause bad things to happen.

You should be using BM registers when doing ATAPI protocol though, as it
doesn't work through ADMA.  So I wouldn't say you should be using MMIO
all the time.

-Allen
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
