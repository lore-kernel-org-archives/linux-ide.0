From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 19/86] pata_cmd640: document known issues
Date: Wed, 25 Nov 2009 18:14:44 +0000
Message-ID: <20091125181444.64c49c90@lxorguk.ukuu.org.uk>
References: <20091125170218.5446.13513.sendpatchset@localhost>
	<20091125170436.5446.83994.sendpatchset@localhost>
	<20091125172633.7a15711b@lxorguk.ukuu.org.uk>
	<200911251834.04189.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53047 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753678AbZKYSMi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 13:12:38 -0500
In-Reply-To: <200911251834.04189.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 25 Nov 2009 18:34:04 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> On Wednesday 25 November 2009 06:26:33 pm Alan Cox wrote:
> > On Wed, 25 Nov 2009 18:04:36 +0100
> > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > 
> > > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > > Subject: [PATCH] pata_cmd640: document known issues
> > > 
> > > Document known issues with the driver to aid distribution makers,
> > > users and developers in making informed decisions instead of wasting
> > > their time needlessly.
> > 
> > Umm. its a) under CONFIG_PCI, and b) says CMD640 PCI IDE...
> 
> c)
> 
>  *      This drives only the PCI version of the controller. If you have a
>  *      VLB one then we have enough docs to support it but you can write
>  *      your own code.
> 
> Then what has happened to CMD640 VLB IDE support in libata?

There is none. Nobody has complained about that either, and in fact I've
not even been able to find a board on ebay to test either driver with
VLB !
