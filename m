From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide-iops: fix for drive side 80-wire cable detection
 failure f or IBM-DJNA-371350 HD
Date: Mon, 28 Sep 2009 14:29:32 +0100
Message-ID: <20090928142932.0023cb69@lxorguk.ukuu.org.uk>
References: <20090927.193419.17010.1@webmail21.vgs.untd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41722 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752861AbZI1N2O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Sep 2009 09:28:14 -0400
In-Reply-To: <20090927.193419.17010.1@webmail21.vgs.untd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Gavlick <mgavl69@juno.com>
Cc: linux-ide@vger.kernel.org, davem@davemloft.net

On Sun, 27 Sep 2009 23:34:19 GMT
"Michael Gavlick" <mgavl69@juno.com> wrote:

>   The IDE driver complains about an 80-wire cable detection failure and falls back to UDMA/33 for the old IBM-DJNA-371350 Rev. J7NOA30K HD even though it is an UDMA/66 HD.

You need to verify that this isn't a problem with the controller, the
driver or the configuration before submitting such a patch.

It's a very common drive so the fact nobody has reported it before makes
me extremely suspicious of your report being a true IVB error - the drive
is also rather new for that bug.

Alan
