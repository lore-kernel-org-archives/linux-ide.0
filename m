From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 00/86] PATA fixes
Date: Thu, 03 Dec 2009 17:22:38 -0500
Message-ID: <4B183A2E.5080402@garzik.org>
References: <20091125170218.5446.13513.sendpatchset@localhost> <200912032256.39790.bzolnier@gmail.com> <4B18357C.8070807@garzik.org> <200912032306.52022.bzolnier@gmail.com> <4B18376B.3080404@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:56714 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893AbZLCWWe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2009 17:22:34 -0500
In-Reply-To: <4B18376B.3080404@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/03/2009 05:10 PM, Jeff Garzik wrote:
> Did the patch contain -cosmetic- changes intermingled with code changes,
> in the same code lines? No.
>
> Is it good kernel practice to intermingle cosmetic changes with
> functional ones, in the same code lines? Also, no.


In fact, I recall one case where a certain developer on this list used 
cosmetic code changes (Lindent, IIRC) to hide functional, 
security-related code changes.

Mixing cosmetic and function changes is simply bad engineering practice, 
_especially_ when they occur in the same lines of code.

	Jeff



