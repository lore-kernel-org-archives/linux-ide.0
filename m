From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] hpt366: remove dead old timing tables
Date: Wed, 18 Nov 2009 18:42:55 +0000
Message-ID: <20091118184255.40febcf0@lxorguk.ukuu.org.uk>
References: <200911181932.07651.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51544 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754365AbZKRSl0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Nov 2009 13:41:26 -0500
In-Reply-To: <200911181932.07651.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: David Miller <davem@davemloft.net>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 18 Nov 2009 19:32:07 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> It has been enough time since introduction of the new timing tables
> (commit 809b53c from Dec 12 2007) and the old timing tables are still
> available in pata_hpt37x.c (or git history) if somebody needs them.

(and in the HPT driver...)

Acked-by: Alan Cox <alan@linux.intel.com>
