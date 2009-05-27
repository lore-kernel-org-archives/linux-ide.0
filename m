From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/3] ide: add "ignore_hpa" module parameter
Date: Wed, 27 May 2009 10:49:13 +0100
Message-ID: <20090527104913.644e6970@lxorguk.ukuu.org.uk>
References: <200905252344.11826.bzolnier@gmail.com>
	<200905260106.13705.elendil@planet.nl>
	<200905261423.40117.bzolnier@gmail.com>
	<200905261453.22428.elendil@planet.nl>
	<20090526140132.19e8bc13@lxorguk.ukuu.org.uk>
	<20090526180821.GB13276@ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53272 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759153AbZE0JsU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 May 2009 05:48:20 -0400
In-Reply-To: <20090526180821.GB13276@ub>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>
Cc: Frans Pop <elendil@planet.nl>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> Probably I am missing some context, but the above seems to be
> a false statement. The PC partition format does give you
> start and size, and no filesystem knowledge is needed to
> find out where a partition ends.

I am indeed in error. The PC DOS format is indeed fine. I was
remembering from the magneto-opticals and the problem there was you
couldn't tell the size because there were two conflicting standards for
partition encoding.

So that means a distro can detect some of the cases which is even better
and makes a sysfs interface even more useful.

Alan
