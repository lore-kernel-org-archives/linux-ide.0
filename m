From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2.6.19-rc1] Toshiba TC86C001 IDE driver
Date: Wed, 13 Dec 2006 01:57:02 +0300
Message-ID: <200612130157.02249.sshtylyov@ru.mvista.com>
References: <200612130148.34539.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:6765 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932555AbWLLWzc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Dec 2006 17:55:32 -0500
In-Reply-To: <200612130148.34539.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Hello.

On Wednesday 13 December 2006 01:48, Sergei Shtylyov wrote:
> Behold!  This is the driver for the Toshiba TC86C001 GOKU-S IDE controller,
> completely reworked from the original brain-damaged Toshiba's 2.4 version.

   Shoot, the patch is actually against the most recent Linus' tree, so
it's 2.6.20-rc1...

   Andrew, 2.6.19-rc6-mm2 series keeps failing to completely apply to 
2.6.19-rc6 head in my git repo -- don't know why, maybe that's my git...
Hence the patch was againt Linus' tree.

WBR, Sergei

