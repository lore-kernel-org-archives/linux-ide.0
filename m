From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_rdc: parallel scanning needs an extra locking
Date: Thu, 13 Oct 2011 16:49:23 +0100
Message-ID: <20111013164923.23683fcb@lxorguk.ukuu.org.uk>
References: <201110131606.04496.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53086 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755372Ab1JMPuu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Oct 2011 11:50:50 -0400
In-Reply-To: <201110131606.04496.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 13 Oct 2011 16:06:04 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] pata_rdc: parallel scanning needs an extra locking
> 
> This is similar change as commit 60c3be3 ("ata_piix: parallel scanning
> on PATA needs an extra locking") for ata_piix host driver.

Again has anyone verified with the vendor that the RDC can support
parallel scanning ?
