From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 10/14] drivers/ata/libata: Move dereference after NULL
 test
Date: Tue, 03 Nov 2009 16:17:53 -0500
Message-ID: <4AF09E01.1060205@pobox.com>
References: <Pine.LNX.4.64.0910170841270.9213@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60001 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753842AbZKCVRv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Nov 2009 16:17:51 -0500
In-Reply-To: <Pine.LNX.4.64.0910170841270.9213@ask.diku.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On 10/17/2009 02:41 AM, Julia Lawall wrote:
> From: Julia Lawall<julia@diku.dk>
>
> In each case, if the NULL test on qc is needed, then the derefernce
> should be after the NULL test.
>
> A simplified version of the semantic match that detects this problem is as
> follows (http://coccinelle.lip6.fr/):
>
> //<smpl>
> @match exists@
> expression x, E;
> identifier fld;
> @@
>
> * x->fld
>    ... when != \(x = E\|&x\)
> * x == NULL
> //</smpl>
>
> Signed-off-by: Julia Lawall<julia@diku.dk>

applied


