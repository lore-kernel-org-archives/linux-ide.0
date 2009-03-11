From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [PATCH] ide: add support for CFA specified transfer modes (take 3)
Date: Tue, 10 Mar 2009 21:28:11 -0400
Message-ID: <200903102128.11782.stf_xl@wp.pl>
References: <200903102242.58158.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:52048 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752600AbZCJUSA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Mar 2009 16:18:00 -0400
In-Reply-To: <200903102242.58158.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, Cezary Manista <cezary.manista@gmail.com>

On Tuesday 10 March 2009 15:42, Sergei Shtylyov wrote:
> Add support for the CompactFlash specific PIO modes 5/6 and MWDMA modes
> 3/4.
[snip]
> Stanislaw, please give it a try -- I don't have any CF hardware now... :-/

I wish to, but  I changed my job with the beginning of March.
Cezary (CCed) from Kelvatek told me, they will work on any
futher testing and development related with at91_ide.

>From my side I could tell that I will make code revisions and compile
tests/fixes but now I must return -EBUSY.

Cheers
Stanislaw Gruszka
