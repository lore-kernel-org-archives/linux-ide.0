From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 05/11] ata: replace macro with static inline in libata.h
Date: Thu, 14 Feb 2008 12:01:01 +0000
Message-ID: <20080214120101.150a3284@core>
References: <3ad7c41048d88a3f8aad098570b9fac9ff719aff.1202965399.git.harvey.harrison@gmail.com>
	<1202966058.2748.19.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41677 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754556AbYBNMIq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 07:08:46 -0500
In-Reply-To: <1202966058.2748.19.camel@brick>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

On Wed, 13 Feb 2008 21:14:18 -0800
Harvey Harrison <harvey.harrison@gmail.com> wrote:

> Avoid a metric ton of sparse warnings like:
> drivers/ata/pata_ali.c:176:14: warning: symbol '__x' shadows an earlier one
> drivers/ata/pata_ali.c:176:14: originally declared here

NAK that appears to be a sparse bug.

1-4/6-10 Acked-by: Alan Cox <alan@redhat.com>

Alan
