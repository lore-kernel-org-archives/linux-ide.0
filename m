From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Add Seagate STT20000A to DMA blacklist.
Date: Mon, 21 May 2007 17:15:51 +0100
Message-ID: <20070521171551.0f81a0be@the-village.bc.nu>
References: <20070521145042.GA6957@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55426 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755131AbXEUQLN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 May 2007 12:11:13 -0400
In-Reply-To: <20070521145042.GA6957@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, bzolnier@gmail.com, linux-ide@vger.kernel.org

On Mon, 21 May 2007 10:50:42 -0400
Dave Jones <davej@redhat.com> wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=1044
> has been open for _four_ years with a patch available.
> Here's a rediffed version of the same.

Please update libata as well when you udpate the blacklists.

Alan
