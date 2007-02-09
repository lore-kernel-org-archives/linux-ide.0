From: "David M. Lloyd" <dmlloyd@flurg.com>
Subject: Re: [PATCH] AHCI PCI ID for MacBook Pro
Date: Fri, 09 Feb 2007 08:54:53 -0600
Message-ID: <1171032893.8134.13.camel@localhost>
References: <82530.66623.qm@web25412.mail.ukl.yahoo.com>
	 <45CC3FE5.2010408@gmail.com>  <200702091527.08447.rootkit85@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound1.mail.tds.net ([216.170.230.91]:35198 "EHLO
	outbound1.mail.tds.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731AbXBKFHx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Feb 2007 00:07:53 -0500
In-Reply-To: <200702091527.08447.rootkit85@yahoo.it>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matteo Croce <rootkit85@yahoo.it>
Cc: linux-ide@vger.kernel.org

On Fri, 2007-02-09 at 15:27 +0100, Matteo Croce wrote:
> +	{ PCI_VDEVICE(INTEL, 0x27c4), board_ahci }, /* ICH7M */

Wasn't this PCI ID proposed for addition a while ago, and subsequently
rejected?  Or am I missing something?

- DML

