From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: [PATCH] ata: ahci: power off unused ports
Date: Fri, 9 May 2008 12:14:56 -0400
Message-ID: <20080509161456.GF6957@csclub.uwaterloo.ca>
References: <20080508161008.59361de5@appleyard> <20080508233713.GB15377@srcf.ucam.org> <20080509155830.GE6957@csclub.uwaterloo.ca> <20080509160641.GA30219@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caffeine.csclub.uwaterloo.ca ([129.97.134.17]:47890 "EHLO
	caffeine.csclub.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753382AbYEIQO5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 May 2008 12:14:57 -0400
Content-Disposition: inline
In-Reply-To: <20080509160641.GA30219@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, May 09, 2008 at 05:06:41PM +0100, Matthew Garrett wrote:
> Genuinely SATA, or PATA bridged to SATA?

SATA drives using intel 945GM chipset which has two native SATA ports.

-- 
Len Sorensen
