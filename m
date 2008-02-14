From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 11/11] ata: fix sparse warnings in pata_legacy.c
Date: Thu, 14 Feb 2008 12:02:06 +0000
Message-ID: <20080214120206.1a52f77d@core>
References: <3ad7c41048d88a3f8aad098570b9fac9ff719aff.1202965399.git.harvey.harrison@gmail.com>
	<1202966072.2748.27.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41681 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756963AbYBNMJq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 07:09:46 -0500
In-Reply-To: <1202966072.2748.27.camel@brick>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

On Wed, 13 Feb 2008 21:14:32 -0800
Harvey Harrison <harvey.harrison@gmail.com> wrote:

> Let's use ld for legacy_data instead of shadowing these static
> int variables.

NAK - I purposefully used names that indicate what device the private
data is being used for in order to make it clear. Changing qdi and
winbond to ld_qdi and ld_winbond would avoid that and fix the shadowing
of the static value.

Alan
