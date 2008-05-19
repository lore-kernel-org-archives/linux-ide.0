From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC: 2.6 patch] remove BLK_DEV_HD_ONLY
Date: Mon, 19 May 2008 22:50:18 +0100
Message-ID: <20080519225018.1df63bef@core>
References: <20080519215357.GH17716@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:43242 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1764723AbYESWCQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 May 2008 18:02:16 -0400
In-Reply-To: <20080519215357.GH17716@cs181133002.pp.htv.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

On Tue, 20 May 2008 00:53:57 +0300
Adrian Bunk <bunk@kernel.org> wrote:

> This was the oldest and most limited of the three IDE drivers we ship.

NAK - it isn't just an IDE driver it's an MFM/RLL driver as well. It's
one of the few things suitable for rescuing ancient drives so should be
retained.
