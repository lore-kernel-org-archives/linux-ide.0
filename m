From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] pata_legacy: export functionality to ide
Date: Sun, 3 Aug 2008 14:39:39 +0100
Message-ID: <20080803143939.37a74bf5@lxorguk.ukuu.org.uk>
References: <20080715053356.GA18628@gollum.tnic>
	<20080803073756.GA8762@gollum.tnic>
	<20080803125907.67676948@lxorguk.ukuu.org.uk>
	<200808031537.41224.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:59444 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755124AbYHCN5n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Aug 2008 09:57:43 -0400
In-Reply-To: <200808031537.41224.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: petkovbb@gmail.com, petkovbb@googlemail.com, alan@redhat.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

> The code in question is 65 LOC total (43 LOC without counting comments)
> so having a shared library just for it sounds like an overkill and we may

People expect code in C files, so in headers it gets missed as well as
dumped in a directory with no correlation between file name and subsystem.

> just copy that one function from pata_legacy to ide_generic instead.

If you are going to  #include two copies you might as well just copy it.

Alan
