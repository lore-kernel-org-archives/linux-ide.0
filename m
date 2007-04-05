From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] add correct interrupt property for pegasos ide
Date: Thu, 05 Apr 2007 11:46:29 +1000
Message-ID: <1175737590.30879.105.camel@localhost.localdomain>
References: <20070404111635.GA1855@aepfle.de>
	 <20070404162004.GA3016@aepfle.de> <200704042010.50088.bzolnier@gmail.com>
	 <20070404181138.GA6050@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:40858 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998AbXDEBqt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Apr 2007 21:46:49 -0400
In-Reply-To: <20070404181138.GA6050@aepfle.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, Paul Mackeras <paulus@samba.org>, linux-ide@vger.kernel.org

On Wed, 2007-04-04 at 20:11 +0200, Olaf Hering wrote:
> On Wed, Apr 04, Bartlomiej Zolnierkiewicz wrote:
> 
> > ?
> 
> You are right, I did not test the ide driver again. pata_via works with
> the change. 

Probably only the first channel works...

Ben.


