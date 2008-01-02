From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 1/3] ide: use MODULE_VERSION()
Date: Wed, 02 Jan 2008 15:40:20 +0100
Message-ID: <477BA254.9010702@s5r6.in-berlin.de>
References: <200801011840.38757.bzolnier@gmail.com>	 <20080101175333.GA27566@does.not.exist>	 <200801011933.43930.bzolnier@gmail.com>	 <1199241156.3300.55.camel@perihelion>	 <20080102044620.GB10762@auslistsprd01.us.dell.com> <1199252790.3300.77.camel@perihelion>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hp3.statik.tu-cottbus.de ([141.43.120.68]:55217 "EHLO
	hp3.statik.tu-cottbus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbYABOlN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jan 2008 09:41:13 -0500
In-Reply-To: <1199252790.3300.77.camel@perihelion>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jon Masters <jonathan@jonmasters.org>
Cc: Matt Domsch <Matt_Domsch@dell.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Adrian Bunk <bunk@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jon Masters wrote:
> On Tue, 2008-01-01 at 22:46 -0600, Matt Domsch wrote:
>> $ modinfo dell_rbu | grep version
>> version:        3.2
>> srcversion:     1D4815D7D6FBEE6612F3C18
> 
> Right. And I was referring to the is above (I forgot it's a CRC32 and
> not a SHA1). But my point is why not codify some "policy" here with
> respect to module versioning, rather than have the latter exist to
> workaround the case that module versions aren't bumped manually.

How about this version scheme:
driver version == Linux kernel version
-- 
Stefan Richter
-=====-==--- ---= ---=-
http://arcgraph.de/sr/
