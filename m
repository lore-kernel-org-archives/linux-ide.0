From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_cs5520: remove incorrect warning message
Date: Tue, 11 Oct 2011 20:56:16 +0100
Message-ID: <20111011205616.15d0b3b3@lxorguk.ukuu.org.uk>
References: <201110112000.44960.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:35151 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932065Ab1JKT44 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Oct 2011 15:56:56 -0400
In-Reply-To: <201110112000.44960.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 11 Oct 2011 20:00:44 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] pata_cs5520: remove incorrect warning message
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Nothing incorrect about it. It's rather useful information for debugging
CS5520 problems. Users should never see it - and I've not seen it
occuring on any standard VSA releases.

Do you have any examples of it confusing users or even showing up ? 

Alan
