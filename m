From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Full hostlock pushdown available
Date: Tue, 2 Nov 2010 18:53:36 +0100
Message-ID: <20101102175336.GA2167@basil.fritz.box>
References: <20101028150508.GA2385@basil.fritz.box>
 <4CCD5F7F.8020808@panasas.com>
 <tkrat.c4793af298337eff@s5r6.in-berlin.de>
 <4CCE271D.7040400@garzik.org>
 <20101101135338.GA25817@basil.fritz.box>
 <4CCEE33F.5030300@garzik.org>
 <20101101175742.GG25817@basil.fritz.box>
 <4CCF0DFE.4050106@garzik.org>
 <20101102092111.GK25817@basil.fritz.box>
 <4CD03578.3050801@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:56186 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753612Ab0KBRxl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Nov 2010 13:53:41 -0400
Content-Disposition: inline
In-Reply-To: <4CD03578.3050801@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andi Kleen <andi@firstfloor.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Boaz Harrosh <bharrosh@panasas.com>, James.Bottomley@suse.de, nab@linux-iscsi.org, linux-scsi@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

> Boaz' approach is OBVIOUSLY mechanical, correct and bisectable.
> Yours is not.

Sorry Jeff, but my patch has 100% the same locking order as Boaz.
The only difference is in which function it is.

-Andi
