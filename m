From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata: hpt366: fix incorrect mask when checking at
 cmd_high_time
Date: Mon, 18 Jul 2016 21:14:41 +0100
Message-ID: <20160718211441.086dfbef@lxorguk.ukuu.org.uk>
References: <1468322179-9398-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:51958 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbcGRUO7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jul 2016 16:14:59 -0400
In-Reply-To: <1468322179-9398-1-git-send-email-colin.king@canonical.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: kernel-tram@lists.ubuntu.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 12 Jul 2016 12:16:19 +0100
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> According to the HPT366 data sheet, PCI config space dword 0x40-0x43
> bits 11:8 specify the primary drive cmd_high_time, however,
> currently just 3 bits of the 4 are being used because the mask
> is 0x700 and not 0x0f00.  Fix the mask, allowing for the 40MHz clock
> to be detected.

Is this tested on real hardware ? I learned long ago never to blindly
trust IDE data sheets. It looks right but if anyone actually has a 40MHz
PCI bus box with an HPT366 it would be good to test.

Alan
