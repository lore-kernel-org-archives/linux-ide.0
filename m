From: Jon Masters <jonathan@jonmasters.org>
Subject: Re: [PATCH 1/3] ide: use MODULE_VERSION()
Date: Tue, 01 Jan 2008 21:32:36 -0500
Message-ID: <1199241156.3300.55.camel@perihelion>
References: <200801011840.38757.bzolnier@gmail.com>
	 <20080101175333.GA27566@does.not.exist>
	 <200801011933.43930.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dallas.jonmasters.org ([72.29.103.172]:39794 "EHLO
	dallas.jonmasters.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbYABCdQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Jan 2008 21:33:16 -0500
In-Reply-To: <200801011933.43930.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Adrian Bunk <bunk@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2008-01-01 at 19:33 +0100, Bartlomiej Zolnierkiewicz wrote:

> On the second thought: maybe we will be better off with limiting
> MODULE_VERSION() to the device drivers and the IDE core module for now,
> and just removing all these private version numbers from host drivers
> (with one or two exceptions they are not printed or exported currently,
> moreover exceptions are the cases like stale version numbers from 199x)?

Things like checkpatch could help advise people to bump the version
number, but it's a bit iffy. Matt D. actually uses the special source
version modinfo for DKMS - which is different - but it makes me wonder
whether dynamically generating a version based on source SHA1 wouldn't
be a better idea in most cases than an outdated hard-coded one.

Comments?

Jon.


