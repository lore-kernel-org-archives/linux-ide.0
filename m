From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/12] ali14xx: add "vlb_clock=" parameter
Date: Sat, 15 Mar 2008 12:36:14 +0000
Message-ID: <20080315123614.6c548306@the-village.bc.nu>
References: <20080313224352.7051.44005.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44960 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751706AbYCOM5o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Mar 2008 08:57:44 -0400
In-Reply-To: <20080313224352.7051.44005.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

On Thu, 13 Mar 2008 23:43:52 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> Add "vlb_clock=" parameter for specifying VLB clock frequency (in MHz).
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Surely this value should be set once per system (ditto for PCI) not
something you have to set in each specific driver on the box ?
