From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 85/86] libata: add ->init_host method
Date: Wed, 25 Nov 2009 17:56:08 +0000
Message-ID: <20091125175608.5e1b5442@lxorguk.ukuu.org.uk>
References: <20091125170218.5446.13513.sendpatchset@localhost>
	<20091125171240.5446.31841.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:54954 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757628AbZKYRyD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 12:54:03 -0500
In-Reply-To: <20091125171240.5446.31841.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

On Wed, 25 Nov 2009 18:12:40 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] libata: add ->init_host method
> 
> Add ->init_host method for re-initialization of the controller
> in ata_pci_device_resume().

Would be much cleaner if the init_host method was in the ops stuff
somewhere rather than assigned all over the place separately - because
then folks forget and its not part of the inheriting.

Definitely a good thing though
