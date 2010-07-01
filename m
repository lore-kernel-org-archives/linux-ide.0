From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [PATCH 1/3] libata: glob_match for ata_device_blacklist
Date: Thu, 01 Jul 2010 10:36:31 -0500
Message-ID: <1277998591.2813.24.camel@mulgrave.site>
References: <4C2CB497.3000701@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60570 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756862Ab0GAPgg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Jul 2010 11:36:36 -0400
In-Reply-To: <4C2CB497.3000701@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>

On Thu, 2010-07-01 at 11:30 -0400, Mark Lord wrote:
> Replace rudimentry pattern matching with more capable shell-style globbing.
> This will enable shrinking ata_device_blacklist[] table in subsequent patches,
> and helps with future editions to the table, such as matching only the end
> of a firmware revision string etc..

So we have other identical cases of this list to flag matching ... like
in SCSI.  How about we move the mechanics to lib and share the code?

James


