From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide-iops: fix for drive side 80-wire cable detection
 failu re f or IBM-DJNA-371350 HD
Date: Mon, 28 Sep 2009 19:19:03 +0100
Message-ID: <20090928191903.1585f086@lxorguk.ukuu.org.uk>
References: <20090928.131808.29003.0@webmail06.vgs.untd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44281 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752287AbZI1SRt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Sep 2009 14:17:49 -0400
In-Reply-To: <20090928.131808.29003.0@webmail06.vgs.untd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Gavlick <mgavl69@juno.com>
Cc: mikpe@it.uu.se, linux-ide@vger.kernel.org, davem@davemloft.net

On Mon, 28 Sep 2009 17:18:08 GMT
"Michael Gavlick" <mgavl69@juno.com> wrote:

>   I've tested only on my own rig with 'known good' 80-wire cables and similar UDMA/66 HD's from Quantum & Seagate without any problems as a single master and a master/slave setup.
>   I've also tested the IBM-DJNA-371350 as a single master but it still complains about the 80-wire.

Ideally this wants testing on a different controller but can you post the
hdparm output and see what value Word 93 is showing. Does sound like this
one may indeed be the drive, or at least some specific firmware rev. The
22GXP is a bit late for such a bug but not unbelievably so.

Nothing obvious in kernel logs google can find to contradict your finding
either.

Alan



