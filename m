From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] pata_legacy: export functionality to ide
Date: Sun, 3 Aug 2008 12:59:07 +0100
Message-ID: <20080803125907.67676948@lxorguk.ukuu.org.uk>
References: <20080715053356.GA18628@gollum.tnic>
	<200808021902.12191.bzolnier@gmail.com>
	<20080802183253.GA2239@gollum.tnic>
	<200808022046.16990.bzolnier@gmail.com>
	<20080803073756.GA8762@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:47351 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753572AbYHCMQe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Aug 2008 08:16:34 -0400
In-Reply-To: <20080803073756.GA8762@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: petkovbb@googlemail.com, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, alan@redhat.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sun, 3 Aug 2008 09:37:56 +0200
Borislav Petkov <petkovbb@googlemail.com> wrote:

> Ok, here's a definitely better solution:

Please don't stuff large important pieces of code in header files where
they will be overlooked

NAK this.

I'm happy to have a shared library directory for ATA stuff, containing
useful C code, but hiding stuff in headers like that is just plain wrong.

