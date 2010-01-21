From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstream 2/2] libata: implement spurious irq handling
 for SFF and apply it to piix
Date: Thu, 21 Jan 2010 12:14:45 +0000
Message-ID: <20100121121445.71c807b9@lxorguk.ukuu.org.uk>
References: <4B550EF8.1000009@kernel.org>
	<4B550F9F.80503@kernel.org>
	<4B575A84.3030005@garzik.org>
	<4B579582.4050806@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44329 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752894Ab0AUMRR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Jan 2010 07:17:17 -0500
In-Reply-To: <4B579582.4050806@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Hans Werner <hwerner4@gmx.de>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Hmmm... I was a bit worried about the case Alan mentioned several
> times where access to AltStatus while data transfer is going on can
> lead to silent data corruption.

PIIX4 Erratum #15
440MX Erratum #13
PIIX4E Erratum #16

http://www.intel.com/design/chipsets/specupdt/29063508.pdf

