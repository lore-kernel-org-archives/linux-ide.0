From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Tue, 7 Aug 2007 09:56:29 -0300
Message-ID: <20070807125629.GD30661@khazad-dum.debian.net>
References: <1186411815.4355.7.camel@nx6310> <20070806150159.GC31615@khazad-dum.debian.net> <200708061732.03425.rjw@sisk.pl> <46B75459.9020204@gmail.com> <1186424492.4355.1.camel@nx6310> <46B76BBC.9010107@gmail.com> <1186438698.4402.6.camel@nx6310> <46B817AB.30105@gmail.com> <1186478319.3705.3.camel@nx6310> <46B83C0B.8050902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35196 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934241AbXHGM4c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2007 08:56:32 -0400
Content-Disposition: inline
In-Reply-To: <46B83C0B.8050902@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Michael Sedkowski <sedmich@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, 07 Aug 2007, Tejun Heo wrote:
> emergency unload.  Emergency unload does shorten the lifespan of the
> disk but you don't have to worry too much about it.  Disks are designed
> to withstand certain number of emergency unloads.

You *do* have to worry about it in any box you turn off daily.  Desktop HDs
will croak fast in that scenario, laptop HDs less so, but still too fast.

A very good laptop HD can last about 20k emergency unloads (this is a unit
that can do about 600k normal unloads in its lifetime).  Desktop and server
HDs don't even come close to those numbers, last time I checked.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
