From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Re: sil3112 problems
Date: Sun, 30 Oct 2005 23:38:09 +1100
Message-ID: <4364BEB1.1080702@eyal.emu.id.au>
References: <43616D7B.30100@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ihug-mail.icp-qv1-irony3.iinet.net.au ([203.59.1.197]:21037
	"EHLO ihug-mail.icp-qv1-irony3.iinet.net.au") by vger.kernel.org
	with ESMTP id S932142AbVJ3MiO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Oct 2005 07:38:14 -0500
In-Reply-To: <43616D7B.30100@eyal.emu.id.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: list linux-ide <linux-ide@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>

Eyal Lebedinsky wrote:
> This is on 2.6.13.4. I had the same with 2.6.14-rc5 but went off it
> because my i2c sensors failed to come up here (separate issue).

I sorted out my sensors issue and now moved to 2.6.14. Same problem.

So, where do I stand with SATA? I just want a few (two for now) extra
SATA channels - how should I proceed?

Any boot options that will make it more stable? PIO will be too slow
but I can take some slowdown (a few video streams is all I expect
to need).

TIA

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
