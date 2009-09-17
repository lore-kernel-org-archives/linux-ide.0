From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata:ide: Fix udma timings of pdc202xx_old
 controllers
Date: Fri, 18 Sep 2009 00:23:22 +0100
Message-ID: <20090918002322.54099f94@lxorguk.ukuu.org.uk>
References: <8b5805ff0909171602v3dc10db9i5920be3a2abf2e04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:39376 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750741AbZIQXWU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Sep 2009 19:22:20 -0400
In-Reply-To: <8b5805ff0909171602v3dc10db9i5920be3a2abf2e04@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Jung-Ik (John) Lee" <jilee@google.com>
Cc: sshtylyov@ru.mvista.com, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 17 Sep 2009 16:02:31 -0700
"Jung-Ik (John) Lee" <jilee@google.com> wrote:

> From: John(Jung-Ik) Lee <jilee@google.com>
> 
> Fix udma timings of pdc202xx_old controllers.
> MB=1, MC=1 (0x20, 0x01) for all UDMA modes of pdc2026{57}.

On what documentation is this based ?

Alan
