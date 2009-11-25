From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 03/86] pata_artop: add 32-bit PIO support
Date: Wed, 25 Nov 2009 17:12:42 +0000
Message-ID: <20091125171242.70b8019f@lxorguk.ukuu.org.uk>
References: <20091125170218.5446.13513.sendpatchset@localhost>
	<20091125170239.5446.26287.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934787AbZKYRRk@vger.kernel.org>
In-Reply-To: <20091125170239.5446.26287.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, 25 Nov 2009 18:02:39 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] pata_artop: add 32-bit PIO support
> 
> There shouldn't be any problems with it as IDE aec62xx host driver
> has been allowing 32-bit PIO operations for years.

Allowing or defaulting too ?
