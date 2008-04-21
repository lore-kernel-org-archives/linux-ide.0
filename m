From: Jeff Garzik <jgarzik@redhat.com>
Subject: Re: [2.6 patch] make sata_set_spd_needed() static
Date: Mon, 21 Apr 2008 04:57:32 -0400
Message-ID: <20080421085732.GR12215@devserv.devel.redhat.com>
References: <20080421085117.GC26897@cs181133002.pp.htv.fi>
Reply-To: jgarzik@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:57126 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754402AbYDUI5n (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Apr 2008 04:57:43 -0400
Content-Disposition: inline
In-Reply-To: <20080421085117.GC26897@cs181133002.pp.htv.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Apr 21, 2008 at 11:51:17AM +0300, Adrian Bunk wrote:
> sata_set_spd_needed() can now become static.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

For future reference...  please don't email jgarzik@redhat.com unless
its an NDA issue or similar.  That email is only for signed-off-by
lines, never for actual email (you never see me post to a list
@redhat.com, nor will you see me in git as /author/ @redhat.com)

After leaving MandrakeSoft for Red Hat several years ago, I found it
wise to point everybody to a generic email (jgarzik@pobox.com) rather
than an email address ultimately out of my control.

Anyway, a humble request from me to you,

	Jeff



