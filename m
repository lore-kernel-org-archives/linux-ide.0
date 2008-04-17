From: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH 1/2] libata: implement ATA_IOC_GET_IO32/ATA_IOC_SET_IO32 ioctls
Date: Thu, 17 Apr 2008 21:46:51 +0200
Message-ID: <20080417194651.GA5783@1wt.eu>
References: <20080217211810.GA15001@1wt.eu> <20080217211922.GA15327@1wt.eu> <4807A9B0.3010108@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755281AbYDQT6p@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4807A9B0.3010108@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Apr 17, 2008 at 03:49:04PM -0400, Jeff Garzik wrote:
> Willy Tarreau wrote:
> >>From 40a8174d27cb9d93b859bc073c8f075b9ff71578 Mon Sep 17 00:00:00 2001
> >From: Willy Tarreau <w@1wt.eu>
> >Date: Sun, 17 Feb 2008 21:11:46 +0100
> >Subject: [PATCH 1/2] libata: implement ATA_IOC_GET_IO32/ATA_IOC_SET_IO32 
> >ioctls
> >
> >This patch implements the aforementionned ioctls and get/set the
> >new ATA_DFLAG_32BIT_PIO ata flag accordingly for the device. It
> >only supports values 0 and 1 (disable/enable), as I have no plan
> >to implement the sync VLB transfers.
> >
> >Signed-off-by: Willy Tarreau <w@1wt.eu>
> 
> this patch should be combined into the second patch, because it's not 
> much use without both

OK will do and resend. I will also add Alan's Acked line.

Regards,
Willy
