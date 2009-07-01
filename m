From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [patch 4/6] ide: allow ide_dev_read_id() to be called from the IRQ context
Date: Wed, 1 Jul 2009 18:35:27 +0200
Message-ID: <200907011835.27586.bzolnier@gmail.com>
References: <200906240336.25263.bzolnier@gmail.com> <20090624.025518.75726622.davem@davemloft.net> <200906241248.21173.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:58746 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbZGAQ3H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Jul 2009 12:29:07 -0400
In-Reply-To: <200906241248.21173.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 24 June 2009 12:48:20 Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 24 June 2009 11:55:18 David Miller wrote:

[...]

> > I know you're busy, so I'll try to draft something up myself.
> 
> Ok, thanks.

Any news about these fixes?
