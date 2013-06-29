From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: SATA hdd refuses to reallocate a sector?
Date: Sat, 29 Jun 2013 15:47:16 -0300
Message-ID: <20130629184716.GA9330@khazad-dum.debian.net>
References: <20130623101940.GA4448@amd.pavel.ucw.cz>
 <51C76858.4060906@pobox.com>
 <20130623215100.GA7414@amd.pavel.ucw.cz>
 <201306240914.29502.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39675 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752383Ab3F2SrU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Jun 2013 14:47:20 -0400
Content-Disposition: inline
In-Reply-To: <201306240914.29502.linux@rainbow-software.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Pavel Machek <pavel@ucw.cz>, Mark Lord <mlord@pobox.com>, Marcus Overhagen <marcus.overhagen@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, tj@kernel.org

You know, either the "long" or the "offline" SMART test routines do exactly
that on any spinning rust device with a firmware that is not utterly broken.

The HDD's firmware will rewrite, and even reallocate any "weak" sectors
found by the surface scan.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
