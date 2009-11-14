From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] libata: prepare for removal of experimental tag on PATA drivers
Date: Sat, 14 Nov 2009 17:53:37 +0100
Message-ID: <200911141753.37935.bzolnier@gmail.com>
References: <200911141537.19068.bzolnier@gmail.com> <4AFED444.5020201@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:63266 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754504AbZKNQyd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Nov 2009 11:54:33 -0500
In-Reply-To: <4AFED444.5020201@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 14 November 2009 17:01:08 Robert Hancock wrote:
> On 11/14/2009 08:37 AM, Bartlomiej Zolnierkiewicz wrote:
> > Push experimental tags to host drivers that still need it so we can
> > remove the "global" experimental tag for PATA drivers.
> >
> > I hear that some issues are being worked on but the patch reflects
> > the current situation and we can trivially update status of affected
> > host drivers after new fixes are merged.
> >
> > Signed-off-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> 
> I don't think that the problems you've mentioned fit the definition of 
> the EXPERIMENTAL tag - it means that the driver isn't likely suitable 

I guess you've read bugzillas so if you still think that EXPERIMENTAL
is not justified at least for some drivers than we really have nothing
to talk about anymore..

> for general use. Given that those drivers are probably used by 
> significant numbers of people successfully in various distributions I 
> don't think this is likely to be the case. There may be bugs but 
> non-experimental does not imply bug free.

Hardly a technical argument.

You know that staging drivers are successfully used by
"significant numbers of people successfully in various distributions"?

:)

zbr explained the problem with the kernel development process with more
class than I would ever be able to so I will just save everybody's time..

-- 
Bartlomiej Zolnierkiewicz
