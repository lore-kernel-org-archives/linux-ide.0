From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata: Add Intel SCH PATA support
Date: Mon, 28 Apr 2008 10:16:01 +0100
Message-ID: <20080428101601.1e31156b@core>
References: <20080426140007.63cfeede@dxy.sh.intel.com>
	<20080426103012.21dcf0fb@core>
	<20080427075115.3ea40204@dxy.sh.intel.com>
	<20080427093434.182a2137@core>
	<20080427220315.794a6df3@dxy.sh.intel.com>
	<20080427153111.3438dce8@core>
	<20080428092056.1e710a45@dxy.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56971 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757753AbYD1JXR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Apr 2008 05:23:17 -0400
In-Reply-To: <20080428092056.1e710a45@dxy.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alek Du <alek.du@intel.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

> Let's regard SCH PATA controller is an usually "broken" one :-), what do you suggest me to work around it?
> Force it to 40-wire pin? or use a KConfig option to select 40-wire or 80-wire?

The drive side detect depends upon hardware features. If the correct
capacitors are present in the design then the drive side detect should
work. 

Alan
