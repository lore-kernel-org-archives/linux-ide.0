From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_sil680: remove duplicate pcim_enable_device
Date: Fri, 29 Aug 2008 16:50:24 +0100
Message-ID: <20080829165024.6d2ff573@lxorguk.ukuu.org.uk>
References: <20080829153628.GA20130@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:38219 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751732AbYH2QKP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Aug 2008 12:10:15 -0400
In-Reply-To: <20080829153628.GA20130@dhcp-210.hsv.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

On Fri, 29 Aug 2008 10:36:28 -0500
David Milburn <dmilburn@redhat.com> wrote:

> Remove duplicate call to pcim_enable_device in sil680_init_one.
> 
> Signed-off-by: David Milburn <dmilburn@redhat.com>

Acked-by: Alan Cox <alan@redhat.com>

Doh.. ;)
