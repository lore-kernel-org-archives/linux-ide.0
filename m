From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/3] ide: add "vlb|pci_clock=" parameter
Date: Sat, 22 Mar 2008 20:31:32 +0300
Message-ID: <47E54274.8020805@ru.mvista.com>
References: <200803221722.11689.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:10726 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753774AbYCVRaO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 22 Mar 2008 13:30:14 -0400
In-Reply-To: <200803221722.11689.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Bartlomiej Zolnierkiewicz wrote:

> * Add "vlb_clock=" parameter for specifying VLB clock frequency (in MHz).

> * Add "pci_clock=" parameter for specifying PCI bus clock frequency (in MHz).

> While at it:

> * qd65xx.c: rename {active,recovery}_cycle variables to {act,rec}_cyc.

> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
