From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: IRQ anomaly
Date: Thu, 4 Jan 2007 10:52:07 +0000
Message-ID: <20070104105207.5a149863@localhost.localdomain>
References: <459CD489.7090607@openoffice.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47755 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932371AbXADKlu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Jan 2007 05:41:50 -0500
In-Reply-To: <459CD489.7090607@openoffice.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Valentijn Sessink <v.sessink@openoffice.nl>
Cc: linux-ide@vger.kernel.org

On Thu, 04 Jan 2007 11:18:49 +0100
Valentijn Sessink <v.sessink@openoffice.nl> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi,
> 
> We had a problem with a server running Ubuntu Dapper kernel 2.6.15
> (Ubuntu version 2.6.15-27-686) and Intel 82801GB/GR/GH with sw-raid on

2.6.15 is a very very old libata and lots of problems have been fixed
since then, including some that do sound rather like your description.

Alan
