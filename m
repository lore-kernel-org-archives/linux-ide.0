From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 25/30] pata_hpt3x3: clean up by using cable method
Date: Tue, 6 Mar 2007 16:27:30 +0000
Message-ID: <20070306162730.6ece1ec9@lxorguk.ukuu.org.uk>
References: <200703061038.l26AcAVD019539@shell0.pdx.osdl.net>
	<45ED57BA.4000800@garzik.org>
	<20070306151959.2c30b606@lxorguk.ukuu.org.uk>
	<45ED79DE.7000702@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:45611 "EHLO lxorguk.ukuu.org.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S965916AbXCFPXz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 10:23:55 -0500
In-Reply-To: <45ED79DE.7000702@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, alan@redhat.com

On Tue, 06 Mar 2007 09:25:34 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> through intuition and simple observation, without having to resort to 
> git bisect.

Well if you want one patch you can have one patch. It'll be a while as
I'm still converting drivers over and I'll feed them one by one for real
world testing/verifying to Andrew first. Some like the Jmicron and
pata_sis aren't so trivial although are well worth doing.

Alan
