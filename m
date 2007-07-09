From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 02/11] pata_acpi: restore driver
Date: Mon, 9 Jul 2007 23:07:48 +0100
Message-ID: <20070709230748.0c4fb5e3@the-village.bc.nu>
References: <200707091846.l69IkClC001368@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34313 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754265AbXGIWBh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jul 2007 18:01:37 -0400
In-Reply-To: <200707091846.l69IkClC001368@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@redhat.com, htejun@gmail.com

On Mon, 09 Jul 2007 11:46:12 -0700
akpm@linux-foundation.org wrote:

> From: Alan Cox <alan@redhat.com>
> 
> This patch assumes the mode filter patches were applied, if not then ping
> me and I'll send the trivially different patch (extra argument to
> mode_filter)

Can we leave this for a moment. I want to do some reworking on it next
week and redo it based upon experience of what ACPI bios code actually
seems to be doing and a ton of info about how the Windoze one uses it
